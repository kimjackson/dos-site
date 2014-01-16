//Code Author: Reyco Evangelista




var correctPassword3="";

var lookUpChr = new Array(
	'a',
	'b',
	'c',
	'd',
	'e',
	'f',
	'g',
	'h',
	'i',
	'j',
	'k',
	'l',
	'm',
	'n',
	'o',
	'p',
	'q',
	'r',
	's',
	't',
	'u',
	'v',
	'w',
	'x',
	'y',
	'z'
);

function getPassword3(){

	correctPassword3="";

	for(ctr=0;ctr<6;ctr++){
		correctPassword3 = correctPassword3 + lookUpChr[Math.floor(Math.random()*26)];
	}

	document.getElementById('antiAutomatonImage').src="anti_automaton/anti_automaton_picture.php?image_value=" + correctPassword3;
	
}

function checkAntiAutomaton(){
	if(correctPassword3 != document.getElementById('security').value ){
		alert("Mismatched Security Code.");
		getPassword3();
		return false;
	}
	return true;
}


$(document).ready(function(){
	getPassword3();
});