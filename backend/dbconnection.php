<?php

function dbConnection (){
    $connection = mysqli_connect("localhost", "root", "", "practice");
    return $connection;
}

?>