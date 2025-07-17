<?php

include 'dbconnection.php';
$connection = dbConnection();

if (isset($_POST["name"])) {
    $name = $_POST["name"];
} else return;
if (isset($_POST["email"])) {
    $email = $_POST["email"];
} else return;
if (isset($_POST["password"])) {
    $password = $_POST["password"];
} else return;

$query = "UPDATE `usertable` SET uname='$name', upassword='$password' WHERE uemail='$email'";
$execute = mysqli_query($connection, $query);

$arr = [];

if ($execute) {
    $arr["status"] = "success";
    $arr["message"] = "Record updated successfully";
} else {
    $arr["status"] = "error";
    $arr["message"] = "Failed to update record";
}

print(json_encode($arr));
?>
