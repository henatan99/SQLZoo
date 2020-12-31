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

-- The JOIN operation

-- Question 1
SELECT matchid, player FROM goal 
  WHERE teamid = 'GER'; 
-- Question 2
SELECT id,stadium,team1,team2
  FROM game 
    INNER JOIN goal 
     ON game.id = goal.matchid
      WHERE player = 'Lars Bender';
-- Question 3
SELECT player, teamid, stadium, mdate
  FROM game JOIN goal ON (id=matchid)
    WHERE teamid = 'GER';
-- Question 4
SELECT team1, team2, player 
  FROM game JOIN goal ON (id=matchid)
    WHERE player LIKE 'Mario%';
-- Question 5
SELECT player, teamid, coach, gtime
  FROM eteam JOIN goal ON (teamid=id) 
    WHERE gtime<=10;
-- Question 6
SELECT mdate, teamname 
  FROM game JOIN eteam ON (team1=eteam.id)
    WHERE coach = 'Fernando Santos';
-- Question 7
SELECT player FROM goal 
  JOIN game ON (id=matchid)
    WHERE stadium = 'National Stadium, Warsaw'; 
-- Question 8
SELECT DISTINCT player
  FROM game JOIN goal ON matchid = id 
    WHERE ((team1='GER' OR team2='GER') AND teamid != 'GER');
-- Question 9
SELECT teamname, COUNT(player)
  FROM eteam JOIN goal ON id=teamid
 GROUP BY teamname;
-- Question 10
SELECT stadium, COUNT(player)
  FROM game JOIN goal ON id = matchid
    GROUP BY stadium;
-- Question 11
SELECT game.id, mdate, COUNT(*)
  FROM game JOIN goal ON matchid = id 
   WHERE (team1 = 'POL' OR team2 = 'POL')
     GROUP BY id, mdate
       ORDER BY id;
-- Question 12
SELECT id, mdate, COUNT(player)
  FROM game JOIN goal ON matchid = id
   WHERE teamid = 'GER'
    GROUP BY id, mdate;
-- Question 13
SELECT game.mdate, game.team1, 
  SUM(CASE WHEN goal.teamid = game.team1 THEN 1 ELSE 0 END) 
  AS score1,
  game.team2, 
  SUM(CASE WHEN goal.teamid = game.team2 THEN 1 ELSE 0 END) 
  AS score2
    FROM game JOIN goal ON (game.id = goal.matchid)
      GROUP BY mdate,  game.id, team1, team2 
        ORDER BY mdate, matchid, team1, team2;

-- More JOIN operations

-- Question 1
SELECT id, title
 FROM movie
 WHERE yr=1962
-- Question 2
SELECT yr FROM movie
  WHERE title = 'Citizen Kane';
-- Question 3
SELECT id, title, yr FROM movie 
  WHERE title LIKE '%Star Trek%'
    ORDER BY yr;
-- Question 4
SELECT id FROM actor 
  WHERE name = 'Glenn Close';
-- Question 5
SELECT id FROM movie
  WHERE title = 'Casablanca';
-- Question 6
SELECT name FROM actor 
  JOIN casting ON actorid = id  
   WHERE movieid = 11768;
-- Question 7
SELECT name FROM actor
  JOIN casting ON actorid = id
  JOIN movie ON movie.id = movieid 
      WHERE title = 'Alien';
-- Question 8
SELECT title FROM movie 
  JOIN casting ON movieid = movie.id
  JOIN actor ON actorid = actor.id
    WHERE name = 'Harrison Ford';
-- Question 9
SELECT title FROM movie 
  JOIN casting ON movieid = movie.id
  JOIN actor ON actorid = actor.id
    WHERE name = 'Harrison Ford' AND ord != 1;
-- Question 10
SELECT title, name FROM movie 
  JOIN casting ON movieid = movie.id
  JOIN actor ON actorid = actor.id
    WHERE yr = 1962 AND ord = 1;
-- Question 11
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2;
-- Question 12
SELECT title, name FROM movie
  JOIN casting ON movie.id=movieid
        JOIN actor ON actorid=actor.id
WHERE movieid IN (SELECT movieid FROM casting
  JOIN movie ON movieid = movie.id 
  JOIN actor ON actorid = actor.id 
    WHERE actor.name = 'Julie Andrews') AND ord = 1;
-- Question 13
SELECT actor.name FROM actor
  JOIN casting ON actorid = actor.id
    WHERE ord = 1
      GROUP BY actor.name HAVING COUNT(*) >= 15;
-- Question 14
SELECT title, COUNT(*) FROM movie
  JOIN casting ON movie.id = casting.movieid
    WHERE movie.yr = 1978
     GROUP BY movie.id, title
       ORDER BY COUNT(*) DESC, title;
-- Question 15
SELECT a.name
  FROM (SELECT movie.* FROM movie
     JOIN casting ON casting.movieid = movie.id
     JOIN actor ON actor.id = casting.actorid
        WHERE actor.name = 'Art Garfunkel') AS m
     JOIN (SELECT actor.*, casting.movieid FROM actor
     JOIN casting ON casting.actorid = actor.id
         WHERE actor.name != 'Art Garfunkel') as a ON m.id = a.movieid;

-- NULL, INNER JOIN, LEFT JOIN, RIGHT JOIN

-- Question 1
SELECT name FROM teacher 
  WHERE dept IS NULL;
-- Question 2
SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id);
-- Question 3
SELECT teacher.name, dept.name
 FROM teacher LEFT JOIN dept
           ON (teacher.dept=dept.id);
-- Question 4
SELECT teacher.name, dept.name
 FROM teacher RIGHT JOIN dept
           ON (teacher.dept=dept.id);
-- Question 5
SELECT teacher.name, COALESCE(mobile,'07986 444 2266')  
  FROM teacher;
-- Question 6
SELECT teacher.name, COALESCE(dept.name, 'None')
 FROM teacher LEFT JOIN dept
           ON (teacher.dept=dept.id);
-- Question 7
SELECT COUNT(teacher.name), COUNT(teacher.mobile)
  FROM teacher;
-- Question 8
SELECT dept.name, COUNT(teacher.name) FROM teacher
  RIGHT JOIN dept ON teacher.dept = dept.id 
    GROUP BY dept.name;
-- Question 9
SELECT teacher.name,
  CASE WHEN dept = 1 OR dept = 2 THEN 'Sci' 
  ELSE 'Art' END AS department
FROM teacher
-- Question 10
SELECT teacher.name,
  CASE 
    WHEN dept IS NULL THEN 'None'
    WHEN dept = 3 THEN 'Sci'
    ELSE 'Sci'
  END AS department 
FROM teacher

