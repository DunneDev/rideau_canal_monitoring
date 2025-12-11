WITH AggregatedReadings AS
(
    SELECT
        location,
        System.Timestamp AS window_end,
        AVG(ice_cm) AS avg_ice_cm,
        MIN(ice_cm) AS min_ice_cm,
        MAX(ice_cm) AS max_ice_cm,
        AVG(surface_temp_c) AS avg_surface_temp,
        MIN(surface_temp_c) AS min_surface_temp,
        MAX(surface_temp_c) AS max_surface_temp,
        MAX(snow_cm) AS max_snow_cm,
        AVG(external_temp_c) AS avg_external_temp,
        COUNT(*) AS reading_count,
        CASE
            WHEN AVG(ice_cm) >= 30 AND AVG(surface_temp_c) <= -2 THEN 'Safe'
            WHEN AVG(ice_cm) >= 25 AND AVG(surface_temp_c) <= 0 THEN 'Caution'
            ELSE 'Unsafe'
        END AS safety_status
    FROM IoTHubInput
    GROUP BY
        location,
        TumblingWindow(minute, 5)
)
SELECT * INTO CosmosOutput FROM AggregatedReadings;
SELECT * INTO BlobOutput FROM AggregatedReadings;

