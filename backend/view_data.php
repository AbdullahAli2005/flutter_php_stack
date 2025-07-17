<?php

include 'dbconnection.php';
$connection = dbConnection();

$query = "SELECT uid, uname, uemail, upassword FROM `usertable`";
$execute = mysqli_query($connection, $query);

$arr=[];

while ($row=mysqli_fetch_array($execute)) {
    $arr[] = $row;
}

print(json_encode($arr));

?>