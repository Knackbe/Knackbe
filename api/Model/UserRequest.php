<?php

function registerUser($data,$con){

	$dataDec = json_decode(json_encode($data), true);
	

	$exception = array();

	if(isset($dataDec['FirstName']))	
		$FirstName = $dataDec['FirstName'];
	else
		$FirstName = '';

	if(isset($dataDec['MiddleName']))	
		$MiddleName = $dataDec['MiddleName'];
	else
		$MiddleName = '';

	if(isset($dataDec['LastName']))	
		$LastName = $dataDec['LastName'];
	else
		$LastName = '';

	if(isset($dataDec['EmailAddress']))	
		$EmailAddress = strtolower($dataDec['EmailAddress']);
	else
		$EmailAddress = '';
	
	if(isset($dataDec['Address1']))	
		$Address1 = $dataDec['Address1'];
	else
		$Address1 = '';

	if(isset($dataDec['Address2']))	
		$Address2 = $dataDec['Address2'];
	else
		$Address2 = '';

	if(isset($dataDec['City']))	
		$City = $dataDec['City'];
	else
		$City = '';

	if(isset($dataDec['State']))	
		$State = $dataDec['State'];
	else
		$State = '';

	if(isset($dataDec['Country']))	
		$Country = $dataDec['Country'];
	else
		$Country = '';

	if(isset($dataDec['Password']))	
		$Password = md5($dataDec['Password']);
	else
		$Password = '';

	if(isset($dataDec['Gender']))	
		$Gender = $dataDec['Gender'];
	else
		$Gender = '';

	if(isset($dataDec['DateOfBirth']))	
		$DateOfBirth = $dataDec['DateOfBirth'];
	else
		$DateOfBirth = '';

	if(isset($dataDec['Mobile']))	
		$Mobile = $dataDec['Mobile'];
	else
		$Mobile = '';

	//Validation for email address
	$respEmail = array();

	$sqlEmail = "select count(Id) rowCount from users where EmailId = '".$EmailAddress."'";

	if(!mysqli_query($con,$sqlEmail))
    {
        $exception['error'] = "Problem while fetching email address";

		return $exception;

    }else{

		$result = mysqli_query($con,$sqlEmail);

		$respEmail = mysqli_fetch_array($result, MYSQLI_ASSOC);
		
		if($respEmail['rowCount'] > 0){
			
			$exception['error'] = "Email address already exist";

			return $exception;
		}

	}


	//Validation for mobile number
	$respMobile = array();

	$sqlMobile = "select count(Id) rowCount from users where Mobile !='' && mobile = '".$Mobile."'";

	if(!mysqli_query($con,$sqlMobile))
    {
        $exception['error'] = "Problem while fetching mobile no";

		return $exception;

    }else{

		$result = mysqli_query($con,$sqlMobile);

		$respMobile = mysqli_fetch_array($result, MYSQLI_ASSOC);
		
		if($respMobile['rowCount'] > 0){
			
			$exception['error'] = "Mobile no. already exist";

			return $exception;
		}

	}
	
	
	$sql = "INSERT INTO users(FirstName, MiddleName, LastName, EmailId, Address1, Address2, City, State, Country, Password, Mobile, Gender, DateOfBirth)
    VALUES('".$FirstName."', '".$MiddleName."', '".$LastName."', '".$EmailAddress."' , '".$Address1."', '".$Address2."', '".$City."', '".$State."', '".$Country."', '".$Password."', '".$Mobile."', '".$Gender."', '".$DateOfBirth."')";
	
	

    if(!mysqli_query($con,$sql))
    {
        $exception['error'] = "Problem while adding record";

		return $exception;

    }else{
		$exception['success'] = "User Added Successfully";
	}
	
	return $exception;
}



function getUser($con){
	
	$data = array();
	
	$post = array();
	
	$sql = "select users.Id, users.FirstName,users.MiddleName, users.LastName, users.Address1, users.Address2, users.Gender, users.DateOfBirth from users";

    if(!mysqli_query($con,$sql))
    {
        $post['error'] = "Problem while fetching the user list";

    }else{

		$result = mysqli_query($con,$sql);

		while($row = $result->fetch_assoc()) {
	        $post[] = $row;
	    }

	}

	$data = $post;

	return $data;
}


function getUserById($con,$id){
	
	$data = array();
	
	$post = array();

	$sql = "select users.Id, users.FirstName,users.MiddleName, users.LastName, users.Address1, users.Address2, users.Gender, users.DateOfBirth from users where users.Id = $id";
	
    if(!mysqli_query($con,$sql))
    {
        $data['error'] = "Problem while fetching the user details";

    }else{

		$result = mysqli_query($con,$sql);

		while($row = $result->fetch_assoc()) {
	        $post[] = $row;
	    }
		

	}

	$data = $post;

	return $data;
}


