# Database Schema (DDL)

This directory contains the SQL Data Definition Language (DDL) scripts for the Airbnb clone database.

## Files:
- `schema.sql`: Contains the `CREATE TABLE` statements for all entities, including primary keys, foreign keys, constraints, and indexes. This script defines the entire structure of the database.

## Database System:
The `schema.sql` script is primarily designed for **PostgreSQL** due to the use of `UUID PRIMARY KEY DEFAULT gen_random_uuid()` for UUID generation and `ENUM` types. While the general SQL syntax is standard, some functions/types might require minor adjustments for other RDBMS (e.g., MySQL's `UUID()` function or trigger-based `updated_at` for PostgreSQL for `ON UPDATE CURRENT_TIMESTAMP`).

## Usage:

To set up the database schema, you can execute the `schema.sql` script using a SQL client for your database system.

**Example (using `psql` for PostgreSQL):**

1.  **Connect to your PostgreSQL database:**
    ```bash
    psql -U your_username -d your_database_name -h your_host
    ```
    (Replace `your_username`, `your_database_name`, and `your_host` with your actual credentials.)

2.  **Execute the schema script:**
    ```sql
    \i /path/to/alx-airbnb-database/database-script-0x01/schema.sql
    ```
    (Replace `/path/to/alx-airbnb-database/` with the actual absolute path to your repository on your system.)

**General Steps:**

1.  Ensure you have a PostgreSQL (or compatible) database server running.
2.  Create an empty database where you want to deploy this schema.
3.  Connect to that database using a SQL client (e.g., `psql` command line tool, pgAdmin, DBeaver, MySQL Workbench if adjusted for MySQL).
4.  Run the contents of the `schema.sql` file.

This will create all the necessary tables, define their relationships, and apply the specified constraints and indexes.
