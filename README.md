# Bike Rental System

## Configuration Notes

### Database (MariaDB / MySQL)

* The database runs on **port 3307** (not the default 3306).
* This is because port 3306 was already in use on the system.
* Ensure your database connection uses:

  ```
  jdbc:mysql://localhost:3307/bike_rental
  ```

---

### Application Server (Apache Tomcat)

* The project uses **Apache Tomcat 10**.
* Default Tomcat port **8080** did not work in our setup.
* The server has been configured to run on:

  ```
  http://localhost:8081/
  ```

---

## How to Run the Project

1. Start **XAMPP** (Apache & MySQL)
2. Open **phpMyAdmin**
3. Create a database:

   ```
   bike_rental
   ```
4. Import the provided `.sql` file
5. Start **Tomcat 10**
6. Open browser:

   ```
   http://localhost:8081/your_project_name
   ```

---

## Notes

* Make sure both **Tomcat** and **MySQL (port 3307)** are running.
* Update database credentials in your project if needed.
