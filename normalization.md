# Database Normalization (Third Normal Form - 3NF)

**Objective:** Ensure the database is in the Third Normal Form (3NF) to minimize data redundancy and improve data integrity.

## Introduction to Normal Forms

Database normalization is a systematic approach to decompose tables to eliminate data redundancy and undesirable characteristics like insertion, update, and deletion anomalies. It involves a series of guidelines, or "normal forms," the most common of which are 1NF, 2NF, and 3NF.

### First Normal Form (1NF)

* **Definition:** A table is in 1NF if it meets the following conditions:
    * Each table has a primary key.
    * There are no repeating groups within rows.
    * All attributes are atomic (single-valued).
* **Assessment of Current Design:**
    * All tables (`User`, `Property`, `Booking`, `Payment`, `Review`, `Message`) have a clearly defined primary key (`user_id`, `property_id`, `booking_id`, `payment_id`, `review_id`, `message_id`).
    * There are no multi-valued attributes or repeating groups. Each column stores a single, atomic value.
* **Conclusion for 1NF:** The current schema adheres to 1NF.

### Second Normal Form (2NF)

* **Definition:** A table is in 2NF if it meets the following conditions:
    * It is in 1NF.
    * All non-key attributes are fully functionally dependent on the entire primary key. (This rule primarily applies to tables with composite primary keys).
* **Assessment of Current Design:**
    * None of the tables in the current design utilize composite primary keys. Each table has a single-column primary key.
    * For each table, all non-key attributes are fully dependent on their respective single primary key. For example, in the `User` table, `first_name`, `last_name`, `email`, etc., are all directly and fully dependent on `user_id`.
* **Conclusion for 2NF:** The current schema adheres to 2NF.

### Third Normal Form (3NF)

* **Definition:** A table is in 3NF if it meets the following conditions:
    * It is in 2NF.
    * There are no transitive dependencies. This means that non-key attributes should not be dependent on other non-key attributes (i.e., a non-key attribute should not determine another non-key attribute).
* **Assessment of Current Design:**
    * The design has been reviewed for transitive dependencies:
        * **User Table:** All attributes (first_name, last_name, email, password_hash, phone_number, role, created_at) are directly dependent on `user_id`. There are no non-key attributes that determine other non-key attributes.
        * **Property Table:** Attributes like `name`, `description`, `location`, `pricepernight`, `created_at`, `updated_at` are directly dependent on `property_id`. `host_id` is a foreign key correctly linking to the `User` table, without creating a transitive dependency within `Property`.
        * **Booking Table:** `start_date`, `end_date`, `total_price`, `status`, `created_at` are all directly dependent on `booking_id`. `property_id` and `user_id` are foreign keys.
        * **Payment Table:** `amount`, `payment_date`, `payment_method` are directly dependent on `payment_id`. `booking_id` is a foreign key.
        * **Review Table:** `rating`, `comment`, `created_at` are directly dependent on `review_id`. `property_id` and `user_id` are foreign keys.
        * **Message Table:** `message_body`, `sent_at` are directly dependent on `message_id`. `sender_id` and `recipient_id` are foreign keys.
    * The schema effectively uses foreign keys to link related data across separate tables, which is the mechanism to eliminate transitive dependencies and reduce redundancy. For example, User details are not repeated in the Property table; instead, `host_id` serves as a link.
* **Conclusion for 3NF:** The current schema adheres to 3NF.

## Conclusion

The provided database schema is robust and already satisfies the requirements for the **Third Normal Form (3NF)**. It effectively minimizes data redundancy and maximizes data integrity by:

* Ensuring each table has a primary key.
* Ensuring all non-key attributes are fully functionally dependent on the primary key.
* Eliminating transitive dependencies by storing related data in separate, linked tables using foreign keys, avoiding situations where one non-key attribute determines another.

