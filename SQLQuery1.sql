Code :
!pip install pandas matplotlib seaborn scikit-learn #package installed
import pandas as pd          #Libraries loaded
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.preprocessing import StandardScaler
from sklearn.cluster import KMeans
from sklearn.decomposition import PCA
test_data = pd.read_csv("test.csv")          #datasets loaded
train_data = pd.read_csv("train.csv")
print(test_data.info())
print(test_data.describe())
print(train_data.info())
print(train_data.describe())
print(test_data.isnull().sum())   #missing values checked
print(test_data.columns.tolist())
test_data.columns = test_data.columns.str.strip()
lt.figure(figsize=(8, 5))                 #Distribution plots
sns.histplot(test_data['Age'], kde=True, color='orange')
plt.title("Age Distribution")
plt.show()

plt.figure(figsize=(8, 5))
sns.histplot(test_data['Spending_Score'], kde=True, color='green')
plt.title("Spending Score Distribution")
plt.show()
sns.countplot(data=test_data, x='Gender', palette='pastel') #Gender Distribution
plt.title("Gender Distribution")
plt.show()
sns.pairplot(test_data[['Age', 'Spending_Score']])  #Pairplot to see relationships
plt.show()
features = test_data[['Age', 'Spending_Score']]
print(test_data.dtypes)
from sklearn.preprocessing import LabelEncoder
le = LabelEncoder()
for col in test_data.select_dtypes(include='object').columns:
    test_data[col] = le.fit_transform(test_data[col])
from sklearn.preprocessing import StandardScaler
features = test_data.select_dtypes(include='number')
scaler = StandardScaler()
scaled_features = scaler.fit_transform(features)
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt
import seaborn as sns
features_clean = features.dropna()
scaled_features = scaler.fit_transform(features_clean)
from sklearn.cluster import KMeans
wcss = []
for i in range(1, 11):
    kmeans = KMeans(n_clusters=i, random_state=42)
    kmeans.fit(scaled_features)
    wcss.append(kmeans.inertia_)
plt.plot(range(1, 11), wcss, marker='o')   # Plot elbow graph
plt.title('Elbow Method')
plt.xlabel('Number of clusters')
plt.ylabel('WCSS')
plt.grid(True)
plt.show()
print(test_data.shape[0])  # Number of rows in test_data
print(scaled_features.shape[0]) 
scaled_features = scaler.fit_transform(test_data[['Age', 'Spending_Score']]) 

assert scaled_features.shape[0] == test_data.shape[0], "Mismatch in rows"
test_data_subset = test_data.iloc[:scaled_features.shape[0]]
test_data_subset['Cluster'] = kmeans.fit_predict(scaled_features)
kmeans = KMeans(n_clusters=4, random_state=42) # Let's assume optimal clusters = 4
test_data['Cluster'] = kmeans.fit_predict(scaled_features)
plt.figure(figsize=(8, 5)) # Visualization of clusters
sns.scatterplot(data=test_data, x='Age', y='Spending_Score', hue='Cluster', palette='tab10')
plt.title('Customer Segments')
plt.show()
summary = test_data.groupby('Cluster').mean() # Summary by cluster
print(summary)

summary.to_csv("cluster_summary.csv")
