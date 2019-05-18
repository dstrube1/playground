############################################################
## Description  : An edutaining, mostly harmless script
## 
##first test:
##search thru all archived bulksheet server log files,
## look to see what files have this:
## BulkRequestUploadProcessingAction.cs:line 1095
############################################################

$sourcePath0 = "\\atl_logging_pr.searchignite.local\Logging\bulksheets\ATL02BULK01\2013\11 November\27"
$destinationPath0 = "C:\Users\david.strube\Desktop"
$sourcePath1 = $destinationPath0 + "\temp"
$stringToSearchFor = "We're done with this bulksheet"
#"BulkRequestUploadProcessingAction.cs:line 1095" #

#Write-Output $sourcePath0
#Write-Output $destinationPath0

$files0 = get-childitem $sourcePath0 -Filter *.*

if ( $files0 -eq "" -or $files0.Count  -gt 0 ) 
{
	foreach ($file0 in $files0)
	{
	#Write-Output $file0.fullname
	Copy-Item $file0.fullname $destinationPath0
	#Write-Output $file0.name
#	$localZipFile = $destinationPath0 + "\" + $file0.name
	#Write-Output $destinationPath0
	#Write-Output $localZipFile
#	.\7za e -otemp $localZipFile #it sucks that we have to spell out "temp" here
#	Remove-Item $localZipFile
#	$files1 = get-childitem $sourcePath1 -Filter *.*
#	foreach ($file1 in $files1)
#	{
	
		#Write-Output $file1.fullname
#		$fileContent = get-content $file1.fullname
		#foreach ($row in $fileContent){
#			if ($fileContent -ne $null)
#			{
				#Write-Output $fileContent
#				$fileContent | Select-String -pattern $stringToSearchFor -SimpleMatch -AllMatches | % {
#					$i = ($_.linenumber -1)
					#while ($fileContent[$i] -notlike "Thread*") {
					#	$i--
					#}

					#$fileContent[$i]
					#Write-Output "outputting searchOut:"
					#Write-Output $searchOut
					#-path $pathToSearchString
#				}
#			}
#			else
#			{
#				Write-Output $fileContent.name + " is empty"
#			}
		#}
#		Remove-Item  $file1.fullname

		#http://ss64.com/ps/select-string.html
		#http://ss64.com/ps/
		
#		}
	return
	}
}