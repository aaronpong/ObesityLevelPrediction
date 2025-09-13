##FINAL PROJECT STAT654 OBESITY LOGISTIC REGRESSION##
##Aaron PONGSUGREE##

if (file.exists("data/ObesityDataSet_raw_and_data_sinthetic.csv")) {
  obesity.data <- read.csv("data/ObesityDataSet_raw_and_data_sinthetic.csv")
  cat("✓ Data loaded successfully from data folder\n")
  View(obesity.data)
} else if (file.exists("ObesityDataSet_raw_and_data_sinthetic.csv")) {
  # Fallback: check current directory
  obesity.data <- read.csv("ObesityDataSet_raw_and_data_sinthetic.csv")
  cat("✓ Data loaded successfully from current directory\n")
  View(obesity.data)
} else {
  # Help the user troubleshoot
  cat("❌ Data file not found!\n")
  cat("Current working directory:", getwd(), "\n")
  cat("Files in current directory:", paste(list.files(), collapse = ", "), "\n")
  if (dir.exists("data")) {
    cat("Files in data directory:", paste(list.files("data"), collapse = ", "), "\n")
  }
  cat("\nTroubleshooting:\n")
  cat("1. Make sure you're running this script from the repository root folder\n")
  cat("2. Ensure 'ObesityDataSet_raw_and_data_sinthetic.csv' is in the 'data' folder\n")
  stop("Please fix the file path and try again.")
}
View(obesity.data)

##data cleaning and adjusting
#changing categorical and integer variables to factors
str(obesity.data)
obesity.data$NObeyesdad = factor(obesity.data$NObeyesdad, ordered = TRUE)
obesity.data$Gender = factor(obesity.data$Gender)
obesity.data$family_history_with_overweight = factor(obesity.data$family_history_with_overweight)
obesity.data$FAVC = factor(obesity.data$FAVC)
obesity.data$SMOKE = factor(obesity.data$SMOKE)
obesity.data$SCC = factor(obesity.data$SCC)
obesity.data$MTRANS = factor(obesity.data$MTRANS)


#have to round the columns first because the ML algorithm gave outputs in between levels
#they are ordinal integers as well
obesity.data$FCVC = round(obesity.data$FCVC)
obesity.data$FCVC = factor(obesity.data$FCVC, levels = 1:3, labels = c("Never", "Sometimes", "Always"), 
                            ordered = TRUE)
obesity.data$TUE = round(obesity.data$TUE)
obesity.data$TUE = factor(obesity.data$TUE, levels = 0:2, labels = c("0-2 hours", "3-5 hours", "More than 5 hours"),
                          ordered = TRUE)
#rounding these based off the answers in the survey
obesity.data$Age = round(obesity.data$Age)
obesity.data$NCP = round(obesity.data$NCP)
obesity.data$CH2O = round(obesity.data$CH2O)
obesity.data$FAF = round(obesity.data$FAF)
#change some categorical factors to ordinal based on the answers in the survey
obesity.data$CAEC = factor(obesity.data$CAEC, levels = c("no", "Sometimes", "Frequently", "Always"),
                           ordered = TRUE)
obesity.data$CALC = factor(obesity.data$CALC, levels = c("no", "Sometimes", "Frequently", "Always"),
                           ordered = TRUE)

#summary statistics on obesity level outcomes
freq_table <- table(obesity.data$NObeyesdad)
print(freq_table)
options(repr.plot.width=8, repr.plot.height=4)
barplot(freq_table, 
        main = "Frequency of BMI Categories",
        xlab = "BMI Categories",
        ylab = "Frequency",
        col = "lightblue",
        border = "black",
        las = 2)
prop_table <- prop.table(freq_table)
print(prop_table)
barplot(prop_table, 
        main = "Proportion of BMI Categories",
        xlab = "BMI Categories",
        ylab = "Proportion",
        col = "lightblue",
        border = "black",
        las = 2)

summary(obesity.data$NObeyesdad)
table(obesity.data$NObeyesdad) / nrow(obesity.data) * 100

#correlation matrix of continuous variables
continuous_vars <- c("Age", "Height", "Weight", "NCP", "CH2O", "FAF")
correlation_matrix <- cor(obesity.data[, continuous_vars])
print(correlation_matrix)
correlation_matrix <- cor(obesity.data[, -which(names(obesity.data) == "NObeyesdad")])
print(correlation_matrix)

#checking assumptions
#independence
#scatterplot matrix for continuous variables
library(GGally)
ggpairs(obesity.data, columns = c("Age", "Height", "Weight", "NCP", "CH2O", "FAF"))
#multicollinearity




#multinomial logistic regression model
library(nnet)

mlog <- multinom(NObeyesdad ~ ., data = obesity.data)
summary(mlog)
library(car)
vif(mlog)


#AIC stepwise selection
library(MASS)
final_model <- stepAIC(mlog, direction = "both")
summary(final_model)
final_model
vif(final_model)
exp(coef(final_model))

# install.packages("nnet")
library(nnet)
confint(final_model)

str(summary(final_model))
summary(final_model)$standard.errors

#linearity
fitted_values <- predict(final_model, type = "probs")
par(mfrow=c(3,3))  # Set up a 3x3 grid of plots
for (i in 1:ncol(fitted_values)) {
  for (var in c("Age", "Height", "Weight", "NCP", "CH2O", "FAF")) {
    x <- obesity.data[[var]]
    y <- log(fitted_values[, i] / fitted_values[, 1])
    if (length(x) != length(y)) {
      cat("Lengths differ for", var, "and outcome level", levels(fitted_values)[i], "\n")
      cat("Length of x:", length(x), "\n")
      cat("Length of y:", length(y), "\n")
    } else {
      plot(x, y, xlab = var, ylab = paste("Logit of Outcome:", levels(fitted_values)[i]))
    }
  }
}

#independence
residuals <- residuals(final_model, type = "pearson")
cor_matrix <- cor(residuals)
print(cor_matrix)

# Create a coefficient plot
install.packages("coefplot")
library(coefplot)
coefplot(final_model, intercept = FALSE)p

#p-values for coefficients
z <- summary(final_model)$coefficients/summary(final_model)$standard.errors
 # 2-tailed Wald z tests to test significance of coefficients
p <- (1 - pnorm(abs(z), 0, 1)) * 2
p

#AUC
install.packages("pROC")
library(pROC)
pred <- predict(final_model, type = "probs")
roc_obj <- multiclass.roc(response = obesity.data$NObeyesdad, predictor = as.numeric(pred), levels = levels(obesity.data$NObeyesdad))
plot(roc_obj, print.auc = TRUE, print.auc.x = 0.5, print.auc.y = 0.3)
