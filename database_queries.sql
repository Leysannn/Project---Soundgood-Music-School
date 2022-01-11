-- Show the number of lessons given per month during a specified year. (KLAR)

-- Total number of lessons per month during specified year

CREATE VIEW total_lessons AS
SELECT EXTRACT(MONTH FROM lesson.date_and_time) AS Month, COUNT(*) AS nr_of_lessons
FROM lesson
WHERE EXTRACT(YEAR FROM lesson.date_and_time) = '2021'
GROUP BY EXTRACT(MONTH FROM lesson.date_and_time)
ORDER BY EXTRACT(MONTH FROM lesson.date_and_time);

-- Total number of specific type per month during specified year

CREATE VIEW total_specific_lessons AS
SELECT EXTRACT(MONTH FROM lesson.date_and_time) AS Month,
	COUNT(CASE WHEN type_of_lesson = 'Individual' THEN 1 ELSE NULL END) AS individual_lesson,
	COUNT(CASE WHEN type_of_lesson = 'Group' THEN 1 ELSE NULL END) AS group_lesson,
	COUNT(CASE WHEN type_of_lesson = 'Ensemble' THEN 1 ELSE NULL END) AS ensemble_lesson
FROM lesson AS lesson
WHERE EXTRACT(YEAR FROM lesson.date_and_time) = '2021'
GROUP BY EXTRACT(MONTH FROM lesson.date_and_time)
ORDER BY EXTRACT(MONTH FROM lesson.date_and_time);


-- The same as above, but retrieve the average number of lessons per month during the entire year, instead of the total for each month.

-- Average of total number of lessons per month during the entire year

CREATE VIEW average_total_lessons AS
SELECT COUNT(*) / 12 AS average_nr_of_lessons
FROM lesson
WHERE EXTRACT(YEAR FROM lesson.date_and_time) = '2021';   

-- Average of total number of specific lessons per month during the entire year 

CREATE VIEW average_total_specific_lessons AS
SELECT EXTRACT(YEAR FROM lesson.date_and_time) AS year,
	COUNT(CASE WHEN type_of_lesson = 'Individual' THEN 1 ELSE NULL END) / 12 AS individual_lesson,
	COUNT(CASE WHEN type_of_lesson = 'Group' THEN 1 ELSE NULL END) / 12 AS group_lesson,
	COUNT(CASE WHEN type_of_lesson = 'Ensemble' THEN 1 ELSE NULL END) / 12 AS ensemble_lesson
FROM lesson AS lesson
WHERE EXTRACT(YEAR FROM lesson.date_and_time) = '2021'
GROUP BY EXTRACT(YEAR FROM lesson.date_and_time)
ORDER BY EXTRACT(YEAR FROM lesson.date_and_time);

-- Query to find nr of lessons per instructor
CREATE VIEW lessons_per_instructor AS
SELECT instructor_id,
COUNT(*) AS instructed_lessons
FROM lesson
-- WHERE EXTRACT(MONTH FROM lesson.date_and_time) = EXTRACT(MONTH FROM NOW())
WHERE EXTRACT(MONTH FROM lesson.date_and_time) = '01'
GROUP BY instructor_id
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;

CREATE VIEW next_week_ensembles AS
SELECT lesson.lesson_id, ensemble_lesson.genre, date_and_time,
CASE
	WHEN lesson.nr_of_students = ensemble_lesson.max_participants THEN 'Lesson is full'
    WHEN ensemble_lesson.max_participants - lesson.nr_of_students = 1 THEN '1 spot'
    WHEN ensemble_lesson.max_participants - lesson.nr_of_students = 2 THEN '2 spots'
    ELSE '3 or more'
    END spots_available
FROM lesson
INNER JOIN ensemble_lesson ON lesson.lesson_id=ensemble_lesson.lesson_id
WHERE EXTRACT(WEEK FROM date_and_time) = EXTRACT(WEEK FROM NOW())
ORDER BY ensemble_lesson.genre, date_and_time;
















    


