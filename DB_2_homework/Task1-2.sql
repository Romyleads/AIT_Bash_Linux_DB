/*
Задание 1
Создайте схему для некоторой предметной области на ваш выбор (например: ресторан, детский сад, ферма), где у вас будет несколько таблиц. Пусть на ней будут отражены отношения: 1:1, 1:many, many:1, many:many.
Задание 2. 
Создайте таблицы со своей схемы с помощью SQL, отразите отношения между ними, задав внешние и первичные ключи.
*/

-- Таблица клиентов
CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY, -- уникальный идентификатор клиента
    name VARCHAR(100) NOT NULL, -- имя клиента
    phone VARCHAR(20) -- телефон
);

-- Таблица меню
CREATE TABLE Menu (
    menu_id SERIAL PRIMARY KEY, -- уникальный идентификатор меню
    name VARCHAR(100) NOT NULL -- название меню
);

-- Таблица блюд (1 меню — много блюд)
CREATE TABLE Dishes (
    dish_id SERIAL PRIMARY KEY, -- уникальный идентификатор блюда
    name VARCHAR(100) NOT NULL, -- название блюда
    price DECIMAL(8, 2) NOT NULL, -- цена блюда
    menu_id INTEGER REFERENCES Menu(menu_id) -- внешний ключ к таблице Menu
);

-- Таблица заказов
CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY, -- уникальный идентификатор заказа
    customer_id INTEGER REFERENCES Customers(customer_id), -- внешний ключ к клиенту
    table_number INTEGER, -- номер стола
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- дата и время заказа
);

-- Промежуточная таблица many:many (состав заказа)
CREATE TABLE OrderItems (
    order_id INTEGER REFERENCES Orders(order_id), -- внешний ключ к заказу
    dish_id INTEGER REFERENCES Dishes(dish_id), -- внешний ключ к блюду
    quantity INTEGER DEFAULT 1, -- количество блюда
    PRIMARY KEY (order_id, dish_id) -- составной ключ для уникальности
);

-- Таблица бронирований (1 клиент — много бронирований)
CREATE TABLE Reservations (
    reservation_id SERIAL PRIMARY KEY, -- уникальный идентификатор бронирования
    customer_id INTEGER REFERENCES Customers(customer_id), -- внешний ключ к клиенту
    reserved_at TIMESTAMP NOT NULL, -- дата и время бронирования
    table_number INTEGER -- номер стола
);