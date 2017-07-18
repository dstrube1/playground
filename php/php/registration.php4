<?php
/*****************************************************************************
 * 						BEGIN FUNCTION DECLARATIONS
 *****************************************************************************
 */
function debug(){
	echo "<BR>REQUEST Contents are:<BR>";
	foreach ($_REQUEST as $requestValue) {
    	echo $requestValue . "<BR> ";
	}
	
	echo "<BR>POST Contents are:<BR>";
	foreach ($_POST as $postValue) {
    	echo $postValue . "<BR> ";
	}	
	
	echo "<BR><BR>";
}

function extractRequestParameters(){
	//echo 'extracting contact information<br><br>';
	//debug();
	$contactInfo = "Registration Information:\n";
	$firstName = "\nFirst Name:  " . $_REQUEST['firstName'];
	$lastName = "\nLast Name:  " . $_REQUEST['lastName'];
	$company = "\nCompany:  " . $_REQUEST['company'];
	$email = "\nEmail Address:  " . $_REQUEST['email'];
	$telephone = "\nTelephone:  " . $_REQUEST['phone'];
	$address = "\nAddress:  " . $_REQUEST['address1'] . "\n               " . $_REQUEST['address2'];
	$city = "\nCity:  " . $_REQUEST['city'];
	$state = "\nState/Province:  " . $_REQUEST['stateProvince'];
	$postalCode = "\nPostal Code:  " . $_REQUEST['postalCode'];
	$country = "\nCountry:  " . $_REQUEST['countryList'];
	 
	//echo 'extracting answers to questions asked<br><br>';
	 
	$answerResponse = "\n\n\nResponses to questions asked:";
	$timeframe = "\nWhis is your timeframe?  " . $_REQUEST['rfpUserTimeframe'];
	$companyType = "\nWhat is your company type?  " . $_REQUEST['rfpCompanyType'];
	$userFunction = "\nWhat is your function?  " . $_REQUEST['userFunction'];
	$hearRFP = "\nWhere did you hear about the Recruitment Funnel Planner?  " . $_REQUEST['rfpExposureList'];
	
	//format the user contact information and answer to questions
	$userResponse = $contactInfo . $firstName . $lastName . $company . $email . $telephone . 
 			$address . $city . $state . $postalCode . $country . 
 			$answerResponse . $timeframe . $companyType . $userFunction . $hearRFP;
	
	return $userResponse;
}

function sendRegistrationEmail($message) {
	//echo "Preparing to send registration email<br><br>";
	//define the receiver of the email
	$to = "rfp-download@synapseanalytics.com";
	//define the subject of the email
	$subject = "New Recruitment Funnel Planner Registration"; 
	//define the headers we want passed. Note that they are separated with \n
	$headers = "From: webmaster@synapseanalytics.com";

	//send the email
	return @mail( $to, $subject, $message, $headers );
}

function emailInstructions() {
	//define the download instructions
	/*
	$rfpInstructions = "\n\n" .
						"Thank you for downloading a trial version of the Recruitment Funnel Planner \n\n" .
						"  1.  Unzip the RFP.zip file in a local directory. \n" . 
						"  2.  Double-click on the RFPSetup.exe file. \n" . 
						"  3.  Click on \"I Agree\" to accept the License Agreement. \n" .
						"  4.  Enter your first and last name. \n" .
						"  5.  In Company, enter \"rfptrial\" (without the quotation marks) \n" .
						"  6.  In Registration Key, enter RP5868-BXOX-090-TCIC \n" .
						"  7.  Click on \"Next\". \n" .
						"  8.  Click on \"Install\". \n" .
						"  9.  Click \"Close\" when installation finishes. \n" .
						"10.  Click \"Skip\" if present with the Licensing Information dialog. \n" . 
						"11.  Click \"Start\" \n" .
						"12.  Click \"Recruitment Funnel Planner\". \n" .
						"\n\nIf you have questions or feedback about this product, " .
						" you can contact Synapse Analytics in any of the following ways:\n\n" .
						"Email:  rfp-feedback@synapseanalytics.com" .
						"\n\nThanks for trying Recruitment Funnel Planner.";
	*/
	$rfpInstructions = "\n\n" .
						"Thank you for downloading a trial version of the Recruitment Funnel Planner \n\n" .
						"  1.  In Company, enter \"rfptrial\" (without the quotation marks) \n" .
						//"  2.  In Registration Key, enter RP5868-BXOX-090-TCIC \n" .
						//"  2.  In Registration Key, enter RP5832-QQWS-030-TCEC \n" .
						"  2.  In Registration Key, enter RP2854-DXBC-030-TCEC \n" .
						"\n\nIf you have questions or feedback about this product, " .
						" you can contact Synapse Analytics in any of the following ways:\n\n" .
						"Email:  rfp-feedback@synapseanalytics.com" .
						"\n\nThanks for trying Recruitment Funnel Planner.";

	
	//Prepare to send the download instructions to the user
	//define the receiver of the email
	$to = $_REQUEST['email'];;
	//define the subject of the email
	$subject = "Recruitment Funnel Planner Download"; 
	//define the headers we want passed. Note that they are separated with \n
	$headers = "From: webmaster@synapseanalytics.com";
	//send the email
	return @mail( $to, $subject, $rfpInstructions, $headers );
}

function init() {
	//ini_set('display_errors', 1); 
	error_reporting(E_ALL);
	ini_set('log_errors', 1); 
	ini_set('error_log', dirname(__FILE__) . '/registration_errors.log');	
}
/****************************************************************************
* 						PROGRAM EXECUTION BEGINS HERE
****************************************************************************
*/
init();
//echo "Starting registration php<br><br>";
//extract the user information from the request
$userData = extractRequestParameters();
//send the registration information to the host address
$registrationSent = sendRegistrationEmail($userData);
if($registrationSent){
//email the instructions to the user
$downloadInstructionsSent = emailInstructions();
header("Location:../downloads-xp.html");
}
?>
