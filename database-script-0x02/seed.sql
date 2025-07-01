-- Users
INSERT INTO users (user_id, name, email, phone_number, password) VALUES
  (gen_random_uuid(), 'sheikh ahmed', 'ahmed.shee@gmail.com', '0712567898', 'hashed_123'),
  (gen_random_uuid(), 'vishal shan', 'vishh.shal@gmail.com', '07111247652', 'hashed_234'),
  (gen_random_uuid(), 'Salma hassan', 'salma.hassan@gmail.com', '0726777798', 'hashed_345');

--  Properties
INSERT INTO properties (property_id, title, description, location, price, host_id) VALUES
  (gen_random_uuid(), 'Shanzu view Hotel', 'Hotel with swimmingpool and fast WiFi.', 'shanzu', 35.00,
   (SELECT user_id FROM users ORDER BY RANDOM() LIMIT 1)),
  (gen_random_uuid(), 'Sunshine cottages', 'wake up to sunshine views and nap to the sound of leaves', 'mombasa', 80.00,
   (SELECT user_id FROM users ORDER BY RANDOM() LIMIT 1));

--  Bookings
INSERT INTO bookings (booking_id, user_id, property_id, start_date, end_date, status, total_price) VALUES
  (gen_random_uuid(),
   (SELECT user_id FROM users ORDER BY RANDOM() LIMIT 1),
   (SELECT property_id FROM properties ORDER BY RANDOM() LIMIT 1),
   CURRENT_DATE + INTERVAL '7 days',
   CURRENT_DATE + INTERVAL '10 days',
   'confirmed', 255.00);

-- Payments
INSERT INTO payments (payment_id, booking_id, amount) VALUES
  (gen_random_uuid(),
   (SELECT booking_id FROM bookings ORDER BY RANDOM() LIMIT 1),
   255.00);

-- Reviews
INSERT INTO reviews (review_id, user_id, property_id, rating, comment) VALUES
  (gen_random_uuid(),
   (SELECT user_id FROM users ORDER BY RANDOM() LIMIT 1),
   (SELECT property_id FROM properties ORDER BY RANDOM() LIMIT 1),
   5, 'Absolutely lovely! Clean and well-furnished.');

--  Messages
INSERT INTO messages (message_id, sender_id, receiver_id, content) VALUES
  (gen_random_uuid(),
   (SELECT user_id FROM users ORDER BY RANDOM() LIMIT 1),
   (SELECT user_id FROM users ORDER BY RANDOM() LIMIT 1),
   'Hello, how many guests are allowed?');
