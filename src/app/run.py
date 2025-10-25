# Question 13
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score

try:
    train = pd.read_csv("../data/train.csv")
except FileNotFoundError:
    try:
        train = pd.read_csv("src/data/train.csv")
    except FileNotFoundError:
        print("file not exist！")
print("Question 13")
print("train is read and relevant packages are imported!")

# Question 14
train = train.dropna()
train = train.drop_duplicates()
train["Sex"] = train["Sex"].map({"male": 0, "female": 1})
print("Question 14")
print("Duplicates and na are dropped! male is set to 0 and female is set to 1!")
print(train.head(5))

# Question 15
features = ["Pclass", "Sex", "Age"]
X = train[features]
y = train["Survived"]
model = LogisticRegression()
model.fit(X, y)
print("Question 15")
print("I use Pclass, sex and age to predict.")

# Question 16
y_pred_train = model.predict(X)
train_acc = accuracy_score(y, y_pred_train)
print("Question 16")
print(f"accuracy: {train_acc}")

# Question 17
try:
    test = pd.read_csv("../data/test.csv")
except FileNotFoundError:
    try:
        test = pd.read_csv("src/data/test.csv")
    except FileNotFoundError:
        print("file not exist！")
test = test.dropna()
test = test.drop_duplicates()
test["Sex"] = test["Sex"].map({"male": 0, "female": 1})
features = ["Pclass", "Sex", "Age"]
X_test = test[features]
y_pred_test = model.predict(X_test)
print("Question 17")
print("read test!")

# Question 18
try:
    y_pred = pd.read_csv("../data/gender_submission.csv")
except FileNotFoundError:
    try:
        y_pred = pd.read_csv("src/data/gender_submission.csv")
    except FileNotFoundError:
        print("file not exist！")
y_pred = y_pred.loc[y_pred["PassengerId"].isin(test["PassengerId"]), ["Survived"]]
test_acc = accuracy_score(y_pred, y_pred_test)
print("Question 18")
print(f"accuracy: {test_acc}")
