# Create rangers Table
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL
);

# Create species Table
CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(150) NOT NULL,
    discovery_date DATE,
    conservation_status VARCHAR(50)
);

# Create sightings Table

CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INTEGER NOT NULL REFERENCES rangers(ranger_id),
    species_id INTEGER NOT NULL REFERENCES species(species_id),
    sighting_time TIMESTAMP NOT NULL,
    location VARCHAR(100) NOT NULL,
    notes TEXT
);


-- Insert Value rangers
INSERT INTO rangers (ranger_id, name, region) VALUES
(1, 'Alice Green', 'Northern Hills'),
(2, 'Bob White', 'River Delta'),
(3, 'Carol King', 'Mountain Range');


-- Insert Value species
INSERT INTO species (species_id, common_name, scientific_name, discovery_date, conservation_status) VALUES
(1, 'Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
(2, 'Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
(3, 'Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
(4, 'Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');


-- Insert Value sightings
INSERT INTO sightings (sighting_id, species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(4, 1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);


SELECT * FROM rangers

SELECT * FROM species;

SELECT * FROM sightings;



-- Problem 1:  Register a new ranger with provided data with name = 'Derek Fox' and region = 'Coastal Plains'
INSERT INTO rangers (ranger_id, name, region)
VALUES (4,'Derek Fox', 'Coastal Plains');


-- Problem 2: Count unique species ever sighted.
SELECT COUNT(DISTINCT species_id) AS unique_species_count FROM sightings;


-- Problem 3: Find all sightings where the location includes "Pass".
SELECT * FROM sightings
WHERE location ILIKE '%Pass%';

-- Problem 4: List each ranger's name and their total number of sightings.
SELECT rangers.name AS rangerName, COUNT(sightings.ranger_id) AS total_sightings
FROM sightings
JOIN rangers ON sightings.ranger_id = rangers.ranger_id
GROUP BY rangers.name;

-- Problem 5: List species that have never been sighted. 
SELECT species.common_name , sightings.species_id
FROM species
LEFT JOIN sightings ON species.species_id = sightings.species_id
WHERE sightings.species_id IS NULL;


-- Problem 6: Show the most recent 2 sightings.
SELECT species.common_name, sightings.sighting_time, rangers.name
FROM sightings
JOIN rangers ON sightings.ranger_id = rangers.ranger_id
JOIN species ON sightings.species_id = species.species_id
ORDER BY sighting_time DESC
LIMIT 2;

-- Problem 7: Update all species discovered before year 1800 to have status 'Historic'.

UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';


-- Problem 8: Label each sighting's time of day as 'Morning', 'Afternoon', or 'Evening'.
SELECT 
    sighting_id,
    sighting_time,
    location,
    CASE 
        WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sighting_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day
FROM sightings;


-- Problem 9: Delete rangers who have never sighted any species
DELETE FROM rangers
WHERE NOT EXISTS (
    SELECT 1
    FROM sightings
    WHERE sightings.ranger_id = rangers.ranger_id
);
