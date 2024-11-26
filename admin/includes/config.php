<?php 
// DB credentials.
define('DB_HOST','localhost:8111'); // Add the port number here
define('DB_USER','root');
define('DB_PASS','');
define('DB_NAME','elms_db');
// Establish database connection.
try
{
    $dbh = new PDO("mysql:host=localhost;port=8111;dbname=".DB_NAME, DB_USER, DB_PASS, array(PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES 'utf8'"));
}
catch (PDOException $e)
{
exit("Error: " . $e->getMessage());
}
?>
