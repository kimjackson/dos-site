<?php


$name = $_REQUEST['name'];
$email = $_REQUEST['email'];
$phone = $_REQUEST['phone'];
$message = htmlentities($_REQUEST['message'], ENT_QUOTES);

$message = '
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<style type="text/css">
			body{
				font-family: arial;
				font-size: 8pt;
				color: #000;
			}
		</style>
	</head>
	<body>
		<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<th align="left" colspan="2"><h2>DOS Contribute</h2></th>
			</tr>
			<tr><td align="left" colspan="2">&nbsp;</td></tr>
			<tr>
				<th align="left" width="'.$left.'">Name: </th>
				<td align="left" width="'.$right.'">'.$name.'</td>
			</tr>
			<tr><td align="left" colspan="2">&nbsp;</td></tr>
			<tr>
				<th align="left" width="'.$left.'">Email: </th>
				<td align="left" width="'.$right.'">'.$email.'</td>
			</tr>
			<tr><td align="left" colspan="2">&nbsp;</td></tr>
			<tr>
				<th align="left" width="'.$left.'">Phone: </th>
				<td align="left" width="'.$right.'">'.$phone.'</td>
			</tr>
			<tr><td align="left" colspan="2">&nbsp;</td></tr>
			<tr>
				<th align="left" width="'.$left.'">Message: </th>
				<td align="left" width="'.$right.'">'.$message.'</td>
			</tr>
		</table>
	</body>
	</html>
';

$subject = 'DOS Contribute';
$headers .= 'Content-type: text/html; charset=iso-8859-1' . "\r\n";
$headers .= 'From: noreply@dos.com';


mail('reyco23@cardluv.com', $subject, $message, $headers);
header('Location: contribute-thank-you.html');