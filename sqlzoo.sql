-- SELECT basics

-- Question 1
SELECT population FROM world
  WHERE name = 'Germany'
-- Question 2
SELECT name, population FROM world
  WHERE name IN ('Sweden', 'Norway', 'Denmark');
-- Question 3
SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000

-- SELECT from WORLD Tutorial

-- Question 1
SELECT name, continent, population FROM world
-- Question 2
SELECT name
  FROM world
 WHERE population > 200000000
-- Question 3
SELECT name, gdp/population FROM world 
  WHERE population >+ 200000000;
--   Question 4
SELECT name, population/1000000 FROM world 
  WHERE continent = 'South America';
--   Question 5
SELECT name, population FROM world 
  WHERE name IN ('France', 'Germany', 'Italy');
--   Question 6
SELECT name FROM world 
  WHERE name LIKE '%United%';
--   Question 7
SELECT name, population, area FROM world 
  WHERE area > 3000000 OR population > 250000000;
--   Question 8
SELECT name, population, area FROM world 
  WHERE area > 3000000 XOR population > 250000000;
--   Question 9
SELECT name, ROUND(population/1000000, 2), ROUND(gdp/1000000000, 2) FROM world
  WHERE continent = 'South America';
--   Question 10
SELECT name, ROUND(gdp/population, -3) FROM world
  WHERE gdp >= 1000000000000;
--   Question 11
SELECT name, capital FROM world
  WHERE LENGTH(name) = LENGTH(capital);
-- Question 12
SELECT name, capital FROM world
  WHERE LEFT(name,1) = LEFT(capital,1) AND name <> capital;
--   Question 13
SELECT name FROM world
  WHERE name LIKE '%a%' AND name LIKE '%e%' AND name LIKE '%i%' 
  AND name LIKE '%o%' AND name LIKE '%u%' AND name NOT LIKE '% %';

-- SELECT from Nobel Tutorial

-- Question 1
SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950;
--  Question 2
SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature';
-- Question 3
SELECT yr, subject FROM nobel 
  WHERE winner = 'Albert Einstein';
--   Question 4
SELECT winner FROM nobel 
  WHERE subject = 'Peace' AND yr >= 2000;
--   Question 5
SELECT * FROM nobel 
  WHERE subject = 'Literature' AND
   yr BETWEEN 1980 AND 1989;
--    Question 6
SELECT * FROM nobel
 WHERE winner IN ('Theodore Roosevelt', 'Woodrow Wilson', 'Jimmy Carter', 'Barack Obama');
--  Question 7
SELECT winner FROM nobel 
  WHERE winner LIKE 'John%';
--   Question 8
SELECT * FROM nobel 
  WHERE (subject = 'Physics' AND yr = 1980) OR (subject = 'Chemistry' AND yr = 1984);
--   Question 9
SELECT * FROM nobel 
  WHERE yr = 1980 AND subject NOT IN ('Chemistry', 'Medicine');
--   Question 10
SELECT * FROM nobel 
  WHERE (subject = 'Medicine' AND yr < 1910) OR (subject = 'Literature' AND yr >= 2004);
--   Question 11
SELECT * FROM nobel 
  WHERE winner = 'PETER GRÜNBERG';
--   Question 12
SELECT * FROM nobel 
  WHERE winner = 'EUGENE O''NEILL';
--   Question 13
SELECT winner, yr, subject FROM nobel 
  WHERE winner LIKE 'Sir%'
   ORDER BY yr DESC, winner;
--    Question 14
SELECT winner, subject FROM nobel
  WHERE yr=1984
   ORDER BY subject IN ('Physics','Chemistry'), subject,winner;

-- SELECT within SELECT Tutorial

-- Question 1
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world 
      WHERE name='Russia');
-- Question 2
SELECT name FROM world 
  WHERE continent = 'Europe' 
    AND gdp/population > (SELECT gdp/population 
      FROM world WHERE name = 'United Kingdom');
-- Question 3
SELECT name, continent FROM world 
  WHERE continent IN (SELECT continent FROM world 
   WHERE name IN ('Argentina', 'Australia'))
     ORDER BY name;
-- Question 4
SELECT name, population FROM world 
  WHERE population > (SELECT population FROM world 
   WHERE name = 'Canada') AND population < (SELECT population FROM world 
   WHERE name = 'Poland');
-- Question 5
SELECT name, CONCAT(ROUND(population/(SELECT population FROM world 
  WHERE name = 'Germany')*100), '%') FROM world
    WHERE continent = 'Europe';
-- Question 6
SELECT name FROM world 
  WHERE gdp > ALL(SELECT gdp FROM world
    WHERE continent = 'Europe' AND gdp > 0);
-- Question 7
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area>0)
-- Question 8
SELECT continent, name FROM world x
  WHERE name <= ALL(SELECT name FROM world y
    WHERE y.continent = x.continent);
-- Question 9
SELECT name, continent, population FROM world x
  WHERE 25000000 > ALL(SELECT population FROM world y
    WHERE y.continent = x.continent);
-- Question 10
SELECT name, continent FROM world x
  WHERE population/3 > ALL(SELECT population FROM world y
    WHERE y.continent = x.continent AND population > 0 AND y.name != x.name); 


-- SUM and COUNT

-- Question 1
SELECT SUM(population)
FROM world
-- Question 2
SELECT DISTINCT continent FROM world 
-- Question 3
SELECT SUM(gdp) FROM world 
  WHERE continent = 'Africa';
-- Question 4
SELECT COUNT(area) FROM world 
  WHERE area >= 1000000;
-- Question 5
SELECT SUM(population) FROM world
  WHERE name IN ('Estonia', 'Latvia', 'Lithuania'); 
-- Question 6
SELECT continent, COUNT(name) FROM world 
  GROUP BY continent HAVING COUNT(name) > 0;
-- Question 7
SELECT continent, COUNT(name) FROM world
  WHERE population > 10000000 
    GROUP BY continent HAVING COUNT(name) > 0;
-- Question 8
SELECT continent FROM world 
  GROUP BY continent HAVING SUM(population) >= 100000000;
