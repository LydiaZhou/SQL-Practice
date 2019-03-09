-- Query 11
-- Return the name, id and the average grade of students with two or more failed courses. 
SELECT s.s_id, st.s_name, AVG(s.s_score)
FROM Score s, Student st
WHERE s.s_score < 60 AND st.s_id = s.s_id
GROUP BY s.s_id
HAVING COUNT(1) >= 2;

-- Query 12
-- Return the information of student who has a grade lower than 60 in "01" course, 
-- ordered by the grade(high to low)
SELECT *
FROM Score s
WHERE s.c_id = '01' AND s.s_score < 60
ORDER BY s.s_score DESC;

-- Query 13
-- From high avg grade to low, show the all course grade and average grade of all students
SELECT s.s_name, s1.*, s2.avg
FROM Student s, Score s1 LEFT JOIN
(SELECT s.s_id, AVG(s.s_score) as avg
FROM Score s
GROUP BY s.s_id) s2
ON s1.s_id = s2.s_id
WHERE s.s_id = s1.s_id
ORDER BY s2.avg DESC; 

-- Query 14
-- Search the highest, lowest and the average grade in all courses
-- In the format of: "Course id, Course name, highest grade, lowest grade, average grade, 
-- pass rate(>=60), rate of (70-80), rate of (80-90) and rate of (>=90), num_students". 
-- From popular to un-popular, if two courses have the same number of selection, ordered by 
-- course_id(high to low). 

-- try to search all the highest grade first
SELECT s.c_id, 
	Course.c_name, 
	MAX(s.s_score) as max, 
	MIN(s.s_score) as min, 
	AVG(s.s_score) as avg,
	COUNT(CASE WHEN s.s_score>=60 THEN 1 ELSE NULL END)/COUNT(s.s_score) as pass_rate, 
	COUNT(CASE WHEN s.s_score>=70 AND s.s_score<80 THEN 1 ELSE NULL END)/COUNT(s.s_score) as C_rate,
	COUNT(CASE WHEN s.s_score>=80 AND s.s_score<90 THEN 1 ELSE NULL END)/COUNT(s.s_score) as B_rate, 
	COUNT(CASE WHEN s.s_score>=90 THEN 1 ELSE NULL END)/COUNT(s.s_score) as A_rate,
	COUNT(s.s_score) as num_enrollment
FROM Score s, Course
WHERE s.c_id = Course.c_id
GROUP BY s.c_id;

-- Query 15
-- Output both the grade and ranking of students in every courses from high to low. 
-- WHen two students have the same grade leave that rank out
SELECT s1.c_id, s1.s_id, COUNT(s2.s_score)+1 as rank
FROM Score s1 
LEFT JOIN Score s2
ON s1.c_id = s2.c_id
AND s1.s_score < s2.s_score
GROUP BY s1.c_id, s1.s_id
ORDER BY s1.c_id, rank ASC;


-- Query 16
-- Output both the total grade and ranking of students from high to low. 
-- WHen two students have the same grade leave that rank out
-- create total grade table
SELECT tmp.s_id,tmp.sum, @curRank:=@curRank+1 as rank
FROM(
SELECT s.s_id, SUM(s.s_score) as sum
FROM Score s
GROUP BY s.s_id
ORDER BY sum DESC) tmp, (SELECT @curRank:=0) rankTable;

-- Query 17 - skip
-- Query 18 
-- Query the top3 in every courses 
SELECT s1.c_id, s1.s_id, s1.s_score
FROM Score s1 
LEFT JOIN Score s2
ON s1.c_id = s2.c_id
AND s1.s_score < s2.s_score
GROUP BY s1.c_id, s1.s_id, s1.s_score
HAVING COUNT(s2.s_score)<=2
ORDER BY s1.c_id, s1.s_score DESC;

-- faster one
SELECT s1.c_id, s1.s_id
FROM Score s1 LEFT JOIN Score s2 on s1.c_id=s2.c_id AND s1.s_score<s2.s_score
GROUP BY s1.c_id, s1.s_id
HAVING COUNT(s1.s_id)<3;
-- Query 19 - skip

-- Query 20
-- Query to output the id and name of students who only take two courses
SELECT Score.s_id, Student.s_name
FROM Score, Student
WHERE Score.s_id = Student.s_id
GROUP BY Score.s_id
HAVING count(1) = 2;












