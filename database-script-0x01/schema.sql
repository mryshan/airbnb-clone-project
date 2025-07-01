-- database-script-0x01/schema.sql

-- Drop tables if they exist to allow for re-creation during development/testing
-- Order matters due to foreign key constraints: drop child tables before parent tables.
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS Messages;
DROP TABLE IF EXISTS Properties;
DROP TABLE IF EXISTS Users;

--
-- Table: Users
-- Description: Stores information about users, including guests, hosts, and admins.
--
CREATE TABLE Users (
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Primary Key, UUID, auto-generated
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL, -- Email must be unique
    password_hash VARCHAR(255) NOT NULL, -- Storing hashed password
    phone_number VARCHAR(20), -- Optional
    role ENUM('guest', 'host', 'admin') NOT NULL, -- User role
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Automatically set creation timestamp
);

-- Index for faster lookups by email
CREATE INDEX idx_users_email ON Users (email);


--
-- Table: Properties
-- Description: Stores information about properties listed by hosts.
--
CREATE TABLE Properties (
    property_id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Primary Key, UUID, auto-generated
    host_id UUID NOT NULL, -- Foreign Key to Users table (host)
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    price_per_night DECIMAL(10, 2) NOT NULL CHECK (price_per_night > 0), -- Price per night, positive value
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Automatically set creation timestamp
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Automatically update on modification

    FOREIGN KEY (host_id) REFERENCES Users(user_id) ON DELETE CASCADE -- If a host is deleted, their properties are deleted
);

-- Index for faster lookups by host and location
CREATE INDEX idx_properties_host_id ON Properties (host_id);
CREATE INDEX idx_properties_location ON Properties (location);


--
-- Table: Bookings
-- Description: Stores information about property bookings made by guests.
--
CREATE TABLE Bookings (
    booking_id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Primary Key, UUID, auto-generated
    property_id UUID NOT NULL, -- Foreign Key to Properties table
    user_id UUID NOT NULL, -- Foreign Key to Users table (guest)
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL CHECK (total_price > 0), -- Total price, positive value
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL DEFAULT 'pending', -- Booking status
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Automatically set creation timestamp

    FOREIGN KEY (property_id) REFERENCES Properties(property_id) ON DELETE CASCADE, -- If property deleted, bookings for it are deleted
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE, -- If user deleted, their bookings are deleted
    CHECK (end_date >= start_date) -- Ensure end date is not before start date
);

-- Index for faster lookups by property and user
CREATE INDEX idx_bookings_property_id ON Bookings (property_id);
CREATE INDEX idx_bookings_user_id ON Bookings (user_id);


--
-- Table: Payments
-- Description: Records payments for bookings.
--
CREATE TABLE Payments (
    payment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Primary Key, UUID, auto-generated
    booking_id UUID UNIQUE NOT NULL, -- Foreign Key to Bookings table, one payment per booking
    amount DECIMAL(10, 2) NOT NULL CHECK (amount > 0), -- Amount paid, positive value
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Automatically set payment timestamp
    payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,

    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id) ON DELETE CASCADE -- If booking deleted, payment is deleted
);

-- Index for faster lookups by booking
CREATE INDEX idx_payments_booking_id ON Payments (booking_id);


--
-- Table: Reviews
-- Description: Stores reviews written by users for properties.
--
CREATE TABLE Reviews (
    review_id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Primary Key, UUID, auto-generated
    property_id UUID NOT NULL, -- Foreign Key to Properties table
    user_id UUID NOT NULL, -- Foreign Key to Users table (reviewer)
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5), -- Rating between 1 and 5
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Automatically set creation timestamp

    FOREIGN KEY (property_id) REFERENCES Properties(property_id) ON DELETE CASCADE, -- If property deleted, reviews for it are deleted
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE -- If user deleted, their reviews are deleted
);

-- Index for faster lookups by property and user
CREATE INDEX idx_reviews_property_id ON Reviews (property_id);
CREATE INDEX idx_reviews_user_id ON Reviews (user_id);


--
-- Table: Messages
-- Description: Stores messages exchanged between users.
--
CREATE TABLE Messages (
    message_id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Primary Key, UUID, auto-generated
    sender_id UUID NOT NULL, -- Foreign Key to Users table (sender)
    recipient_id UUID NOT NULL, -- Foreign Key to Users table (recipient)
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Automatically set sent timestamp

    FOREIGN KEY (sender_id) REFERENCES Users(user_id) ON DELETE CASCADE, -- If sender deleted, their sent messages are deleted
    FOREIGN KEY (recipient_id) REFERENCES Users(user_id) ON DELETE CASCADE, -- If recipient deleted, their received messages are deleted
    CHECK (sender_id != recipient_id) -- A user cannot send a message to themselves (optional, but good practice)
);

-- Indexes for faster lookups by sender and recipient
CREATE INDEX idx_messages_sender_id ON Messages (sender_id);
CREATE INDEX idx_messages_recipient_id ON Messages (recipient_id);
