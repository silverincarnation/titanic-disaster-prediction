# Titanic Survival Prediction 

This project predicts passenger survival using the Kaggle Titanic dataset(https://www.kaggle.com/competitions/titanic).  
A simple logistic regression model was built with Python and R, using features: "Pclass", "Sex", and "Age", achieving around **80% accuracy** on the training and test datasets.

## Data Download
1. Go to [Kaggle Titanic Data](https://www.kaggle.com/competitions/titanic/data).
2. Download and unzip the files.
3. Move"train.csv", "gender_submission.csv" and "test.csv" to: src/app/data/

## Python Version
**Build image:** <br>
docker build -t titanic-app .<br>
docker run --rm titanic-app<br>
(Docker is stored in the root directory because I personally recommend using Python.)<br>
Please refer to requirements.txt for all required Python packages.

## R Version
**Build image:** <br>
docker build -t titanic-r-app -f src/r_app/Dockerfile . <br>
docker run --rm titanic-r-app
