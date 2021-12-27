SELECT * FROM coviddeaths

--Select data that we going to be using
SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM coviddeaths 


--Calculating total cases,total population and aggregate total infected percentage 
SELECT SUM(total_cases) AS TotalCases,
SUM(population) AS TotalPopulation,
SUM(total_cases)/SUM(population)*100 AS TotalInfectedPercentage
FROM coviddeaths

--Finding country sepcific deathrate from covid
SELECT Location, date, total_cases,total_deaths,
(total_deaths/total_cases)*100 AS deathRate
FROM coviddeaths
WHERE Location like '%Nepal%'

--Finding country sepcific daily percentage of total population has got infected with covid
SELECT Location, date, total_cases,population,
(total_cases/ population)*100 AS infectedRate
FROM coviddeaths
WHERE Location like '%Nepal%'


--highest infection rate compare to population
SELECT Location,population, 
MAX(total_cases) AS HighestInfectedCount,
MAX((total_cases/ population))*100 AS infectedRate
FROM coviddeaths
GROUP BY location, population
ORDER BY infectedRate DESC


--Highest death count per population as per country
SELECT Location,
Max(cast(total_deaths AS int)) AS TotalDeathCount
FROM coviddeaths
WHERE continent is not null
GROUP BY location 
ORDER BY TotalDeathCount DESC

--Highest death count per population as per continent
SELECT continent,
Max(cast(total_deaths AS int)) AS TotalDeathCount
FROM coviddeaths
WHERE continent is not null
GROUP BY continent 
ORDER BY TotalDeathCount DESC

--Highest death count per population as per income level
SELECT location,
Max(cast(total_deaths AS int)) AS TotalDeathCount
FROM coviddeaths
WHERE location = 'Upper middle income'
OR location = 'high income'
OR location = 'Lower middle income'
OR location = 'Low income'
GROUP BY location 
ORDER BY TotalDeathCount DESC


--------
SELECT * FROM coviddeaths

--Every day new cases,death and death percentage across the world
SELECT date,
SUM(new_cases) AS NewCases,
SUM(new_deaths) AS NewDeaths,
SUM(new_deaths)/SUM(new_cases)*100 AS DeathPercentage
FROM coviddeaths
WHERE new_cases >0
GROUP BY date
ORDER BY date ASC

--Total new cases,death and death percentage across the world
SELECT
SUM(new_cases) AS NewCases,
SUM(new_deaths) AS NewDeaths,
SUM(new_deaths)/SUM(new_cases)*100 AS DeathPercentage
FROM coviddeaths

--Total new cases,death and death percentage country specific
SELECT location,
SUM(new_cases) AS TotalNewCases,
SUM(new_deaths) AS TotalNewDeaths,
SUM(new_deaths)/SUM(new_cases)*100 AS DeathPercentage
FROM coviddeaths
WHERE location = 'Nepal'
GROUP BY location 


SELECT * FROM covidvaccination

--Daily new vaccination across the globe
SELECT date, new_vaccinations
FROM covidvaccination
ORDER BY date ASC

--Country specific new vaccination and population
SELECT location, date, population, new_vaccinations
FROM covidvaccination
WHERE location = 'India'
ORDER BY date ASC



--Creating view to store data
CREATE VIEW NewVaccination AS
SELECT location, date, new_vaccinations
FROM covidvaccination

SELECT * FROM NewVaccination


--Calculating total positive rate and tota test done in specific country
SELECT location, 
SUM(Convert(float, population)) AS totalpopulation, 
SUM(CONVERT(float, positive_rate)) AS TotalPositiveRate, 
SUM(CONVERT(float, total_tests)) AS totalTests
FROM covidvaccination
WHERE location = 'India'
GROUP BY location

