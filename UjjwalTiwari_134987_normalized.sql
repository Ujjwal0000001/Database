
-- Railway Ticket Booking System (Normalized to 3NF)

CREATE DATABASE IF NOT EXISTS railway_db;
USE railway_db;

-- 1. Users
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15),
    gender VARCHAR(10)
);

INSERT INTO Users VALUES
(1, 'Alice', 'alice@example.com', '9876543210', 'Female'),
(2, 'Bob', 'bob@example.com', '9123456789', 'Male'),
(3, 'Carol', 'carol@example.com', '9988776655', 'Female'),
(4, 'David', 'david@example.com', '8899001122', 'Male'),
(5, 'Eve', 'eve@example.com', '7766554433', 'Female');

-- 2. Stations
CREATE TABLE Stations (
    station_id INT PRIMARY KEY,
    station_name VARCHAR(100),
    city VARCHAR(100)
);

INSERT INTO Stations VALUES
(1, 'New Delhi', 'Delhi'),
(2, 'Mumbai Central', 'Mumbai'),
(3, 'Howrah', 'Kolkata'),
(4, 'Chennai Central', 'Chennai'),
(5, 'Secunderabad', 'Hyderabad');

-- 3. Trains
CREATE TABLE Trains (
    train_id INT PRIMARY KEY,
    train_name VARCHAR(100),
    source_station_id INT,
    destination_station_id INT,
    FOREIGN KEY (source_station_id) REFERENCES Stations(station_id),
    FOREIGN KEY (destination_station_id) REFERENCES Stations(station_id)
);

INSERT INTO Trains VALUES
(1, 'Rajdhani Express', 1, 2),
(2, 'Duronto Express', 3, 4),
(3, 'Shatabdi Express', 1, 5),
(4, 'Garib Rath', 4, 2),
(5, 'Tejas Express', 2, 3);

-- 4. Train_Schedule
CREATE TABLE Train_Schedule (
    schedule_id INT PRIMARY KEY,
    train_id INT,
    departure_time TIME,
    arrival_time TIME,
    travel_date DATE,
    FOREIGN KEY (train_id) REFERENCES Trains(train_id)
);

INSERT INTO Train_Schedule VALUES
(1, 1, '08:00:00', '20:00:00', '2025-07-10'),
(2, 2, '09:30:00', '22:30:00', '2025-07-11'),
(3, 3, '07:00:00', '18:00:00', '2025-07-12'),
(4, 4, '10:00:00', '23:00:00', '2025-07-13'),
(5, 5, '06:00:00', '19:00:00', '2025-07-14');

-- 5. Tickets
CREATE TABLE Tickets (
    ticket_id INT PRIMARY KEY,
    user_id INT,
    schedule_id INT,
    booking_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (schedule_id) REFERENCES Train_Schedule(schedule_id)
);

INSERT INTO Tickets VALUES
(1, 1, 1, '2025-07-01', 'Booked'),
(2, 2, 2, '2025-07-02', 'Booked'),
(3, 3, 3, '2025-07-03', 'Cancelled'),
(4, 4, 4, '2025-07-04', 'Booked'),
(5, 5, 5, '2025-07-05', 'Booked');

-- 6. Payments
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    ticket_id INT,
    amount DECIMAL(10, 2),
    payment_mode VARCHAR(50),
    payment_date DATE,
    FOREIGN KEY (ticket_id) REFERENCES Tickets(ticket_id)
);

INSERT INTO Payments VALUES
(1, 1, 1500.00, 'Credit Card', '2025-07-01'),
(2, 2, 1200.00, 'UPI', '2025-07-02'),
(3, 3, 1800.00, 'Net Banking', '2025-07-03'),
(4, 4, 1600.00, 'Debit Card', '2025-07-04'),
(5, 5, 1700.00, 'Wallet', '2025-07-05');

-- 7. Passengers
CREATE TABLE Passengers (
    passenger_id INT PRIMARY KEY,
    ticket_id INT,
    name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    FOREIGN KEY (ticket_id) REFERENCES Tickets(ticket_id)
);

INSERT INTO Passengers VALUES
(1, 1, 'Alice', 30, 'Female'),
(2, 2, 'Bob', 35, 'Male'),
(3, 3, 'Carol', 28, 'Female'),
(4, 4, 'David', 40, 'Male'),
(5, 5, 'Eve', 25, 'Female');

-- 8. DML Operations

-- Update ticket status
UPDATE Tickets SET status = 'Confirmed' WHERE ticket_id = 3;

-- Cancel a ticket
UPDATE Tickets SET status = 'Cancelled' WHERE ticket_id = 2;

-- Delete a passenger
DELETE FROM Passengers WHERE passenger_id = 5;

-- Add new station
INSERT INTO Stations VALUES (6, 'Kanpur Central', 'Kanpur');

-- Search trains from Delhi to Mumbai
SELECT * FROM Trains WHERE source_station_id = 1 AND destination_station_id = 2;
