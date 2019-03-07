-- Query 1
-- The students who have a higher grade in Course "01" than "02" with 
-- their information and the course grade. 
SELECT x1.s_id, s.s_name, s.s_birth, s.s_gender, x1.c_id, x1.s_score, x2.c_id, x2.s_score
FROM (Score x1 JOIN Score x2 
		ON x1.s_id = x2.s_id 
		AND x1.c_id = "01" 
		AND x2.c_id = "02"
		AND x1.s_score > x2.s_score), Student s
WHERE x1.s_id = s.s_id;

-- Query 2
-- Students whose average grade larger than 60, with their id, name, and avg grade
SELECT s.s_id, s.s_name, sc.avg_score
FROM 
	(SELECT s_id, avg(s_score) as avg_score
	FROM Score
	GROUP BY s_id) sc, Student s
WHERE s.s_id = sc.s_id AND sc.avg_score > 60;

-- Query 3
-- Students whose average grade less than 60, including those without any grade
SELECT s.s_id, s.s_name, sc.avg_score
FROM 
	(SELECT s_id, avg(s_score) as avg_score
	FROM Score
	GROUP BY s_id) sc, Student s
WHERE s.s_id = sc.s_id AND sc.avg_score < 60
UNION
SELECT s_id, s_name, NULL
FROM Student 
WHERE s_id not in (SELECT s_id FROM Score);

-- solution2: students without grade
SELECT s.s_id, s.s_name, NULL
FROM Student s LEFT JOIN Score sc ON s.s_id = sc.s_id
WHERE s_score is NULL;

-- Query 4
-- All the students with id, name, total number of course selection, 
-- total grade(for those students do not take any course, show NULL)
SELECT *
FROM 
	(SELECT s.s_id, s.s_name, sc.total_course, sc.total_grade
	FROM Student s LEFT JOIN
	(SELECT s_id, COUNT(c_id) as total_course, SUM(s_score) as total_grade
	FROM Score
	GROUP BY s_id) sc
	ON s.s_id = sc.s_id) x;

-- Query 5
-- Return the number of teachers whose last name is "Li"
SELECT COUNT(*)
FROM Teacher t
WHERE right(t.t_name,2) = 'Li';

-- Query 6
-- Return students who have take the course tought by 'San Zhang'
SELECT s.s_id, s.s_name, s.s_birth, s.s_gender
FROM Teacher t, Course c, Score sc, Student s
WHERE t.t_name = 'San Zhang'
	AND t.t_id = c.t_id
	AND c.c_id = sc.c_id
	AND sc.s_id = s.s_id
GROUP BY s.s_id;

-- Query 7
-- Students that do not take all the courses
SELECT s.s_id, s.s_name, s.s_birth, s.s_gender
FROM 
(SELECT s_id, COUNT(DISTINCT c_id) as total_course
FROM Score
GROUP BY s_id) sc, Student s
WHERE s.s_id = sc.s_id
AND sc.total_course = (SELECT COUNT(*) FROM Course c);

-- Query 8 
-- Search students who have at least a course same with the student "01"
SELECT s.*
FROM Student s, Score s1 JOIN Score s2
WHERE s1.c_id = s2.c_id
	AND s1.s_id = '01'
	AND s2.s_id <> '01'
	AND s.s_id = s2.s_id
GROUP BY s2.s_id;

-- Query 9
-- Search students who take all the courses same with the student "01"
-- 9.1 The course 'the student' take have been taken by "01"
-- 9.2 'The student' take the same number of the course as '01'
-- => met the requirement
SELECT ss.s_id
FROM(
SELECT *
FROM Score s1
WHERE s1.s_id <> '01'
	AND s1.c_id in (SELECT sc.c_id
					FROM Score sc
					WHERE sc.s_id = '01')) ss
GROUP BY ss.s_id
HAVING count(1) = (SELECT COUNT(1)
					FROM Score sc
					WHERE sc.s_id = '01');

-- Query 10
-- Return students who never take courses taught by "San Zhang"
SELECT *
FROM Student s
WHERE s.s_id not in (SELECT sc.s_id
					FROM Course c, Teacher t, Score sc
					WHERE t.t_name = 'San Zhang'
						AND t.t_id = c.t_id
						AND sc.c_id = c.c_id)
