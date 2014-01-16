<?php

	$isSubmitSuccess=false;


		$isSubmitSuccess=true;


		$to="momo@momotatakakasasa.com";

		//define the subject of the email
		$subject = 'LAUW Enquiry Form';

		// Always set content-type when sending HTML email
		$headers = "Content-type:text/html;charset=iso-8859-1" . "\r\n";

		// More headers
		$headers .= "From: noreply@cardluv.com\r\n";


		$message="
			<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>
			<html xmlns='http://www.w3.org/1999/xhtml'>
			<head>
				<title></title>
				<style type='text/css'>
					body{
						font-family: arial;
						font-size: 8pt;
						color: #7f7f7f;
					}
				</style>
			</head>
			<body>

				<table align='left' cellpadding='0' cellspacing='5'>
					<tr valign='top'>
						<td align='left' width='300' style='font-family:times; font-size:20pt; color:#7f7f7f;' colspan='2'>LAUW<br /></td>
					</tr>

					<tr valign='top'>
						<th align='left' width='300' style='color:#7f7f7f;' colspan='2'>Enquiry Form:</th>
					</tr>
					<tr valign='top'>
						<th align='left' width='115' style='color: #7f7f7f;'>IP</th>
						<td align='left' width='300' style='color: #7f7f7f;'>".$_SERVER['REMOTE_ADDR']."</td>
					</tr>
					<tr valign='top'>
						<th align='left' width='115' style='color: #7f7f7f;'>Date/Time</th>
						<td align='left' width='300' style='color: #7f7f7f;'>".date("F j, Y",$timestamp)."&nbsp;&nbsp;&nbsp;".date("g:i:s A",$timestamp)."</td>
					</tr>

					<tr valign='top'>
						<th align='left' width='115' style='color: #7f7f7f;'>Title</th>
						<td align='left' width='300' style='color: #7f7f7f;'>".$_REQUEST['title']."</th>
					</tr>
					<tr valign='top'>
						<th align='left' width='115' style='color: #7f7f7f;'>First Name</th>
						<td align='left' width='300' style='color: #7f7f7f;'>".$_REQUEST['firstName']."</th>
					</tr>

					<tr valign='top'>
						<th align='left' width='115' style='color: #7f7f7f;'>Last Name</th>
						<td align='left' width='300' style='color: #7f7f7f;'>".$_REQUEST['lastName']."</th>
					</tr>
					<tr valign='top'>
						<th align='left' width='115' style='color: #7f7f7f;'>Company Name</th>
						<td align='left' width='300' style='color: #7f7f7f;'>".$_REQUEST['companyName']."</td>
					</tr>

					<tr valign='top'>
						<th align='left' width='115' style='color: #7f7f7f;'>Postal Address</th>
						<td align='left' width='300' style='color: #7f7f7f;'>".htmlentities($_REQUEST['postalAddress'], ENT_QUOTES)."</td>
					</tr>
					<tr valign='top'>
						<th align='left' width='115' style='color: #7f7f7f;'>Town</th>
						<td align='left' width='300' style='color: #7f7f7f;'>".$_REQUEST['town']."</td>
					</tr>

					<tr valign='top'>
						<th align='left' width='115' style='color: #7f7f7f;'>Post Code</th>
						<td align='left' width='300' style='color: #7f7f7f;'>".$_REQUEST['postcode']."</td>
					</tr>

					<tr valign='top'>
						<th align='left' width='115' style='color: #7f7f7f;'>State</th>
						<td align='left' width='300' style='color: #7f7f7f;'>".$_REQUEST['state']."</td>
					</tr>

					<tr valign='top'>
						<th align='left' width='115' style='color: #7f7f7f;'>Country</th>
						<td align='left' width='300' style='color: #7f7f7f;'>".$_REQUEST['country']."</td>
					</tr>

					<tr valign='top'>
						<th align='left' width='115' style='color: #7f7f7f;'>Telephone</th>
						<td align='left' width='300' style='color: #7f7f7f;'>".$_REQUEST['telephone']."</td>
					</tr>
					<tr valign='top'>
						<th align='left' width='115' style='color: #7f7f7f;'>Fax</th>
						<td align='left' width='300' style='color: #7f7f7f;'>".$_REQUEST['fax']."</td>
					</tr>

					<tr valign='top'>
						<th align='left' width='115' style='color: #7f7f7f;'>Email</th>
						<td align='left' width='300' style='color: #7f7f7f;'>".$_REQUEST['email']."</td>
					</tr>
					<tr valign='top'>
						<th align='left' width='115' style='color: #7f7f7f;'>Your Enquiry</th>
						<td align='left' width='300' style='color: #7f7f7f;'>".htmlentities($_REQUEST['yourEnquiry'], ENT_QUOTES)."</td>
					</tr>
				</table>
			</body>
			</head>
			</html>
		";

		mail($to, $subject, $message, $headers);



	}

?>


