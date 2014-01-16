//Code Author: Reyco Evangelista


var returningScrollingId="";



function isBlankField(idTextInput, fieldName){
	temp=document.getElementById(idTextInput).value;
	if(temp==""||temp==null){
		
		alert(fieldName + " is required.");
		
		return true;
	}
	return false;
}

function isBlankFieldWithBr(idTextInput, fieldName){
	temp=document.getElementById(idTextInput).value;
	if(temp==""||temp==null){		
		alert(fieldName + " is required.");		
		return true;		
	}
	return false;
}

function isNotAllNumbers(idTextInput, fieldName){
	stringLength=document.getElementById(idTextInput).value.length;
	for(ctr=0;ctr<stringLength;ctr++){
		temp=document.getElementById(idTextInput).value.substr(ctr,1);
		if(temp<'0'||temp>'9'){
		
			if(!(temp==' ' || temp=='-')){
				alert(fieldName + " numbers only.");		
				return true;
			}
		}
	}
	return false;
}

function isNotAllCharacters(idTextInput, fieldName){
	stringLength=document.getElementById(idTextInput).value.length;
	for(ctr=0;ctr<stringLength;ctr++){
		temp=document.getElementById(idTextInput).value.substr(ctr,1);
		if(!(temp<'0'||temp>'9')){
			alert(fieldName + " letters only.");		
			return true;
		}
	}
	return false;
}

function isNotValidEmail(idTextInput, fieldName){
	temp=document.getElementById(idTextInput).value;
	//if( ( temp.indexOf('.') - temp.indexOf('@') ) > 1 ) return false;
	
	if( (temp.indexOf('.')>0)&&(temp.indexOf('@')>0) ){
		return false;
	}
	
	
	alert(fieldName + " is invalid.");		
	return true;
	
}

function clearErrorMessage(idTextInput){
	document.getElementById(idTextInput+"Error").innerHTML="";
	document.getElementById(idTextInput+"Error").style.display="none";
}


function validateForm(){

	if(isBlankField("name", "Name")) return false;
	else if(isNotAllCharacters("name", "Name")) return false;
	
	if(isBlankField("email", "Email")) return false;
	else if(isNotValidEmail("email", "Email")) return false;
	
	if(isBlankField("phone", "Phone")) return false;
	else if(isNotAllNumbers("phone", "Phone")) return false;
		
	if(isBlankField("message", "Message")) return false;
	
	if(!checkAntiAutomaton()) return false;

}

$(document).ready(function(){
	document.getElementById('fileupload').style.opacity = ".0";
	document.getElementById('fileupload').style.filter = "alpha(opacity=0)";

	document.getElementById('fileupload').style.position = "relative";
	document.getElementById('fileupload').style.top = "-15px";
	
	if(navigator.appName != "Microsoft Internet Explorer") document.getElementById('fileupload').style.left = "40px";

	document.getElementById('fileupload').style.height = "20px";
	
		
});


