

function lookupTextSizes(num){
	switch(num){
		case 1: return 9;
		case 2: return 11;
		case 3: return 13;
		case 4: return 15;
		case 5: return 20;	
	}
	return "xsmallview";
}


function setFontSize(num){
	size=lookupTextSizes(num);
	document.getElementById('content').style.fontSize = size + "px";
	
	if(num==5) document.getElementById('content').style.lineHeight = "20px";
	else document.getElementById('content').style.lineHeight = "auto";
}

function setDefaultFontSize(){
	fontSizeNum = 2;
	writePersistentCookie ('fontSizeNum', fontSizeNum, 'days', 5);
	setFontSize(fontSizeNum);
	
	document.getElementById('myContent').style.color = "#434343";
}

function restoreFontSize(){
	if(fontSizeNum = getCookieValue('fontSizeNum')){
		setFontSize(parseInt(fontSizeNum));
		
		if( fontSizeNum>3 ) document.getElementById('myContent').style.color = "#000";
		
	}
	else{
		setDefaultFontSize();
	}
	
	loadBannerState();
	
	
}

function increaseFontSize(){
	if(fontSizeNum = getCookieValue('fontSizeNum')){
		newFontSizeNum = parseInt(fontSizeNum) + 1;
		if(newFontSizeNum > 6) newFontSizeNum=5;
		writePersistentCookie ('fontSizeNum', newFontSizeNum, 'days', 5);
		
		setFontSize(newFontSizeNum);
	}
	else{
		setDefaultFontSize();
	}
	
	document.getElementById('myContent').style.color = "#000";
}

function decreaseFontSize(){
	if(fontSizeNum = getCookieValue('fontSizeNum')){
		newFontSizeNum = parseInt(fontSizeNum) - 1;
		if(newFontSizeNum < 1) newFontSizeNum=1;
		writePersistentCookie ('fontSizeNum', newFontSizeNum, 'days', 5);
		setFontSize(newFontSizeNum);
	}
	else{
		setDefaultFontSize();
	}
}

window.onload = function(){
	restoreFontSize();
}

document.getElementById('decreaseFont').onclick = function(){
	increaseFontSize();
}

document.getElementById('increaseFont').onclick = function(){
	decreaseFontSize();
}