-- Создание базы данных
CREATE DATABASE lesson03_60;

-- Создание таблицы фермеров
CREATE TABLE farmer (
id serial PRIMARY KEY,
  farmer_name varchar(50),
  age int, 
  height int,
  number_of_children int,
  country varchar(50)
);

-- Заполнение таблицы данными
INSERT INTO farmer (
farmer_name,
  age,
  height,
  number_of_children,
  country
) VALUES 
('Johanes',47,180,5,'Germany'),
('Pierre',40,175,2,'France'),
('Gerard',60,184,4,'Germany'),
('Juan',35,164,1,'Ecuador'),
('Marek',30,186,3,'Poland'),
('John',47,179,2,'France');


-- АГРЕГАЦИИ

-- Найти средний рост всех фермеров (AVG)
SELECT AVG(height) FROM farmer;

SELECT AVG(height) AS avg_farmer_height FROM farmer;
 
-- Найти суммарное количество детей
SELECT SUM(number_of_children) AS children_farmer_sum FROM farmer;

-- Найти самого старшего фермера (MAX)
SELECT MAX(age) AS max_farmer_age FROM farmer;

-- Найти самого низкого фермера (MIN)
SELECT MIN(height) AS min_farmer_height FROM farmer;

-- Подсчитать количество фермеров старше 40 лет (COUNT)
SELECT COUNT(*) FROM farmer WHERE age>40;

-- Подсчитать количество всез фермеров
SELECT COUNT(*) FROM farmer;

-- Группировка
-- Найти минимальное количество детей у фермеров по разным странам
SELECT country, MIN(number_of_children) AS min_children_by_country
FROM farmer GROUP BY country;

-- Вывести страны, в которых живет 2 или больше фермеров
SELECT country, COUNT(*) AS farmer_count FROM farmer GROUP BY country  HAVING COUNT(*) >= 2;

-- Удаление связанных данных
CREATE TABLE truck (

id serial PRIMARY KEY,
  brand varchar(40),
  farmer_id int REFERENCES farmer(id) ON DELETE CASCADE
)

INSERT INTO truck (brand, farmer_id)
VALUES 
('TruckN12',1),
('TruckN1',2),
('TruckN154',1),
('TruckN56',6),
('TruckN872',3),
('TruckN1',5);

DELETE FROM farmer WHERE id=1;

-- ОГРАНИЧЕНИЯ 
CREATE TABLE dress (
id int PRIMARY KEY,
  title varchar(80) UNIQUE NOT NULL,
  price int CHECK(price>0)
  );
  
  -- ОГРАНИЧЕНИЯ - вариант визуализации
  CREATE TABLE dress (
id int PRIMARY KEY,
  title varchar(80) UNIQUE NOT NULL,
  price int CONSTRAINT цена_должна_быть_больше_нуля CHECK(price>0),
    discount_price int CONSTRAINT цена_со_скидкой_должна_быть_больше_нуля CHECK(discount_price>0),
    CONSTRAINT цена_сщ_скидкой_должна_быть_меньше_цены_без_скидки CHECK(discount_price<price)
  );

  -- Наполнение таблицы данными для проверки ограничений и тестирований
 INSERT INTO dress (id, title, price, discount_price)
 VALUES 
  (1, 'green dress' ,120,90),
  (58698, 'black dress',25,24);
  
  DROP TABLE dress;
  
  
-- ИНДЕКСАЦИЯ 
CREATE INDEX idx_farmer_id ON farmer(id);