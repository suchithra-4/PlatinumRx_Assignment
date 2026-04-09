CREATE TABLE users (
    user_id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE bookings (
    booking_id INT PRIMARY KEY,
    user_id INT,
    room_no INT,
    booking_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE items (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(50),
    rate INT
);

CREATE TABLE booking_commercials (
    id INT PRIMARY KEY,
    booking_id INT,
    item_id INT,
    quantity INT,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);