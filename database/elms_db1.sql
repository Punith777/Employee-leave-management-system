-- SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
-- START TRANSACTION;
-- SET time_zone = "+00:00";
-- CREATE DATABASE elms_db;

-- USE elms_db;
-- --
-- -- Database: `elms_db`
-- --

-- -- --------------------------------------------------------

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";
CREATE DATABASE elms_db;

USE elms_db;

-- Table structure for `admin`
CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `UserName` varchar(100) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `updationDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `admin` (`id`, `UserName`, `Password`, `updationDate`) VALUES
(1, 'admin', '0192023a7bbd73250516f069df18b500', '2022-06-03 07:00:14');

-- Table structure for `tbldepartments`
CREATE TABLE `tbldepartments` (
  `id` int(11) NOT NULL,
  `DepartmentName` varchar(150) DEFAULT NULL,
  `DepartmentShortName` varchar(100) NOT NULL,
  `DepartmentCode` varchar(50) DEFAULT NULL,
  `CreationDate` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `tbldepartments` (`id`, `DepartmentName`, `DepartmentShortName`, `DepartmentCode`, `CreationDate`) VALUES
(1, 'Human Resource', 'HR', 'HRD', '2017-11-01 07:16:25'),
(2, 'Information Technology', 'IT', 'ITD', '2017-11-01 07:19:37'),
(3, 'Marketing Department', 'Marketing - updated', 'MktgD', '2022-06-03 05:29:06');

-- Table structure for `tblemployees`
CREATE TABLE `tblemployees` (
  `id` int(11) NOT NULL,
  `EmpId` varchar(100) NOT NULL,
  `FirstName` varchar(150) NOT NULL,
  `LastName` varchar(150) NOT NULL,
  `EmailId` varchar(200) NOT NULL,
  `Password` text NOT NULL,
  `Gender` varchar(100) NOT NULL,
  `Dob` varchar(100) NOT NULL,
  `Department` varchar(255) NOT NULL,
  `Address` varchar(255) NOT NULL,
  `City` varchar(200) NOT NULL,
  `Country` varchar(150) NOT NULL,
  `Phonenumber` char(11) NOT NULL,
  `Status` int(1) NOT NULL,
  `RegDate` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `tblemployees` (`id`, `EmpId`, `FirstName`, `LastName`, `EmailId`, `Password`, `Gender`, `Dob`, `Department`, `Address`, `City`, `Country`, `Phonenumber`, `Status`, `RegDate`) VALUES
(1, '6231415', 'Mark', 'Cooper', 'mcooper@gmail.com', 'c7162ff89c647f444fcaa5c635dac8c3', 'Male', '15 July, 1994', 'Marketing Department', 'There', 'Here', 'Philippines', '0912345678', 1, '2022-06-03 06:50:24');

-- Table structure for `tblleaves`
CREATE TABLE `tblleaves` (
  `id` int(11) NOT NULL,
  `LeaveType` varchar(110) NOT NULL,
  `ToDate` varchar(120) NOT NULL,
  `FromDate` varchar(120) NOT NULL,
  `Description` mediumtext NOT NULL,
  `PostingDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `AdminRemark` mediumtext DEFAULT NULL,
  `AdminRemarkDate` varchar(120) DEFAULT NULL,
  `Status` int(1) NOT NULL,
  `IsRead` int(1) NOT NULL,
  `empid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `tblleaves` (`id`, `LeaveType`, `ToDate`, `FromDate`, `Description`, `PostingDate`, `AdminRemark`, `AdminRemarkDate`, `Status`, `IsRead`, `empid`) VALUES
(1, 'Casual Leave', '07/02/2022', '06/02/2022', 'Sample only', '2022-06-03 07:28:07', 'Sample Approve Remarks', '2022-06-03 13:00:50 ', 1, 1, 3);

-- Table structure for `tblleavetype`
CREATE TABLE `tblleavetype` (
  `id` int(11) NOT NULL,
  `LeaveType` varchar(200) DEFAULT NULL,
  `Description` mediumtext DEFAULT NULL,
  `CreationDate` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `tblleavetype` (`id`, `LeaveType`, `Description`, `CreationDate`) VALUES
(1, 'Casual Leave', 'Casual Leave ', '2017-11-01 12:07:56'),
(2, 'Medical Leave test', 'Medical Leave  test', '2017-11-06 13:16:09'),
(4, 'SL', 'Sick Leave', '2022-06-03 06:46:44');

-- Indexes for tables
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `tbldepartments`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `tblemployees`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `tblleaves`
  ADD PRIMARY KEY (`id`),
  ADD KEY `UserEmail` (`empid`);

ALTER TABLE `tblleavetype`
  ADD PRIMARY KEY (`id`);

-- AUTO_INCREMENT for tables
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `tbldepartments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

ALTER TABLE `tblemployees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE `tblleaves`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `tblleavetype`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

-- Procedures and Functions

-- Procedure to add a new employee
DELIMITER //
CREATE PROCEDURE AddEmployee(
    IN emp_id VARCHAR(100), 
    IN first_name VARCHAR(150), 
    IN last_name VARCHAR(150),
    IN email VARCHAR(200),
    IN password TEXT,
    IN gender VARCHAR(100),
    IN dob VARCHAR(100),
    IN department VARCHAR(255),
    IN address VARCHAR(255),
    IN city VARCHAR(200),
    IN country VARCHAR(150),
    IN phone CHAR(11),
    IN status INT
)
BEGIN
    INSERT INTO tblemployees (EmpId, FirstName, LastName, EmailId, Password, Gender, Dob, Department, Address, City, Country, Phonenumber, Status)
    VALUES (emp_id, first_name, last_name, email, password, gender, dob, department, address, city, country, phone, status);
END //
DELIMITER ;

-- Procedure to request leave
DELIMITER //
CREATE PROCEDURE RequestLeave(
    IN leave_type VARCHAR(110),
    IN to_date VARCHAR(120),
    IN from_date VARCHAR(120),
    IN description MEDIUMTEXT,
    IN status INT,
    IN is_read INT,
    IN emp_id INT
)
BEGIN
    INSERT INTO tblleaves (LeaveType, ToDate, FromDate, Description, Status, IsRead, empid)
    VALUES (leave_type, to_date, from_date, description, status, is_read, emp_id);
END //
DELIMITER ;

-- Function to calculate leave balance for an employee
DELIMITER //
CREATE FUNCTION GetLeaveBalance(emp_id INT) RETURNS INT
BEGIN
    DECLARE total_leaves INT DEFAULT 20;
    DECLARE used_leaves INT;

    SELECT COUNT(*) INTO used_leaves
    FROM tblleaves
    WHERE empid = emp_id AND Status = 1;

    RETURN total_leaves - used_leaves;
END //
DELIMITER ;

-- Function to get department name by ID
DELIMITER //
CREATE FUNCTION GetDepartmentName(dept_id INT) RETURNS VARCHAR(150)
BEGIN
    DECLARE dept_name VARCHAR(150);

    SELECT DepartmentName INTO dept_name
    FROM tbldepartments
    WHERE id = dept_id;

    RETURN dept_name;
END //
DELIMITER ;

COMMIT;
