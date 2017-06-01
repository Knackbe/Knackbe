<?php

require_once 'Slim\Slim.php';


\Slim\Slim::registerAutoloader();


require_once 'Model/APIException.php';
require_once 'Config/Configuration.php';
require_once 'Common.php';
require_once 'Config/Connection.php';

require_once 'Model/UserRequest.php';


$app = new \Slim\Slim();

// Set default timezone
date_default_timezone_set('Asia/Calcutta');

$app->error(function (\Exception $e) use ($app) {
    if ($e instanceof \APIException) {
		$app->response->setStatus($e->statusCode);
		$app->response()->header("Content-Type", "application/json");
		echo json_encode($e);
	} else if ($e instanceof \OAuthException) {
		$oauthErrorResponse = new OAuthErrorResponse($e->error_code, $e->error_description);
        $app->response->setStatus($e->error_status_code);
		$app->response()->header("Content-Type", "application/json");
		echo json_encode($oauthErrorResponse);
	} else {
        echo "Exception";
    }	
});



$app->get("/user", function () use ($app) {
	
	$connection = new createConnection(); //i created a new object

	$connect = $connection->connectToDatabase(); // connected to the database

	$getUserResp = getUser($connect);

	deliverResponse($app, 200, json_encode($getUserResp));

	$connection->closeConnection();
	
});


$app->get("/user/:id", function ($id) use ($app) {
	
	$connection = new createConnection(); //i created a new object

	$connect = $connection->connectToDatabase(); // connected to the database

	$getUserResp = getUserById($connect,$id);

	deliverResponse($app, 200, json_encode($getUserResp));

	$connection->closeConnection();
	
});


$app->post("/user/register", function () use($app) {

	$connection = new createConnection(); //i created a new object

	$connect = $connection->connectToDatabase(); // connected to the database

	$UserRegisterRequest = json_decode($app->request()->getBody());
	
	if(!is_object($UserRegisterRequest)) {
		$app->error(new APIException("url", 400, "Invalid details", "Invalid details", "NotObject", 123, "Invalid Object"));
	}

	if(!property_exists($UserRegisterRequest, 'EmailAddress')) {
		$app->error(new APIException("url", 400, "EmailAddress can not be empty", "EmailAddress can not be empty", "NotNull", 111, "EmailAddress field missing"));
	}

	$UserRegisterRequestResp = registerUser($UserRegisterRequest,$connect);

	deliverResponse($app, 200, json_encode($UserRegisterRequestResp));

	$connection->closeConnection();

});



$app->post("/user/addnew", function () use($app) {

	$connection = new createConnection(); //i created a new object

	$connect = $connection->connectToDatabase(); // connected to the database

	$UserAddNewRequest = json_decode($app->request()->getBody());
	
	if(!is_object($UserAddNewRequest)) {
		$app->error(new APIException("url", 400, "Invalid details", "Invalid details", "NotObject", 123, "Invalid Object"));
	}

	$UserAddNewRequestResp = addNewUser($UserAddNewRequest,$connect);

	deliverResponse($app, 200, json_encode($UserAddNewRequestResp));

	$connection->closeConnection();

});



$app->put("/user/update/:id", function ($id) use($app) {

	$connection = new createConnection(); //i created a new object

	$connect = $connection->connectToDatabase(); // connected to the database

	$UserUpdateRequest = json_decode($app->request()->getBody());
	
	if(!is_object($UserUpdateRequest)) {
		$app->error(new APIException("url", 400, "Invalid details", "Invalid details", "NotObject", 123, "Invalid Object"));
	}

	$UserUpdateRequestResp = updateUser($id,$UserUpdateRequest,$connect);

	deliverResponse($app, 200, json_encode($UserUpdateRequestResp));

	$connection->closeConnection();

});


$app->get("/user/validate/:email", function ($email) use($app) {

	$connection = new createConnection(); //i created a new object

	$connect = $connection->connectToDatabase(); // connected to the database

	$UserValidateResp = validateUser($email,$connect);

	deliverResponse($app, 200, json_encode($UserValidateResp));

	$connection->closeConnection();

});


$app->post("/user/validate", function () use($app) {

	$connection = new createConnection(); //i created a new object

	$connect = $connection->connectToDatabase(); // connected to the database

	$UserValidateRequest = json_decode($app->request()->getBody());


	if(!is_object($UserValidateRequest)) {
		$app->error(new APIException("url", 400, "Invalid details", "Invalid details", "NotObject", 123, "Invalid Object"));
	}

	$UserValidateRequestResp = validateUserEm($UserValidateRequest,$connect);
	
	deliverResponse($app, 200, json_encode($UserValidateRequestResp));

	$connection->closeConnection();

});


$app->put("/user/setpassword", function () use($app) {

	$connection = new createConnection(); //i created a new object

	$connect = $connection->connectToDatabase(); // connected to the database

	$UserUpdateRequest = json_decode($app->request()->getBody());
	
	if(!is_object($UserUpdateRequest)) {
		$app->error(new APIException("url", 400, "Invalid details", "Invalid details", "NotObject", 123, "Invalid Object"));
	}

	$UserUpdateRequestResp = setpassword($UserUpdateRequest,$connect);

	deliverResponse($app, 200, json_encode($UserUpdateRequestResp));

	$connection->closeConnection();

});


$app->delete("/user/:id", function ($id) use ($app) {

	$connection = new createConnection(); //i created a new object

	$connect = $connection->connectToDatabase(); // connected to the database

	$deleteUserResp = deleteUser($connect,$id);

	deliverResponse($app, 200, json_encode($deleteUserResp));

	$connection->closeConnection();

});


// run the Slim app
$app->run();

echo "ttttt";exit;

?>