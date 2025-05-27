/*
1. Создание пользователя
Создай нового пользователя PostgreSQL с именем maria и паролем secure123.

2. Создание базы данных
Создай базу данных college_db, владельцем которой будет пользователь maria.

3. Создание таблицы
Создай таблицу students с полями:

id — автоинкремент,

name — строка до 80 символов,

age — целое число,

hobby — строка до 80 символов.

4. Вставка нескольких строк
Добавь в таблицу students следующих студентов:

Timur, 25, chess

Diana, 34, painting

Maria, 22, dance

5. Выборка всех имён и хобби
Выведи имена и увлечения всех студентов.

6. Фильтрация по возрасту
Выведи имена всех студентов, чей возраст меньше 30 лет.

7. Удаление всех записей
Удалить всех студентов из таблицы.

8. Удаление по условию (OR)
Удалить всех студентов, чей возраст равен 50 или чьё хобби — chess.

9. Удаление по условию (AND)
Удалить студентов, у которых хобби dance и возраст больше 25 лет.

10. Сортировка по возрасту
Выведи имена и возраст всех студентов, отсортированных по убыванию возраста.

11. Вставка одной строки
Добавь в таблицу студента Sergey, 50 лет, хобби — гитара.

12. Обновление возраста
Измени возраст студента по имени Maria на 23 года.

13. Удаление по хобби
Удалить всех студентов, увлекающихся рисованием.

14. Выборка уникальных хобби
Выведи список уникальных увлечений (без повторов).

15. Подсчёт количества студентов
Сколько студентов сейчас в таблице?
*/

CREATE DATABASE college_db; -- создаём базу данных
USE college_db; -- подключаемся к базе

CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(80),
    age INT,
    hobby VARCHAR(80)
); -- создаём таблицу

INSERT INTO students (name, age, hobby) VALUES
('Timur', 25, 'chess'),
('Diana', 34, 'painting'),
('Maria', 22, 'chess'),
('Sergey', 50, 'гитара'),
('Lena', 30, 'painting'),
('Oleg', 28, 'dance'); -- добавляем студентов

SELECT name, hobby FROM students; -- выводим имена и хобби

SELECT name, age FROM students WHERE age < 30; -- выбираем студентов младше 30 лет

DELETE FROM students; -- удаляем всех студентов

SELECT * FROM students; -- проверяем содержимое таблицы

INSERT INTO students (name, age, hobby) VALUES
('Timur', 25, 'chess'),
('Diana', 34, 'painting'),
('Maria', 22, 'chess'),
('Sergey', 50, 'гитара'),
('Lena', 30, 'painting'),
('Oleg', 28, 'dance'); -- возвращаем студентов

DELETE FROM students WHERE age = 50 OR hobby = 'chess'; -- удаляем студентов с age = 50 или хобби chess

SELECT * FROM students; -- проверяем результат

TRUNCATE TABLE students; -- очищаем таблицу (в MySQL id сбрасывается автоматически)

INSERT INTO students (name, age, hobby) VALUES
('Timur', 25, 'chess'),
('Diana', 34, 'painting'),
('Maria', 22, 'chess'),
('Sergey', 50, 'гитара'),
('Lena', 30, 'painting'),
('Oleg', 28, 'dance'); -- снова добавляем студентов

DELETE FROM students WHERE hobby = 'dance' AND age > 25; -- удаляем студентов с хобби dance и возрастом больше 25

SELECT * FROM students; -- проверяем таблицу

TRUNCATE TABLE students; -- снова очищаем таблицу и сбрасываем id

INSERT INTO students (name, age, hobby) VALUES
('Timur', 25, 'chess'),
('Diana', 34, 'painting'),
('Maria', 22, 'chess'),
('Sergey', 50, 'гитара'),
('Lena', 30, 'painting'),
('Oleg', 28, 'dance'); -- снова добавляем студентов

SELECT name, age FROM students ORDER BY age DESC; -- сортируем студентов по убыванию возраста

INSERT INTO students (name, age, hobby)
VALUES ('Alex', 28, 'chess'); -- добавляем нового студента

UPDATE students SET age = 23 WHERE name = 'Maria'; -- обновляем возраст у Maria

SELECT * FROM students; -- проверяем содержимое таблицы

DELETE FROM students WHERE hobby = 'painting'; -- удаляем студентов с хобби painting

SELECT * FROM students; -- проверяем результат

SELECT DISTINCT hobby FROM students; -- выводим уникальные хобби

SELECT COUNT(*) FROM students; -- считаем количество студентов