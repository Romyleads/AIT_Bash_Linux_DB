-- https://drawsql.app/teams/ait-66/diagrams/aggregation - ERD согласно задания

-- Преподаватели
CREATE TABLE teachers (
  teacher_id SERIAL PRIMARY KEY,    
  name VARCHAR(100) NOT NULL        
);

-- Курсы
CREATE TABLE courses (
  course_id SERIAL PRIMARY KEY,     
  course_name VARCHAR(100) NOT NULL,
  teacher_id INTEGER REFERENCES teachers(teacher_id)
);

-- Студенты
CREATE TABLE students (
  student_id SERIAL PRIMARY KEY,    
  name VARCHAR(100) NOT NULL,       
  age INTEGER CHECK (age > 15),     
  country VARCHAR(50)              
);

-- Таблица для связи студентов и курсов (многие ко многим)
CREATE TABLE student_courses (
  student_id INTEGER REFERENCES students(student_id) ON DELETE CASCADE, 
  course_id INTEGER REFERENCES courses(course_id) ON DELETE CASCADE,    
  grade INTEGER CHECK (grade >= 0 AND grade <= 100),                    
  PRIMARY KEY (student_id, course_id)                                   
);

-- Добавляем данные в базу данных

-- Преподавателей
INSERT INTO teachers (name) VALUES
('Сергей Бодров'),
('Николай Караченцев'),
('Андрей Миронов');

-- Курсы
INSERT INTO courses (course_name, teacher_id) VALUES
('Databases', 1),
('High Math', 2),
('Web Development', 3);

-- Студенты
INSERT INTO students (name, age, country) VALUES
('Иван Петров', 20, 'Germany'),
('Николай Седов', 22, 'France'),
('Максим Давний', 19, 'Germany');

-- Студенты, записанные на курсы + с оценками
INSERT INTO student_courses (student_id, course_id, grade) VALUES
(1, 1, 95),
(1, 3, 88),
(2, 2, 76),
(3, 1, 90),
(3, 2, 80);


-- + Индекс для ускорения выборки студентов
CREATE INDEX idx_student_name ON students(name);

-- + Добавление дополнительных ограничений (CONSTRAINT)
ALTER TABLE students
  ADD CONSTRAINT age_check CHECK (age > 15),
  ADD CONSTRAINT name_not_empty CHECK (name <> '');

-- Средний возраст студентов
SELECT AVG(age) AS avg_student_age
FROM students;

-- Общее количество курсов
SELECT COUNT(*) AS total_courses
FROM courses;

-- Максимальный балл среди всех студентов
SELECT MAX(grade) AS max_student_grade
FROM student_courses;

-- Минимальный возраст студентов
SELECT MIN(age) AS min_student_age
FROM students;

-- Количество студентов
SELECT COUNT(*) AS total_students
FROM students;

-- Количество курсов у каждого преподавателя
SELECT teacher_id, COUNT(*) AS course_count
FROM courses
GROUP BY teacher_id;

-- Выводим только те курсы, где больше 1 студента
SELECT course_id, COUNT(student_id) AS student_count
FROM student_courses
GROUP BY course_id
HAVING COUNT(student_id) > 1;

-- Средняя оценка для каждого курса
SELECT course_id, AVG(grade) AS avg_grade
FROM student_courses
GROUP BY course_id;

-- Удаление

-- Удаление студента (проверка ON DELETE CASCADE для связанных записей в student_courses)
DELETE FROM students WHERE student_id=1;

-- Удаление всех студентов из страны 'Germany'
DELETE FROM students WHERE country = 'Germany';

-- Удаление курса по базам данных, к примеру
DELETE FROM courses WHERE course_id = 1;

-- Удалим таблицы которые нужны для теста
DROP TABLE courses,student_courses ;
