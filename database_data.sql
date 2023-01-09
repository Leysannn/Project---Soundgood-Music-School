-- Person data
INSERT INTO person (person_id, name, person_number, age, email, phone, street, zip, city) 
VALUES 
	(1, 'Mikaela Axelsson', 19901123-7643, 31, 'nandretti0@technorati.com', '075-55891466', 'Parkvägen 12', 14534, 'Stockholm'), -- instructor
	(2, 'Sanna Hedlund', 19850723-7574, 36, 'mbinham1@devhub.com', '072-08059747', 'Skolvägen 67', 16788, 'Stockholm'), -- instructor
	(3, 'Mille Holm', 19801007-2619, 41, 'vpolendine2@mit.edu', '070-2111650', 'Björkvägen 23', 16589, 'Stockholm'), -- instructor
	(4, 'Elna Blom', 19880530-8635, 33, 'bhenrych3@mlb.com', '076-67606015', 'Strandvägen 17', 15478, 'Stockholm'), -- instructor	
	(5, 'Mille Holm', 19780426-5023, 43, 'dfrisch4@istockphoto.com', '072-34031464', 'Storgatan 11', 14534, 'Stockholm'), -- instructor
	(6, 'Elvis Forsberg', 19700209-2509, 51, 'bdoncaster5@google.com.hk', '072-34031464', 'Järnvägsgatan 57', 16788, 'Stockholm'), -- instructor
	(7, 'Chris Göransson', 19840721-3751, 37, 'bbauckham6@newsvine.com', '072-34031464', 'Strandvägen 17', 14367, 'Stockholm'), -- instructor
	(8, 'Livia Isaksson', 19721213-4726, 49, 'crivard7@trellian.com', '072-08059747', 'Björkvägen 23', 12978, 'Stockholm'), -- instructor
    (9, 'Sara Svensson', 19870405-9856, 35, 'sara.sven7@trellian.com', '072-56789944', 'Stigvägen 3', 12978, 'Stockholm'); -- instructor

    
-- Instructor data
INSERT INTO instructor(instructor_id, person_id)
VALUES
	(111, 1),
	(222, 2),
	(333, 3),
	(444, 4),
    (555, 5),
    (666, 6),
    (777, 7),
    (888, 8);

-- Lesson data
INSERT INTO lesson (lesson_id, instructor_id, type_of_lesson, nr_of_students, date_and_time)
VALUES
	(1, (SELECT instructor_id from instructor WHERE instructor_id = 111), 'Individual', 1, '2022-11-11 09:00'), 
 	(2, (SELECT instructor_id from instructor WHERE instructor_id = 222), 'Individual', 1, '2022-01-30 09:30'),
	(3, (SELECT instructor_id from instructor WHERE instructor_id = 333), 'Individual', 1, '2022-04-12 10:00'),
	(4, (SELECT instructor_id from instructor WHERE instructor_id = 444), 'Individual', 1, '2022-02-05 11:00'),	
	(5, (SELECT instructor_id from instructor WHERE instructor_id = 222), 'Individual', 1, '2022-01-22 13:30'),
	(6, (SELECT instructor_id from instructor WHERE instructor_id = 333), 'Individual', 1, '2022-10-27 14:00'),
	(25, (SELECT instructor_id from instructor WHERE instructor_id = 555), 'Individual', 1, '2022-11-26 14:30'),
	(26, (SELECT instructor_id from instructor WHERE instructor_id = 666), 'Individual', 1, '2022-04-21 15:30'),
    (27, (SELECT instructor_id from instructor WHERE instructor_id = 777), 'Individual', 1, '2022-09-07 08:30'),
    (28, (SELECT instructor_id from instructor WHERE instructor_id = 444), 'Individual', 1, '2022-12-19 11:00'),
    (29, (SELECT instructor_id from instructor WHERE instructor_id = 888), 'Individual', 1, '2022-01-08 11:30'),
    (30, (SELECT instructor_id from instructor WHERE instructor_id = 111), 'Individual', 1, '2022-05-12 10:00'),
    (31, (SELECT instructor_id from instructor WHERE instructor_id = 222), 'Individual', 1, '2022-06-13 10:30'),
        
 	(7, (SELECT instructor_id from instructor WHERE instructor_id = 111), 'Group', 5, '2022-09-22 14:15'),
	(8, (SELECT instructor_id from instructor WHERE instructor_id = 222), 'Group', 4, '2022-09-28 10:15'),
	(9, (SELECT instructor_id from instructor WHERE instructor_id = 111), 'Group', 8, '2022-08-30 11:15'),
 	(10, (SELECT instructor_id from instructor WHERE instructor_id = 333), 'Group', 6, '2022-03-20 13:15'),
        
 	(11, (SELECT instructor_id from instructor WHERE instructor_id = 111), 'Ensemble', 9, '2022-11-01 17:00'),
 	(12, (SELECT instructor_id from instructor WHERE instructor_id = 444), 'Ensemble', 6, '2022-12-12 08:30'),
 	(13, (SELECT instructor_id from instructor WHERE instructor_id = 333), 'Ensemble', 7, '2022-06-13 09:00'),
 	(14, (SELECT instructor_id from instructor WHERE instructor_id = 222), 'Ensemble', 3, '2022-07-14 09:30'),
 	(15, (SELECT instructor_id from instructor WHERE instructor_id = 111), 'Ensemble', 8, '2022-01-15 10:00'),
 	(16, (SELECT instructor_id from instructor WHERE instructor_id = 444), 'Ensemble', 9, '2022-08-16 10:00'),
    (17, (SELECT instructor_id from instructor WHERE instructor_id = 666), 'Ensemble', 7, '2022-04-17 10:30'),
    (18, (SELECT instructor_id from instructor WHERE instructor_id = 777), 'Ensemble', 8, '2022-05-18 11:00'),
    (19, (SELECT instructor_id from instructor WHERE instructor_id = 555), 'Ensemble', 6, '2022-06-19 11:30'),
    (20, (SELECT instructor_id from instructor WHERE instructor_id = 888), 'Ensemble', 4, '2022-07-20 16:00'),
    (21, (SELECT instructor_id from instructor WHERE instructor_id = 555), 'Ensemble', 5, '2022-09-21 16:30'),
    (22, (SELECT instructor_id from instructor WHERE instructor_id = 777), 'Ensemble', 7, '2022-10-22 13:00'),
    (23, (SELECT instructor_id from instructor WHERE instructor_id = 666), 'Ensemble', 9, '2022-02-23 15:30'),
    (24, (SELECT instructor_id from instructor WHERE instructor_id = 888), 'Ensemble', 3, '2022-03-24 14:00');

