<?php
// phpinfo();
ini_set('display_errors', 1);
ini_set('display_startup_errors',1);
error_reporting(E_ALL);

$servername = "127.0.0.1";
$username = "mysql";
$password = "";

try {               
    $conn = new PDO("mysql:host=$servername;dbname=test",$username,$password);
    $conn->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);            
	echo "Connected Successfully";                                                
	trigger_error("ok", E_USER_ERROR);
}                                                                                   
catch(PDOException $e) {                                                
    echo "Connection failed:".$e->getMessage();      
}                                                    
                                                         
?>  
