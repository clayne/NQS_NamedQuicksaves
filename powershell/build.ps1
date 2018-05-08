# USER DEFINED
$sse = "D:\Games\Steam\steamapps\common\Skyrim Special Edition"
$outDir = "D:\Mods\ModOrganizer2\mods\Named Quicksaves - A Save Manager - DEV"


# GRAB DIRECTORIES
$sseSrc = $sse + "\Data\Scripts\Source"
$usrSrc = (Get-Location)
$papyrus = $sse + "\Papyrus Compiler\PapyrusCompiler.exe"
$flags = $sseSrc + "\TESV_Papyrus_Flags.flg"


# COMPILE PAPYRUS SCRIPTS
Get-ChildItem "$usrSrc\Scripts\Source" -Filter *.psc | 
Foreach-Object {
	$file = $_.FullName
    & "$papyrus" "$file" -f="$flags" -i="$sseSrc;$usrSrc\Scripts\Source" -o="$outDir\Scripts"
}


# MOVE TRANSLATION FILES
Get-ChildItem "$usrSrc\Interface\Translations" -Filter *.txt | 
Foreach-Object {
	$filePath = $_.FullName
	$fileName = $_.Name
	Copy-Item -Path "$filePath" -Destination "$outDir\Interface\Translations"
	Write-Output "CP $outDir\Interface\Translations\$fileName"
}


# MOVE DLLS
Get-ChildItem "$usrSrc\SKSE\Plugins" -Filter *.dll | 
Foreach-Object {
	$filePath = $_.FullName
	$fileName = $_.Name
	Copy-Item -Path "$filePath" -Destination "$outDir\SKSE\Plugins"
	Write-Output "CP $outDir\SKSE\Plugins\$fileName"
}