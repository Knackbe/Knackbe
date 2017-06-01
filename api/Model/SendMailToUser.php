<?php

require '/../Config/PHPMailerAutoload.php';
require '/../Config/PHPMailer.php';
require '/../Config/SMTP.php';

//function sendmail($email){ 
//
//	$msg = array();
//
//	$mail = new PHPMailer;
//	 
//	$mail->isSMTP();
//	$mail->Host = 'smtp.gmail.com';
//	$mail->Port = 587;
//	$mail->SMTPAuth = true;
//	$mail->Username = '2016testuser2016@gmail.com';
//	$mail->Password = 'pravinV1@';
//	$mail->SMTPSecure = 'tls';
//	 
//	$mail->From = '2016testuser2016@gmail.com';
//	$mail->FromName = 'Test User';
//	$mail->addAddress($email,'Test User');
//	 
//	//$mail->addReplyTo('reply@gmail.com', 'reply');
//	 
//	$mail->WordWrap = 50;
//	$mail->isHTML(true);
//	 
//	$mail->Subject = 'Activation Mail';
//	$mail->Body    = '<a href="http://localhost/khelfit_api/user/validate/'.$email.'">Please Click on link to activate your account<a>';
//	 
//	if(!$mail->send()) {
//
//	   $msg['error'] = $mail->ErrorInfo;
//
//	}else{
//
//	   $msg['success'] = 'Mail sent to your email address successfully';
//
//	}
//	 
//	return $msg;
//
//}

?>