 # Airbnb-Clone-Project
 
# Overview
The Airbnb Clone Project is a backend-focused simulation of the real Airbnb platform. Developed as part of the learning, this project provides hands-on experience in building scalable, secure, and collaborative web applications that reflect real-world architecture and workflows.

The goal is to master backend development using modern tools and best practices, including:

- Backend architecture with Django
- Relational database design using PostgreSQL
- API security and user authentication
- Team collaboration using Git & GitHub
- Containerization with Docker
- CI/CD pipeline automation using GitHub Actions

  ---

## Team roles

- **Database Administrator** 
-Designs and manages the database schema, ensures data integrity, and handles migrations and optimizations.
- **Backend Developer**
-Implements the core logic of the application, develops API endpoints, integrates the database, and ensures business rules are followed.
- **DevOps Engineer**
-Manages deployment, configures CI/CD pipelines, handles infrastructure, monitors performance, and ensures uptime.
- **project manager**
-Oversees project timelines, coordinates tasks among team members, and ensures documentation is complete.
- **QA engineer**
-Tests features, identifies bugs, and ensures software quality and reliability.

_ _ _

## Technology Stack
- **Django**: Python web framework used to build secure, scalable backend services and APIs.
- **PostgreSQL**:Relational database used to store structured data such as users, bookings, and listings
- **GraphQL**:An API query language allowing clients to request exactly what they need, improving flexibility and performance.
- **Docker**:Containerization platform to package and run the app in isolated environments
- **Celery**:Asynchronous task queue used to handle background tasks like emails and notifications
- **Redis**:An in-memory key-value store used for caching, message brokering, and session management.
- **CI/CD Pipelines**:Automates testing, integration, and deployment of code to improve development efficiency and reliability.
---
## Database Design

### Key Entities
 - **User**
   -  `id`: unique identifier
    -  `name` :Full name
    -  `email` :Email address
    -  `password` :Hashed password
    -  `is-host` : Boolean to distinguish hosts from regular users

-  **Property**
   - ` id`: Unique identifier
   - `title`: Name of the property
    - `description`:Property details
     - `location`: Geographic location
     - `price_per_night` : Cost per night
     - `host_id` : Foreign key to Users
 
-  **Booking**
    - `id`:  Unique identifier
   - `user_id:`  Foreign key to Users
   - `property_id`:  Foreign key to Properties
    - `check_in_date`:  Start date of booking
   - `check_out_date`:  End date of booking

-  **Reviews**
   - `id`: Unique identifier
    - `user_id` : Foreign key to Users
    - `property_id` : Foreign key to Properties
    - `rating` – Star rating (e.g., 1–5)
    - `comment`  – Review content in text form

-  **Payments**
   - `id`: Unique identifier
   - `booking_id`: Foreign key to Bookings
   - `amount`: Payment amount
   -  `payment_method` : e.g., card, PayPal
   -  `status` : Paid, failed, pending
   -  `timestamp` :time of payment

### Entity Relationships

- A **User** can own multiple **Properties** 
- A **User** can make multiple **Bookings** 
- A **Property** can have many **Bookings** and **Reviews** 
- A **Booking** belongs to one **User** and one **Property**
- A **Review** belongs to one **Use**r and one **Property**
- A **Payment** is linked to one **Booking**

### Feature Breakdown
- **User Management**:
   Allow users  to  sign up, log in, and manage their profiles as guests or hosts.
 - **Property Management**:
 Allows hosts to add, update, and manage property details and availability.
- **Booking System**:
 Enables users to select dates and reserve properties. It checks availability, prevents double bookings
- **Review System**:
 Enables the guests to  leave feedback and ratings for properties after their stay
- **Payment Integration** :
  -It handles booking transactions and tracks payment status.

### API Security
 **Authentication**:
- using token-based authentication like JWT it secures login system

 **Authorization**:
- Ensures that only permitted users can access or modify certain resources (e.g., only property owners can edit their properties).

 **Rate Limiting**:
-  Protects the API from brute-force attacks and abuse by limiting repeated requests from clients.

  **Input Validation & Data Sanitization** :
-  Ensures that all incoming data is clean and secure to prevent common vulnerabilities like SQL Injection.

 ## Importance of security
-  Prevents unauthorized access to user information such as emails, passwords, and booking history.
-  Ensures trust and reliability for users interacting with the system.
- Ensures Safe Transactions

  ### CI/CD Pipeline
- CI/CD(Continuous Integration and Continuous Deployment)automates the process of testing, building, and deploying code. it ensures that every change made to the project is automatically tested and can be safely pushed to production or staging environments with minimal manual effort.

 **Benefits**
-  Automates repetitive manual tasks like testing and deployment
- Ensures each update is validated before going live
- Enables smooth collaboration between team members
- Quickly detects bugs and breaks before they reach users
- Accelerates the overall development and delivery process

  **Tools Used**
- **Docker**:Ensures the same environment is used in development, testing, and production.
- **GitHub Actions**:Automates workflows like testing, building and deployment on code pushes or pull requests.
 - **PostgreSQL Service**: Included in Docker to automatically set up the database for testing.



