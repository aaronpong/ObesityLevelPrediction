# Obesity Level Prediction using Multinomial Logistic Regression

A comprehensive statistical analysis project that predicts obesity levels based on eating habits and physical conditions using multinomial logistic regression in R.

## Project Overview

This project analyzes the relationship between lifestyle factors (eating habits, physical activity, demographic information) and obesity levels using advanced statistical modeling. The analysis employs multinomial logistic regression with stepwise variable selection to identify key predictors and achieve high predictive accuracy.

### Key Findings
- **Model Performance**: Achieved AUC of 0.98, indicating excellent predictive power
- **Significant Predictors**: Gender, family history, smoking habits, calorie monitoring, alcohol consumption, height, weight, meal frequency, water intake, and physical activity
- **Key Insights**: Alcohol consumption and meal frequency strongly associated with higher obesity levels, while physical activity shows protective effects

## Dataset

The analysis uses the "Estimation of Obesity Levels Based on Eating Habits and Physical Condition" dataset from the UCI Machine Learning Repository. The dataset contains:

- **17 attributes** including demographic information, measurements, and lifestyle choices
- **7 obesity categories** from Insufficient Weight to Obesity Type III
- **Survey-based data** from individuals in Colombia, Peru, and Mexico
- **Mixed data generation**: 23% collected via web platform, 77% generated using ML tools (Weka, SMOTE)

## Repository Structure

```
ObesityLevelPrediction/
├── data/
│   └── ObesityDataSet_raw_and_data_sinthetic.csv
├── analysis.R
├── STAT654 FINAL PROJECT RESULTS.pdf
└── README.md
```

## Requirements

### Software
- **R** (version 3.6 or higher)
- **RStudio** (recommended)

### R Packages
The script will attempt to install missing packages automatically. Required packages include:

```r
- nnet          # Multinomial logistic regression
- MASS          # Stepwise model selection
- car           # Variance inflation factors
- GGally        # Scatterplot matrices
- coefplot      # Coefficient plotting
- pROC          # ROC curve analysis
```

## Setup and Usage

### Quick Start

1. **Clone or download this repository**
   ```bash
   git clone https://github.com/yourusername/ObesityLevelPrediction.git
   ```

2. **Open the project in RStudio**
   - Navigate to the downloaded folder
   - Double-click to open the folder
   - Open `analysis.R`

3. **Run the analysis**
   - Execute the entire script or run sections individually
   - The script will automatically load data and install required packages
   - Results and visualizations will appear in RStudio

### Detailed Instructions

1. **Ensure proper setup**
   - Make sure you're running the script from the repository root folder
   - The script includes automatic file detection and helpful error messages

2. **Understanding the analysis flow**
   - Data loading and cleaning
   - Exploratory data analysis
   - Multinomial logistic regression modeling
   - Model selection using stepwise AIC
   - Assumption checking
   - Model evaluation (AUC, ROC curves)
   - Coefficient interpretation

## Analysis Components

### 1. Data Preprocessing
- Categorical variable encoding
- Ordinal factor creation
- Rounding ML-generated continuous values
- Missing value handling

### 2. Exploratory Analysis
- Frequency distributions of obesity categories
- Correlation analysis of continuous variables
- Scatterplot matrices for assumption checking

### 3. Statistical Modeling
- **Full Model**: All 16 predictor variables
- **Final Model**: 10 variables selected via stepwise AIC
- **Model Validation**: Assumption testing, VIF analysis
- **Performance Metrics**: AUC = 0.98, comprehensive ROC analysis

### 4. Results Interpretation
- Coefficient significance testing
- Odds ratio calculations
- Clinical and policy implications

## Key Results

### Most Significant Predictors
- **Physical characteristics**: Height, weight
- **Behavioral factors**: Alcohol consumption (CALC), calorie monitoring (SCC)
- **Demographic factors**: Gender, family history of overweight
- **Lifestyle factors**: Physical activity frequency (FAF), water consumption (CH2O)

### Model Performance
- **AUC**: 0.98 (excellent discrimination)
- **Variable Selection**: Reduced from 16 to 10 predictors while maintaining performance
- **Clinical Relevance**: Identifies modifiable risk factors for obesity prevention

## Files Description

- **`analysis.R`**: Complete R script with all analysis code
- **`data/ObesityDataSet_raw_and_data_sinthetic.csv`**: Raw dataset
- **`STAT654 FINAL PROJECT RESULTS.pdf`**: Comprehensive report with detailed methodology, results, and interpretations
- **`README.md`**: This documentation file

## Academic Context

This project was completed as part of STAT654 (Applied Statistics II) coursework, demonstrating:
- Advanced statistical modeling techniques
- Proper assumption testing and validation
- Real-world application of multinomial logistic regression
- Professional statistical reporting and interpretation

## Data Source and Citation

**Dataset**: Palechor, F. M., & Manotas, A. H. (2019). Dataset for estimation of obesity levels based on eating habits and physical condition in individuals from Colombia, Peru and Mexico. *Data in brief*, 25, 104344.

**UCI Repository**: [Estimation of obesity levels based on eating habits and physical condition](https://archive.ics.uci.edu/ml/datasets/Estimation+of+obesity+levels+based+on+eating+habits+and+physical+condition+)

## Future Directions

- Cross-validation on independent datasets
- Regularization techniques to improve generalizability
- Non-linear transformation exploration
- Integration with additional health datasets

## Contact

**Author**: Aaron Pongsugree  
**Course**: STAT654 - Applied Statistics II  
**Institution**: George Mason University

## License

This project is for educational purposes. Please refer to the original dataset license for data usage terms.

---

*For detailed methodology, statistical assumptions, and comprehensive results interpretation, please refer to the full report: `STAT654 FINAL PROJECT RESULTS.pdf`*
