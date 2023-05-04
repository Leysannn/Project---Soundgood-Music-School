CREATE TABLE administrative_staff (
 admin_staff_id INT NOT NULL,
 name VARCHAR(500) NOT NULL,
 email VARCHAR(500) NOT NULL,
 phone VARCHAR(500) NOT NULL
);

ALTER TABLE administrative_staff ADD CONSTRAINT PK_administrative_staff PRIMARY KEY (admin_staff_id);


CREATE TABLE person (
 person_id INT NOT NULL,
 name VARCHAR(500) NOT NULL,
 person_number VARCHAR(12) NOT NULL,
 age SMALLINT NOT NULL,
 email VARCHAR(500) NOT NULL,
 phone VARCHAR(500) NOT NULL,
 street VARCHAR(500) NOT NULL,
 zip INT NOT NULL,
 city VARCHAR(500) NOT NULL
);

ALTER TABLE person ADD CONSTRAINT PK_person PRIMARY KEY (person_id);


CREATE TABLE student (
 student_id INT NOT NULL,
 person_id INT NOT NULL
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (student_id);


CREATE TABLE contact_person (
 student_id INT NOT NULL,
 name VARCHAR(500) NOT NULL,
 email VARCHAR(500) NOT NULL,
 phone VARCHAR(500) NOT NULL
);

ALTER TABLE contact_person ADD CONSTRAINT PK_contact_person PRIMARY KEY (student_id);


CREATE TABLE instructor (
 instructor_id INT NOT NULL,
 person_id INT NOT NULL
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (instructor_id);


CREATE TABLE instructor_payment (
 instructor_payment_id INT NOT NULL,
 price_per_lesson VARCHAR(500) NOT NULL,
 level_of_expertise VARCHAR(500) NOT NULL,
 nr_individual_lesson INT NOT NULL,
 nr_group_ensemble INT NOT NULL,
 instructor_id INT NOT NULL,
 admin_staff_id INT NOT NULL
);

ALTER TABLE instructor_payment ADD CONSTRAINT PK_instructor_payment PRIMARY KEY (instructor_payment_id);


CREATE TABLE instrument (
 instrument_id INT NOT NULL,
 type_of_instrument VARCHAR(500) NOT NULL,
 brand VARCHAR(500),
 instructor_id INT NOT NULL,
 is_rented BIT(1) NOT NULL,
 price INT NOT NULL,
 student_id INT NOT NULL
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (instrument_id);


CREATE TABLE lesson (
 lesson_id INT NOT NULL,
 instructor_id INT NOT NULL,
 type_of_lesson VARCHAR(500) NOT NULL,
 nr_of_students SMALLINT NOT NULL,
 date_and_time TIMESTAMP(6) NOT NULL
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (lesson_id);


CREATE TABLE rental_payment (
 rental_payment_id INT NOT NULL,
 montly_rental_price INT NOT NULL,
 quantity VARCHAR(2),
 lease_period VARCHAR(500) NOT NULL,
 admin_staff_id INT NOT NULL,
 student_id INT,
 instrument_id INT
);

ALTER TABLE rental_payment ADD CONSTRAINT PK_rental_payment PRIMARY KEY (rental_payment_id);


CREATE TABLE siblings (
 siblings_id INT NOT NULL,
 nr_of_siblings SMALLINT,
 attends_same_month BIT(1) NOT NULL,
 student_id INT
);

ALTER TABLE siblings ADD CONSTRAINT PK_siblings PRIMARY KEY (siblings_id);


CREATE TABLE application (
 application_id INT NOT NULL,
 contact_details VARCHAR(500) NOT NULL,
 level_of_expertise VARCHAR(500) NOT NULL,
 accepted BIT(1) NOT NULL,
 admin_staff_id INT NOT NULL,
 person_id INT NOT NULL,
 instrument_id INT
);

ALTER TABLE application ADD CONSTRAINT PK_application PRIMARY KEY (application_id);


CREATE TABLE booking (
 booking_id INT NOT NULL,
 instructor_id INT NOT NULL,
 admin_staff_id INT NOT NULL,
 date_and_time TIMESTAMP(6) NOT NULL,
 student_id INT
);

ALTER TABLE booking ADD CONSTRAINT PK_booking PRIMARY KEY (booking_id);


CREATE TABLE discount (
 siblings_id INT NOT NULL,
 amount_of_discount VARCHAR(500) NOT NULL
);

ALTER TABLE discount ADD CONSTRAINT PK_discount PRIMARY KEY (siblings_id);


CREATE TABLE ensemble_lesson (
 lesson_id INT NOT NULL,
 genre VARCHAR(500) NOT NULL,
 min_participants VARCHAR(500) NOT NULL,
 max_participants VARCHAR(500) NOT NULL,
 weekday VARCHAR(500) NOT NULL
);

ALTER TABLE ensemble_lesson ADD CONSTRAINT PK_ensemble_lesson PRIMARY KEY (lesson_id);


CREATE TABLE group_lesson (
 lesson_id INT NOT NULL,
 level_of_expertise VARCHAR(500) NOT NULL,
 min_participants SMALLINT NOT NULL,
 max_participants SMALLINT NOT NULL,
 type_of_instrument VARCHAR(500) NOT NULL
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (lesson_id);


CREATE TABLE individual_lesson (
 lesson_id INT NOT NULL,
 booking_id INT NOT NULL
);

ALTER TABLE individual_lesson ADD CONSTRAINT PK_individual_lesson PRIMARY KEY (lesson_id);


CREATE TABLE sibling_person (
 siblings_id INT NOT NULL,
 person_id INT NOT NULL
);

ALTER TABLE sibling_person ADD CONSTRAINT PK_sibling_person PRIMARY KEY (siblings_id,person_id);


CREATE TABLE student_ensemble_lesson (
 lesson_id INT NOT NULL,
 student_id INT NOT NULL
);

ALTER TABLE student_ensemble_lesson ADD CONSTRAINT PK_student_ensemble_lesson PRIMARY KEY (lesson_id,student_id);


CREATE TABLE student_group_lesson (
 lesson_id INT NOT NULL,
 student_id INT NOT NULL
);

ALTER TABLE student_group_lesson ADD CONSTRAINT PK_student_group_lesson PRIMARY KEY (lesson_id,student_id);


CREATE TABLE student_payment (
 student_payment_id INT NOT NULL,
 price_level1_individual VARCHAR(500) NOT NULL,
 price_level1_group VARCHAR(500) NOT NULL,
 price_level2_individual VARCHAR(500) NOT NULL,
 price_level2_group VARCHAR(500) NOT NULL,
 admin_staff_id INT NOT NULL,
 siblings_id INT NOT NULL,
 sibling_discount VARCHAR(100),
 student_id INT
);

ALTER TABLE student_payment ADD CONSTRAINT PK_student_payment PRIMARY KEY (student_payment_id);


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (person_id) REFERENCES person (person_id);


ALTER TABLE contact_person ADD CONSTRAINT FK_contact_person_0 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (person_id) REFERENCES person (person_id);


ALTER TABLE instructor_payment ADD CONSTRAINT FK_instructor_payment_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);
ALTER TABLE instructor_payment ADD CONSTRAINT FK_instructor_payment_1 FOREIGN KEY (admin_staff_id) REFERENCES administrative_staff (admin_staff_id);


ALTER TABLE instrument ADD CONSTRAINT FK_instrument_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);
ALTER TABLE instrument ADD CONSTRAINT FK_instrument_1 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE lesson ADD CONSTRAINT FK_lesson_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);


ALTER TABLE rental_payment ADD CONSTRAINT FK_rental_payment_0 FOREIGN KEY (admin_staff_id) REFERENCES administrative_staff (admin_staff_id);
ALTER TABLE rental_payment ADD CONSTRAINT FK_rental_payment_1 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE rental_payment ADD CONSTRAINT FK_rental_payment_2 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);


ALTER TABLE siblings ADD CONSTRAINT FK_siblings_0 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE application ADD CONSTRAINT FK_application_0 FOREIGN KEY (admin_staff_id) REFERENCES administrative_staff (admin_staff_id);
ALTER TABLE application ADD CONSTRAINT FK_application_1 FOREIGN KEY (person_id) REFERENCES person (person_id);
ALTER TABLE application ADD CONSTRAINT FK_application_2 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);