-- Ensemble lesson data
INSERT INTO ensemble_lesson (lesson_id, genre, min_participants, max_participants, weekday)
VALUES
	((SELECT lesson_id from lesson WHERE lesson_id = 11), 'Classic', 3, 10, 'Monday'),
    ((SELECT lesson_id from lesson WHERE lesson_id = 12), 'Jazz', 3, 10, 'Tuesday'),
    ((SELECT lesson_id from lesson WHERE lesson_id = 13), 'Classic', 3, 10, 'Wednesday'),
    ((SELECT lesson_id from lesson WHERE lesson_id = 14), 'Rock', 3, 10, 'Thursday'),
    ((SELECT lesson_id from lesson WHERE lesson_id = 15), 'Classic', 3, 10, 'Friday'),
    ((SELECT lesson_id from lesson WHERE lesson_id = 16), 'Pop', 3, 10, 'Monday'),
	((SELECT lesson_id from lesson WHERE lesson_id = 17), 'Pop', 3, 10, 'Wednesday'),
	((SELECT lesson_id from lesson WHERE lesson_id = 18), 'Jazz', 3, 10, 'Thursday'),
	((SELECT lesson_id from lesson WHERE lesson_id = 19), 'Rock', 3, 10, 'Friday'),
	((SELECT lesson_id from lesson WHERE lesson_id = 20), 'Funk', 3, 10, 'Monday'),
	((SELECT lesson_id from lesson WHERE lesson_id = 21), 'Funk', 3, 10, 'Thursday'),
	((SELECT lesson_id from lesson WHERE lesson_id = 22), 'Blues', 3, 10, 'Tuesday'),
	((SELECT lesson_id from lesson WHERE lesson_id = 23), 'Blues', 3, 10, 'Friday'),
	((SELECT lesson_id from lesson WHERE lesson_id = 24), 'Folk', 3, 10, 'Wednesday');

-- Student data
INSERT INTO student (student_id, person_id)
VALUES
	(1111, (SELECT person_id from person WHERE person_id = 1)),
    (2222, (SELECT person_id from person WHERE person_id = 2)),
    (3333, (SELECT person_id from person WHERE person_id = 3)),
    (4444, (SELECT person_id from person WHERE person_id = 4)),
    (5555, (SELECT person_id from person WHERE person_id = 5));

-- Instrument data    
INSERT INTO instrument (instrument_id, type_of_instrument, brand, instructor_id, is_rented, price, student_id)
VALUES
	(1, 'piano', 'yamaha', (SELECT instructor_id from instructor WHERE instructor_id = 111), 1, 100, (SELECT student_id from student WHERE student_id = 1111)),
	(2, 'guitar', 'fender', (SELECT instructor_id from instructor WHERE instructor_id = 222), 0, 200, (SELECT student_id from student WHERE student_id = 2222) ),
	(3, 'saxophone', 'taylor', (SELECT instructor_id from instructor WHERE instructor_id = 111), 1, 150, (SELECT student_id from student WHERE student_id = 3333));