function updateUser($id,$data,$con){

	$dataDec = json_decode(json_encode($data), true);
	
	$exception = array();

	$respUserData = array();

	$userData = "select * from users where Id = $id";


	if(!mysqli_query($con,$userData))
    {
        $exception['error'] = "Problem while fetching user data by ID";

		return $exception;

    }else{

		$resultUserData = mysqli_query($con,$userData);

		$respUserData = mysqli_fetch_array($resultUserData, MYSQLI_ASSOC);

	}

	if(isset($dataDec['FirstName'])){
		$FirstName = $dataDec['FirstName'];
	}else if(isset($respUserData['FirstName'])){
		$FirstName = $respUserData['FirstName'];
	}else{
		$FirstName = '';
	}


	if(isset($dataDec['MiddleName'])){
		$MiddleName = $dataDec['MiddleName'];
	}else if(isset($respUserData['MiddleName'])){
		$MiddleName = $respUserData['MiddleName'];
	}else{
		$MiddleName = '';
	}

	if(isset($dataDec['LastName'])){
		$LastName = $dataDec['LastName'];
	}else if(isset($respUserData['LastName'])){
		$LastName = $respUserData['LastName'];
	}else{
		$LastName = '';
	}

	if(isset($dataDec['EmailAddress'])){
		$EmailAddress = strtolower($dataDec['EmailAddress']);
	}else if(isset($respUserData['EmailAddress'])){
		$EmailAddress = $respUserData['EmailAddress'];
	}else{
		$EmailAddress = '';
	}
	
	if(isset($dataDec['Address1'])){
		$Address1 = $dataDec['Address1'];
	}else if(isset($respUserData['Address1'])){
		$Address1 = $respUserData['Address1'];
	}else{
		$Address1 = '';
	}

	if(isset($dataDec['Address2'])){
		$Address2 = $dataDec['Address2'];
	}else if(isset($respUserData['Address2'])){
		$Address2 = $respUserData['Address2'];
	}else{
		$Address2 = '';
	}

	if(isset($dataDec['City'])){
		$City = $dataDec['City'];
	}else if(isset($respUserData['City'])){
		$City = $respUserData['City'];
	}else{
		$City = '';
	}

	if(isset($dataDec['State'])){
		$State = $dataDec['State'];
	}else if(isset($respUserData['State'])){
		$State = $respUserData['State'];
	}else{
		$State = '';
	}

	if(isset($dataDec['Country'])){
		$Country = $dataDec['Country'];
	}else if(isset($respUserData['Country'])){
		$Country = $respUserData['Country'];
	}else{
		$Country = '';
	}

	if(isset($dataDec['Password'])){
		$Password = md5($dataDec['Password']);
	}else if(isset($respUserData['Password'])){
		$Password = $respUserData['Password'];
	}else{
		$Password = '';
	}

	if(isset($dataDec['Gender'])){
		$Gender = $dataDec['Gender'];
	}else if(isset($respUserData['Gender'])){
		$Gender = $respUserData['Gender'];
	}else{
		$Gender = '';
	}

	if(isset($dataDec['DateOfBirth'])){
		$DateOfBirth = $dataDec['DateOfBirth'];
	}else if(isset($respUserData['DateOfBirth'])){
		$DateOfBirth = $respUserData['DateOfBirth'];
	}else{
		$DateOfBirth = '';
	}

	if(isset($dataDec['Mobile'])){
		$Mobile = $dataDec['Mobile'];
	}else if(isset($respUserData['Mobile'])){
		$Mobile = $respUserData['Mobile'];
	}else{
		$Mobile = '';
	}

	//Validation for email address
	$respEmail = array();


	$sqlEmail = "select Id from users where EmailId = '".$EmailAddress."'";


	if(!mysqli_query($con,$sqlEmail))
    {
        $exception['error'] = "Problem while fetching email address";

		return $exception;

    }else{

		$result = mysqli_query($con,$sqlEmail);

		$respEmail = mysqli_fetch_array($result, MYSQLI_ASSOC);
		
		if(isset($respEmail['id']) && $respEmail['id'] !=  $id){

			$exception['error'] = "Email address already exist";

			return $exception;
		}

	}


	//Validation for mobile number
	$respMobile = array();


	$sqlMobile = "select Id from users where Mobile != '' && mobile = '".$Mobile."'";


	if(!mysqli_query($con,$sqlMobile))
    {
        $exception['error'] = "Problem while fetching mobile no";

		return $exception;

    }else{

		$result = mysqli_query($con,$sqlMobile);

		$respMobile = mysqli_fetch_array($result, MYSQLI_ASSOC);
		
		if(isset($respMobile['id']) && $respMobile['id'] !=  $id){
			
			$exception['error'] = "Mobile no. already exist";

			return $exception;
		}

	}
	
	$sql = "UPDATE users set FirstName = '".$FirstName."', MiddleName = '".$MiddleName."', LastName = '".$LastName."', EmailId = '".$EmailAddress."', Address1 = '".$Address1."', Address2 = '".$Address2."', City = '".$City."', State = '".$State."', Country = '".$Country."', Password = '".$Password."', Gender = '".$Gender."', DateOfBirth = '".$DateOfBirth."', Mobile = '".$Mobile."' where id = $id";
	

    if(!mysqli_query($con,$sql))
    {
        $exception['error'] = "Problem while updating record";

    }else{
		
		$exception['success'] = "Profile Updated Successfully";
	}
	
	
	return $exception;
}


function deleteUser($con,$id){
	
	$post = array();

	$sql = "delete from users where id = $id";

    if(!mysqli_query($con,$sql))
    {
        $post['error'] = "Problem while Deleting users";

    }else{

		$post['success'] = "User Deleted Successfully";

	}

	return $post;
}


?>