ALTER TABLE booking ADD CONSTRAINT FK_booking_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);
ALTER TABLE booking ADD CONSTRAINT FK_booking_1 FOREIGN KEY (admin_staff_id) REFERENCES administrative_staff (admin_staff_id);
ALTER TABLE booking ADD CONSTRAINT FK_booking_2 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE discount ADD CONSTRAINT FK_discount_0 FOREIGN KEY (siblings_id) REFERENCES siblings (siblings_id);


ALTER TABLE ensemble_lesson ADD CONSTRAINT FK_ensemble_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);


ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);


ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);
ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_1 FOREIGN KEY (booking_id) REFERENCES booking (booking_id);


ALTER TABLE sibling_person ADD CONSTRAINT FK_sibling_person_0 FOREIGN KEY (siblings_id) REFERENCES siblings (siblings_id);
ALTER TABLE sibling_person ADD CONSTRAINT FK_sibling_person_1 FOREIGN KEY (person_id) REFERENCES person (person_id);


ALTER TABLE student_ensemble_lesson ADD CONSTRAINT FK_student_ensemble_lesson_0 FOREIGN KEY (lesson_id) REFERENCES ensemble_lesson (lesson_id);
ALTER TABLE student_ensemble_lesson ADD CONSTRAINT FK_student_ensemble_lesson_1 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE student_group_lesson ADD CONSTRAINT FK_student_group_lesson_0 FOREIGN KEY (lesson_id) REFERENCES group_lesson (lesson_id);
ALTER TABLE student_group_lesson ADD CONSTRAINT FK_student_group_lesson_1 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE student_payment ADD CONSTRAINT FK_student_payment_0 FOREIGN KEY (admin_staff_id) REFERENCES administrative_staff (admin_staff_id);
ALTER TABLE student_payment ADD CONSTRAINT FK_student_payment_1 FOREIGN KEY (siblings_id) REFERENCES discount (siblings_id);
ALTER TABLE student_payment ADD CONSTRAINT FK_student_payment_2 FOREIGN KEY (student_id) REFERENCES student (student_id);


