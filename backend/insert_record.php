<?php
// Show PHP errors for debugging
error_reporting(E_ALL);
ini_set('display_errors', 1);

// CORS Headers for Flutter Web
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

// Include DB connection
include 'dbconnection.php';
$connection = dbConnection();

// file_put_contents("debug.log", print_r($_POST, true));
file_put_contents("debug.log", file_get_contents("php://input")); 
file_put_contents("debug_post.log", print_r($_POST, true));       


// Validate incoming POST data
if (isset($_POST["name"], $_POST["email"], $_POST["password"])) {
    $name = $_POST["name"];
    $email = $_POST["email"];
    $password = $_POST["password"];

    $query = "INSERT INTO `usertable` (`uname`, `uemail`, `upassword`) VALUES ('$name', '$email', '$password')";
    $execute = mysqli_query($connection, $query);

    if ($execute) {
        echo json_encode(["status" => "success", "message" => "Record inserted successfully"]);
    } else {
        echo json_encode(["status" => "error", "message" => "DB Error: " . mysqli_error($connection)]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "Missing required fields"]);
}
?>
