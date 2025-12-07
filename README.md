# Library Management System

A PHP-based web application for managing library operations including books, members, staff, and borrowing transactions.

## Prerequisites

To run this project, you need:

1. **PHP 7.4 or higher** - [Download PHP](https://www.php.net/downloads.php)
2. **MySQL 5.7 or higher** - [Download MySQL](https://dev.mysql.com/downloads/mysql/)
3. **Web Server** (Apache/Nginx) OR use PHP's built-in server

**Recommended:** Install [XAMPP](https://www.apachefriends.org/) or [WAMP](https://www.wampserver.com/) which includes PHP, MySQL, and Apache.

## Setup Instructions

### Option 1: Using XAMPP/WAMP (Recommended)

1. **Install XAMPP or WAMP**
   - Download and install from their official websites
   - Make sure Apache and MySQL services are running

2. **Copy Project Files**
   - Copy this project folder to `C:\xampp\htdocs\` (for XAMPP) or `C:\wamp64\www\` (for WAMP)

3. **Configure Database**
   - Open `config.php` and verify database settings:
     ```php
     'host' => 'localhost',
     'database' => 'library_management',
     'username' => 'root',
     'password' => '',  // Change if you have a MySQL password
     ```

4. **Create Database**
   - Open phpMyAdmin (usually at `http://localhost/phpmyadmin`)
   - Import `Library Management.sql` to create the database schema
   - Import `sample_data.sql` to add sample data

5. **Access the Application**
   - Open browser and go to: `http://localhost/DB_Project/index.php`

### Option 2: Using PHP Built-in Server

1. **Install PHP and MySQL**
   - Download PHP from php.net
   - Download MySQL from mysql.com
   - Add PHP to your system PATH

2. **Start MySQL Service**
   ```bash
   # Make sure MySQL service is running
   ```

3. **Create Database**
   ```bash
   mysql -u root -p < "Library Management.sql"
   mysql -u root -p < sample_data.sql
   ```

4. **Start PHP Server**
   ```bash
   php -S localhost:8000
   ```

5. **Access the Application**
   - Open browser and go to: `http://localhost:8000/index.php`

## Database Setup

1. **Create the database schema:**
   ```sql
   mysql -u root -p < "Library Management.sql"
   ```

2. **Add sample data:**
   ```sql
   mysql -u root -p < sample_data.sql
   ```

Or use phpMyAdmin to import both SQL files.

## Default Login Credentials

Based on the sample data, you can login with:

**Manager:**
- User ID: `1`
- Name: `eng.el5oly`
- Role: `Manager`

**Staff:**
- User ID: `2`
- Name: `Sarah`
- Role: `Staff`

**Member:**
- User ID: `5`
- Name: `ahmed`
- Role: `Member`

## Project Structure

```
DB_Project/
├── index.php              # Login page
├── dashboard.php          # Main dashboard
├── config.php             # Database configuration
├── db.php                 # Database connection
├── logout.php             # Logout handler
├── assets/
│   └── style.css         # Stylesheet
├── Library Management.sql # Database schema
└── sample_data.sql       # Sample data
```

## Troubleshooting

- **Database connection error**: Check `config.php` settings and ensure MySQL is running
- **PHP not found**: Add PHP to your system PATH or use XAMPP/WAMP
- **Port already in use**: Change the port in the PHP server command (e.g., `php -S localhost:8080`)



