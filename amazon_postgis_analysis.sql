/*
  PostGIS Analysis: Amazon Delivery Dataset
  Author: Aditya Shankar
  Description: This script demonstrates end-to-end spatial data engineering 
               including ETL, data cleaning, and advanced spatial binning.
*/

-- 1. DATABASE SETUP (Run in Terminal first)
-- createdb amazon_delivery_db
-- psql amazon_delivery_db

-- Enable the PostGIS extension
CREATE EXTENSION IF NOT EXISTS postgis;

-- 2. SCHEMA CREATION
-- We initially use TEXT for several columns to handle 'NaN' values during import
CREATE TABLE deliveries (
    Order_ID TEXT,
    Agent_Age TEXT,
    Agent_Rating TEXT,
    Store_Lat DOUBLE PRECISION,
    Store_Long DOUBLE PRECISION,
    Drop_Lat DOUBLE PRECISION,
    Drop_Long DOUBLE PRECISION,
    Order_Date TEXT,
    Order_Time TEXT,
    Pickup_Time TEXT,
    Weather TEXT,
    Traffic TEXT,
    Vehicle TEXT,
    Area TEXT,
    Delivery_Time TEXT,
    Category TEXT
);

-- 3. DATA IMPORT
-- Ensure the file is in /tmp/ to avoid macOS permission issues
COPY deliveries FROM '/tmp/amazon.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',');

-- 4. DATA CLEANING & TYPE CONVERSION
-- Converting TEXT columns to proper types while handling 'NaN' strings
ALTER TABLE deliveries ALTER COLUMN Agent_Age TYPE INT 
USING (CASE WHEN Agent_Age ~ '^[0-9]+$' THEN Agent_Age::INT ELSE NULL END);

ALTER TABLE deliveries ALTER COLUMN Delivery_Time TYPE INT 
USING (CASE WHEN Delivery_Time ~ '^[0-9]+$' THEN Delivery_Time::INT ELSE NULL END);

ALTER TABLE deliveries ALTER COLUMN Agent_Rating TYPE NUMERIC 
USING (CASE WHEN Agent_Rating ~ '^[0-9.]+$' THEN Agent_Rating::NUMERIC ELSE NULL END);

-- 5. SPATIAL TRANSFORMATIONS
-- Adding Geography columns (better for distance calculations in meters)
ALTER TABLE deliveries ADD COLUMN store_point GEOGRAPHY(Point, 4326);
ALTER TABLE deliveries ADD COLUMN drop_point GEOGRAPHY(Point, 4326);

-- Convert Lat/Long numbers into actual PostGIS Points
UPDATE deliveries 
SET store_point = ST_SetSRID(ST_MakePoint(Store_Long, Store_Lat), 4326)::geography,
    drop_point = ST_SetSRID(ST_MakePoint(Drop_Long, Drop_Lat), 4326)::geography;

-- Create a Spatial Index to optimize performance
CREATE INDEX idx_deliveries_store_point ON deliveries USING GIST (store_point);

-- 6. ANALYTICS QUERIES

-- Query A: Distance vs. Time Efficiency (Mins per KM)
SELECT 
    Traffic,
    Vehicle,
    ROUND(AVG(ST_Distance(store_point, drop_point) / 1000.0)::numeric, 2) as avg_distance_km,
    ROUND(AVG(Delivery_Time)::numeric, 2) as avg_time_mins,
    ROUND(AVG(Delivery_Time / (NULLIF(ST_Distance(store_point, drop_point), 0) / 1000.0))::numeric, 2) as mins_per_km
FROM deliveries
WHERE ST_X(store_point::geometry) != 0 -- Exclude 'Null Island' (0,0) coordinates
  AND Delivery_Time IS NOT NULL
GROUP BY Traffic, Vehicle
ORDER BY mins_per_km DESC;

-- Query B: Spatial Binning (Finding Hotspots)
-- Groups data into 1.1km x 1.1km grid cells
SELECT 
    ST_AsText(ST_SnapToGrid(store_point::geometry, 0.01)) AS grid_cell,
    COUNT(*) AS delivery_count
FROM deliveries
WHERE store_point IS NOT NULL 
  AND ST_X(store_point::geometry) != 0
GROUP BY grid_cell
ORDER BY delivery_count DESC
LIMIT 10;

-- Query C: Nearest Neighbor Search
-- Find the 5 closest orders to a specific central point (75.89, 22.75)
SELECT 
    Order_ID, 
    Category,
    ST_Distance(store_point, ST_MakePoint(75.89, 22.75)::geography) AS distance_meters
FROM deliveries
ORDER BY store_point <-> ST_MakePoint(75.89, 22.75)::geography
LIMIT 5;

-- 7. GEOJSON EXPORT (Example of the logic used for the Terminal export)
/*
SELECT json_build_object(
    'type', 'FeatureCollection',
    'features', json_agg(ST_AsGeoJSON(t.*)::json)
) FROM (
    SELECT ST_SnapToGrid(store_point::geometry, 0.01) AS geom, COUNT(*) as count 
    FROM deliveries WHERE ST_X(store_point::geometry) != 0 
    GROUP BY geom LIMIT 50
) AS t;
*/
