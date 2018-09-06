# USER DEFINED
$sse = "D:\Games\SteamLibrary\steamapps\common\Skyrim Special Edition"
$outDir = "D:\Mods\ModOrganizer2_SkyrimSE\mods\Named Quicksaves - A Save Manager - DEV"


# GRAB DIRECTORIES
$sseSrc = $sse + "\Data\Scripts\Source"
$usrSrc = (Get-Location)
$papyrus = $sse + "\Papyrus Compiler\PapyrusCompiler.exe"
$flags = $sseSrc + "\TESV_Papyrus_Flags.flg"


# COMPILE PAPYRUS SCRIPTS
& "$papyrus" "$usrSrc\Scripts\Source" -f="$flags" -i="$sseSrc;$usrSrc\Scripts\Source" -o="$outDir\Scripts" -a


Write-Output ""
Write-Output "Copy Tasks"
Write-Output ""


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


# MOVE ESPS
Get-ChildItem "$outDir" -Filter *.esp |
Foreach-Object {
	$filePath = $_.FullName
	$fileName = $_.Name
	Copy-Item -Path "$filePath" -Destination "$usrSrc"
	Write-Output "CP $usrSrc\$fileName"
}