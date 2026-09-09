# Hospital Management System (JSP + Servlet + JDBC + Tomcat 11 + MySQL)

## How to import into Eclipse
1. Extract this zip somewhere on disk.
2. Eclipse -> File -> Import -> General -> Existing Projects into Workspace.
3. Select the extracted `HospitalManagementSystem` folder -> Finish.
4. Right-click project -> Properties -> Targeted Runtimes -> check "Apache Tomcat v11.0"
   (Add the Tomcat 11 server first via Window -> Preferences -> Server -> Runtime Environments if not already added).

## Add the MySQL connector
1. Download `mysql-connector-j-<version>.jar` from https://dev.mysql.com/downloads/connector/j/
2. Copy the jar into `WebContent/WEB-INF/lib/`
3. Right-click project -> Refresh (F5). Eclipse will pick it up automatically for both
   compile-time classpath and runtime deployment.

## Set up the database
1. Open MySQL Workbench / CLI.
2. Run the script in `database/hospital_db.sql`. It creates the `hospital_db`
   database, all 4 tables, a default admin login, and a couple of sample rows.
3. Open `src/com/hms/util/DBConnection.java` and update `USER` / `PASSWORD`
   to match your local MySQL credentials (default assumes user `root`, password `root`).

## Run
1. Right-click project -> Run As -> Run on Server -> choose Tomcat v11.0.
2. Visit: http://localhost:8080/HospitalManagementSystem/
3. Login with username `admin`, password `admin123`.

## Notes
- Built for Tomcat 11 / Jakarta EE (Servlet 6.0) — servlets use `jakarta.servlet.*` imports,
  NOT `javax.servlet.*`. This matters because Tomcat 10+ switched namespaces.
- Servlets are mapped via `@WebServlet` annotations, so no manual `<servlet-mapping>`
  entries are needed in web.xml.
- Password is stored in plain text for simplicity (this is a learning/academic project).
  For anything real, hash passwords (e.g. BCrypt) before storing them.
