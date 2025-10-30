Customer Segmentation-SQL
This analysis will provide valuable insights into customer segments, helping businesses design targeted marketing campaigns and optimize customer engagement strategies. The results, including cluster summaries and visualizations, will be presented in a clear and concise manner to facilitate decision-making.
The primary focus of this analysis is on KMeans clustering, which will be employed to segment the customers into distinct groups based on the similarities between their Age and Spending Score. The optimal number of clusters will be determined using the Elbow Method. The clusters will then be analyzed and visualized to provide a clear understanding of customer behavior and segment characteristics

<img width="1326" height="770" alt="image" src="https://github.com/user-attachments/assets/c0b877d4-27fc-4270-9b23-cffc5c848c7c" />
<img width="705" height="448" alt="image" src="https://github.com/user-attachments/assets/40a10db5-d174-42c0-91a2-1be7bc09f8f3" />
<img width="681" height="477" alt="image" src="https://github.com/user-attachments/assets/48b72e98-a5c9-4a9d-804e-2eb4a76027ae" />
<img width="653" height="721" alt="image" src="https://github.com/user-attachments/assets/c4ae4d50-f137-414a-af01-99e4da216228" />
<img width="1152" height="572" alt="image" src="https://github.com/user-attachments/assets/520f9447-ce8e-47f7-98a9-83e4ce1b4379" />
K-means Clustering Visualization:
<img width="1335" height="482" alt="image" src="https://github.com/user-attachments/assets/e3f04229-f6e9-46b7-8274-07efe44b0a86" />
K-means Clustering Summery:
<img width="1073" height="427" alt="image" src="https://github.com/user-attachments/assets/7fbc0b1b-8510-479e-b257-b4b7448e3c40" />

Conclusion:
In this analysis, we explored and segmented customers based on their Age and Spending Score using KMeans clustering. The primary objectives were to uncover patterns and relationships in the data, visualize customer behavior, and group similar customers into distinct segments.
Data Insights:
We found that the Age and Spending Score distributions exhibited certain patterns, with age showing a relatively diverse range and spending scores demonstrating variation among customers.
The Gender distribution was balanced, with no significant skew toward either gender, ensuring a fair representation of both groups in the dataset.
Clustering:
By applying the KMeans clustering algorithm, we identified four distinct customer segments based on their Age and Spending Score. The Elbow Method was used to determine that 4 clusters provided the most meaningful segmentation.
Each cluster revealed unique characteristics, with differences in both Age and Spending Score. These clusters represent distinct customer groups, which can be used to tailor marketing and business strategies.
Customer Segmentation:
The segmentation allows businesses to understand customer behavior better, enabling targeted marketing efforts and personalized customer engagement strategies. For example, segments with high spending scores could be targeted for premium products, while younger segments could be approached with budget-friendly options.
Visualizations:
The visualizations, including scatter plots and histograms, helped us easily identify trends and relationships in the data. The cluster visualization provided clear insights into how customers are grouped based on their attributes.
Summary and Next Steps:
The customer segments derived from this analysis provide a solid foundation for further segmentation and deeper exploration. Future work could include incorporating additional features (e.g., Family size, Profession ) to refine the segmentation and gain even more actionable insights.
The results of this analysis can be used to inform decisions in marketing, customer service, and product development.
In conclusion, this analysis has successfully segmented customers into meaningful groups, providing a deeper understanding of their characteristics and behaviors. These insights are valuable for businesses seeking to improve their customer engagement strategies and optimize resource allocation.

Code:
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