<?php
	if(!$isSubmitSuccess){
?>

<script type="text/javascript" src="validate_form.js"></script>

<table border="0" cellpadding="0" cellspacing="5" id="validateForm">
	<form method="post" action="index.php?page=enquiry-form&action=submit-enquiry" onsubmit="return validateForm();">
	<tr valign="top">
		<td align="left" width="115">Title</td>
		<td align="left" width="289">
			<select name="title" id="title">
				<option value="Mr">Mr</option>
				<option value="Mrs">Mrs</option>
				<option value="Ms">Ms</option>
				<option value="Miss">Miss&nbsp;&nbsp;&nbsp;</option>
				<option value="Dr">Dr</option>
				<option value="Prof">Prof</option>
			</select>
			<div id="titleError" class="errorMessageEnquiryForm" ></div>
		</td>
	</tr>
	<tr valign="top">
		<td align="left" width="115">First Name</td>
		<td align="left" width="289"><input type="text" class="inquiryInput" name="firstName" id="firstName" /><div id="firstNameError" class="errorMessageEnquiryForm" ></div></td>
	</tr>
	<tr valign="top">
		<td align="left" width="115">Last Name</td>
		<td align="left" width="289"><input type="text" class="inquiryInput" name="lastName" id="lastName" /><div id="lastNameError" class="errorMessageEnquiryForm" ></div></td>
	</tr>
	<tr valign="top">
		<td align="left" width="115">Company Name</td>
		<td align="left" width="289"><input type="text" class="inquiryInput" name="companyName" id="companyName" /><div id="companyNameError" class="errorMessageEnquiryForm" ></div></td>
	</tr>
	<tr valign="top">
		<td align="left" width="115">Postal Address</td>
		<td align="left" width="289"><textarea class="inquiryInput" name="postalAddress" id="postalAddress" cols="30" rows="5"></textarea><div id="postalAddressError" class="errorMessageEnquiryForm" ></div></td>
	</tr>
	<tr valign="top">
		<td align="left" width="115">Town</td>
		<td align="left" width="289"><input type="text" class="inquiryInput" name="town" id="town" /><div id="townError" class="errorMessageEnquiryForm" ></div></td>
	</tr>
	<tr valign="top">
		<td align="left" width="115">Post Code</td>
		<td align="left" width="289"><input type="text" class="inquiryInput" name="postcode" id="postcode" /><div id="postcodeError" class="errorMessageEnquiryForm" ></div></td>
	</tr>
	<tr valign="top">
		<td align="left" width="115">State</td>
		<td align="left" width="289"><input type="text" class="inquiryInput" name="state" id="state" /><div id="stateError" class="errorMessageEnquiryForm" ></div></td>
	</tr>
	<tr valign="top">
		<td align="left" width="115">Country</td>
		<td align="left" width="289"><input type="text" class="inquiryInput" name="country" id="country" /><div id="countryError" class="errorMessageEnquiryForm" ></div></td>
	</tr>
	<tr valign="top">
		<td align="left" width="115">Telephone</td>
		<td align="left" width="289"><input type="text" class="inquiryInput" name="telephone" id="telephone" /><div id="telephoneError" class="errorMessageEnquiryForm" ></div></td>
	</tr>
	<tr valign="top">
		<td align="left" width="115">Fax</td>
		<td align="left" width="289"><input type="text" class="inquiryInput" name="fax" id="fax" /><div id="faxError" class="errorMessageEnquiryForm" ></div></td>
	</tr>
	<tr valign="top">
		<td align="left" width="115">Email</td>
		<td align="left" width="289"><input type="text" class="inquiryInput" name="email" id="email" /><div id="emailError" class="errorMessageEnquiryForm" ></div></td>
	</tr>
	<tr valign="top">
		<td align="left" width="115">Your Enquiry</td>
		<td align="left" width="289"><textarea class="inquiryInput" name="yourEnquiry" id="yourEnquiry" cols="30" rows="5"></textarea><div id="yourEnquiryError" class="errorMessageEnquiryForm" ></div></td>
	</tr>
	<tr valign="top">
		<td align="left" width="115">Anti-spam</td>
		<td align="left" width="289"><div style="background-image:url(uploads/images/images/body_background.gif); display:inline; float:left; width: 274px;"><img src="blank.gif" width="172" height="38" alt="anti-spam" id="antiAutomatonImage" style="position:relative; left: 56px;" /></div></td>
	</tr>
	<tr valign="top">
		<td align="left" width="115">&nbsp;</td>
		<td align="left" width="289"><input type="text" class="inquiryInput" name="antiAutomatonIn" id="antiAutomatonIn" value="copy text above" /><div id="antiAutomatonError" class="errorMessageEnquiryForm" ></div></td>
	</tr>

	<script type='text/javascript' src='anti_automaton/anti_automaton.js'></script>

	<tr valign="top">
		<td align="left" width="115">&nbsp;</td>
		<td align="left" width="289"><input type="submit" value="submit"></td>
	</tr>
	</form>
</table>


<?php
	}
	else{
?>

	Your enquiry is successfully submitted!


<?php
	}
?>