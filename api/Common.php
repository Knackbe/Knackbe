<?php
function deliverResponse($app, $httpStatus, $apiResponse) {
	$app->response->setStatus($httpStatus);
	$app->response()->header("Content-Type", "application/json");
	echo $apiResponse;
}

function getAuthorizationHeader($app) {
	$headers = $app->request->headers;
	$authrization_header = "";
	
	foreach($headers as $k=>$v){
		if($k == Configuration::$token_key)
		{
			$authrization_header = $v;
			break;
		}
	}
	
	if($authrization_header == "") {
		$app->error(new OAuthException(401, "Unauthorized", "Token not found"));		
	}
	
	return $authrization_header;
}
?>


