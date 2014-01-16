<?php
	//created by Reyco Evangelista text to picture converter v.3
	//note version v.1 and v.2 are used in my old site not that neat

	$string=$_REQUEST['image_value'];
	$_SESSION['image_value']=$string;

	$width = 68;
	$height = 17;

	$img = imagecreate($width, $height);


	$bg = imagecolorallocate($img,255,255,255);
	$textColor = imagecolorallocate($img,0x02f,0x001,0x003);
	$len=strlen($string);

	imagettftext  ( $img  , 11.0  , 0.0  , 9  , 13  , $textColor  , "scriptf_.ttf"  , $string  );

	// Output
	header("Content-Type: image/png");
	imagepng($img);

?>
