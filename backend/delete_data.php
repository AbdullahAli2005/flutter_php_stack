<?php

include 'dbconnection.php';
$connection = dbConnection();

if (isset($_POST["uid"])) {
    $id = $_POST["uid"];
} else {
    die("ID not set");
}

$query = "DELETE FROM `usertable` WHERE uid = '$id'";
$execute = mysqli_query($connection, $query);

$arr=[];

if($execute) {
    $arr["status"] = "success";
    $arr["message"] = "Record deleted successfully";
} else {
    $arr["status"] = "error";
    $arr["message"] = "Failed to delete record: " . mysqli_error($connection);
}

print(json_encode($arr));

?>