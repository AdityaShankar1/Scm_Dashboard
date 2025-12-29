<img width="1470" height="956" alt="Screenshot 2025-12-29 at 2 29 53 PM" src="https://github.com/user-attachments/assets/489a29e4-5291-4fa4-a514-c43ffcaa7f47" />## Real-Time Delivery Visibility & Performance Dashboard
This project was done as a part of SCM coursework at PES University. It aims to create an insightful dashboard for a 3PL company using PowerBI and Tableau and Dash 
This project develops an interactive dashboard and integrates machine learning to provide detailed insights into delivery performance, empowering supply chain managers with data-driven decision-making.

### 🚀 Introduction

In today's fast-paced supply chain environment, immediate visibility into delivery operations is crucial for on-time order delivery and minimizing logistics inefficiencies. Delayed deliveries not only impact customer satisfaction but also incur additional transportation and fuel costs, leading to overall supply chain disruption.

Our project addresses this by developing an interactive Power BI dashboard that offers detailed insights into delivery performance. This includes tracking average delivery time, on-time delivery rates, fuel spending per vehicle category, and delivery timescale distribution. We utilized a synthetic dataset simulating 500 delivery records and an Amazon Delivery dataset from Kaggle to graph and examine key delivery metrics by vehicle type (Truck, Van, Bike) and date. The system aims to expose real-time delivery inefficiencies and cost choke points, enabling supply chain managers to make informed decisions.

### ✨ Features

*   **Interactive Power BI Dashboard:** Visualize delivery metrics using a synthetic dataset.
*   **Performance Analysis:** Analyze delivery time, fuel usage, cost, and overall performance.
*   **Predictive Analytics:** Apply machine learning to predict late deliveries based on delivery characteristics.
*   **KPI Visuals & Filterable Charts:** Designed for operational delivery analysis.
*   **Inefficiency Identification:** Pinpoint inefficiencies in delivery performance across vehicle types and time periods.
*   **Logistic Regression Model:** Trained and applied to classify potential late deliveries.
*   **ML Prediction Integration:** Integrate machine learning predictions directly into the Power BI dashboard for decision-making support.

### 📊 Project Insights

Our analysis provides key insights into fuel consumption, on-time delivery percentage, and delivery costs across different vehicle types:

*   **Fuel Consumption:**
    *   The Bike consumed significantly less fuel on average compared to the Truck (34.87% lower) and the Van (20.97% lower).
*   **On-Time Percentage:**
    *   The Bike has a lower On-Time Percentage, being 16.25% less than the Van and 2.5% less than the Truck.
*   **Delivery Costs:**
    *   The total delivery cost for the Bike was 44.31% cheaper than the Truck and 27.23% cheaper than the Van.

**Conclusion:** The Truck mode of delivery is the least efficient overall. The Bike (lowest fuel consumption) and the Van (highest On-Time Percentage) are better options for delivery efficiency. Traffic and weather conditions also significantly impact delivery times, with sunny weather being optimal and fog/cloudy weather leading to maximum delays. For unfavorable weather or fragile shipments, the Van is recommended, while bikes are ideal for high-traffic areas due to their ability to navigate shortcuts.

### ⚙️ Technologies Used

#### Machine Learning Techniques:

*   **Logistic Regression:** Used to classify deliveries as on-time or late based on features like distance, fuel consumed, driver rating, and vehicle type.
*   **Train-Test Split (70:30):** To evaluate model accuracy and generalization by training on 70% of the data and testing on 30%.
*   **One-Hot Encoding:** To convert the categorical variable `vehicle_type` into numeric format for the ML model.
*   **Feature Selection:** To choose the most relevant features (e.g., `distance_km`, `fuel_consumed_litres`, `driver_rating`) for the model.
*   **Confusion Matrix & Accuracy Score:** To assess model performance in terms of correctly predicted late vs. on-time deliveries.

#### ML Tools & Software:

*   **Python 3.10:** Primary language for machine learning model development.
*   **scikit-learn:** For implementing logistic regression, model training, and evaluation.
*   **pandas:** For data preprocessing and manipulation.
*   **Jupyter Notebook:** Used for initial experimentation and testing of the ML model.
*   **Power BI:** Used to run Python scripts for ML and display prediction results inside the dashboard.

### 🛠️ Installation

1.  **Power BI Desktop:**
    *   Install Power BI Desktop from the [official Microsoft Power BI website](https://powerbi.microsoft.com/desktop/).
2.  **Python 3.10:**
    *   Install Python 3.10 from [https://www.python.org](https://www.python.org).
3.  **Required Python Packages:**
    *   Open your terminal or command prompt and run:
        ```bash
        pip install pandas scikit-learn
        ```
4.  **Configure Power BI for Python Scripting:**
    *   In Power BI Desktop, go to `File` → `Options and settings` → `Options`.
    *   Navigate to `Python scripting`.
    *   Ensure Python scripting is enabled and configure the local Python installation path.
    *   Visuals like predicted late deliveries can then be generated using Power BI's built-in support for Python.

### 📂 Data Inputs

This project utilizes two datasets:

1.  **Synthetic Delivery Dataset:**
    *   **Source:** Custom-generated using Python.
    *   **Purpose:** Primary dataset for Power BI visualizations and machine learning prediction. It includes critical operational KPIs like fuel consumption, cost per delivery, and precise SLA time tracking, which were missing from the real-world dataset.
    *   **Key Fields:** `delivery_id`, `delivery_time_min`, `expected_time_min`, `distance_km`, `fuel_consumed_litres`, `delivery_cost`, `driver_rating`, `vehicle_type`, `is_late`, `predicted_late`.

2.  **Amazon Delivery Dataset (Kaggle):**
    *   **Source:** [Kaggle (Amazon Last Mile Delivery dataset)](https://www.kaggle.com/datasets/sujalsuthar/amazon-delivery-dataset).
    *   **Purpose:** Used for exploratory analysis to understand real-world delivery variables such as agent ratings, traffic, and weather. While rich in real-life scenarios, it lacked essential KPIs for end-to-end analysis and ML implementation, hence combined with the synthetic dataset.
    *   **Relevant Fields Explored:** `Delivery_person_Age`, `Delivery_person_Ratings`, `Order_Date`, `Time_Orderd`, `Time_Order_picked`, `Weatherconditions`, `Road_traffic_density`, `Type_of_order`, `Type_of_vehicle`.

### 🌏 PostGIS Output:

<img width="1470" height="956" alt="Screenshot 2025-12-29 at 2 29 53 PM" src="https://github.com/user-attachments/assets/d4490520-b684-4de2-9679-ae39159eba66" />

### 🤝 Contributing

Contributions are welcome! If you have suggestions for improvements or new features, please open an issue or submit a pull request.

### 📄 License

This project is licensed under the MIT License.

### 📧 Contact

For any inquiries, please contact the project team:

*   Aditya Shankar (PES1UG22CS045)
*   Aditi Vadmal (PES1UG22CS032)
*   Saanvi Shetty (PES1UG22EC248)
*   Narreddy Pedda Vemanna Gari Bavana (PES1UG22EC172)
