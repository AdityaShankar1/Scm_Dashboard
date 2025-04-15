import pandas as pd
import dash
from dash import dcc, html
from dash.dependencies import Input, Output
import plotly.express as px

# Load your CSV file
df = pd.read_csv("synthetic_delivery_data.csv")

# Print column names to confirm
print("📊 Columns in dataset:", df.columns.tolist())

# If a mapping is needed for on_time, you can adjust here.
# Since your CSV already has an "on_time" column, we'll use it directly.
# (If the values need to be mapped, you could do so, e.g., df["on_time"] = df["on_time"].map({1:"Yes", 0:"No"}))

# Initialize Dash app
app = dash.Dash(__name__)
app.title = "SCM Dashboard"

# KPI card style
card_style = {
    "border": "1px solid lightgray",
    "borderRadius": "10px",
    "padding": "10px 20px",
    "width": "18%",
    "textAlign": "center",
    "boxShadow": "2px 2px 6px lightgray"
}

# Layout of the Dash app
app.layout = html.Div([
    html.H1("📦 Delivery Dashboard", style={"textAlign": "center"}),

    # Vehicle type filter
    html.Div([
        html.Label("Select Vehicle Type:"),
        dcc.Dropdown(
            id="vehicle-filter",
            options=[{"label": v, "value": v} for v in df["vehicle_type"].unique()] + [{"label": "All", "value": "All"}],
            value="All"
        )
    ], style={"width": "30%", "margin": "auto"}),

    html.Br(),

    # KPI cards container
    html.Div(id="kpi-cards", style={"display": "flex", "justifyContent": "space-around"}),

    html.Hr(),

    # Graphs container
    html.Div([
        dcc.Graph(id="cost-by-vehicle"),
        dcc.Graph(id="delivery-time-distribution")
    ])
])

# Callback for updating KPIs and graphs
@app.callback(
    [Output("kpi-cards", "children"),
     Output("cost-by-vehicle", "figure"),
     Output("delivery-time-distribution", "figure")],
    [Input("vehicle-filter", "value")]
)
def update_dashboard(vehicle_type):
    # Filter dataframe based on dropdown selection
    dff = df if vehicle_type == "All" else df[df["vehicle_type"] == vehicle_type]

    # Calculate KPIs
    avg_cost = round(dff["delivery_cost"].mean(), 2)
    avg_time = round(dff["delivery_time_min"].mean(), 2)
    on_time_pct = round((dff["on_time"] == "Yes").mean() * 100, 2)
    total_deliveries = len(dff)

    # Define KPI cards
    kpi_cards = [
        html.Div([html.H4("Avg. Delivery Cost"), html.P(f"$ {avg_cost}")], style=card_style),
        html.Div([html.H4("Avg. Delivery Time"), html.P(f"{avg_time} minutes")], style=card_style),
        html.Div([html.H4("On-Time Delivery"), html.P(f"{on_time_pct}%")], style=card_style),
        html.Div([html.H4("Total Deliveries"), html.P(f"{total_deliveries}")], style=card_style),
    ]

    # Graph for delivery cost by vehicle type
    cost_fig = px.box(
        dff, 
        x="vehicle_type", 
        y="delivery_cost", 
        color="vehicle_type",
        title="Delivery Cost by Vehicle Type"
    )

    # Graph for delivery time distribution
    time_fig = px.histogram(
        dff, 
        x="delivery_time_min", 
        nbins=10, 
        color="on_time",
        title="Delivery Time Distribution"
    )

    return kpi_cards, cost_fig, time_fig

# Run the Dash app
if __name__ == "__main__":
    app.run(debug=True)
