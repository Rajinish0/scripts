# couldn't figure out how to use cmake, so this script just recompiles the newly modified c++ files for my opengl project 
# and then links all the object files together to create an executable file. Saves the time of recompling everything if i use g++ *.cpp
# now it can detect those cpp files which contain headers that were changed, those need to be recompiled too.

param(
[parameter(Mandatory, HelpMessage="Enter an output file : ")]
$filename
)

if ( -not (Test-Path ".\log.txt") ){
    ni .\log.txt
    $lastDate = Get-Date -Year 1 -Month 1 -Day 1
}

else {
    $h = cat ".\log.txt"
    $lastDate = [DateTime]::Parse($h)
}

Get-Date > .\log.txt
echo $lastDate

$arr = @()

echo "getting modified header files.."

gci "." | where {( ($_.Extension -eq ".h") -and ($_.LastWriteTime -gt $lastDate) )} | % {$arr += $_.Name}
$arr
echo "done"

function myfunc(){
param([string] $s) 
foreach ($i in $arr){
    if ($s.Contains($i)){
    return $true
    }
}
return $false
}



Write-Host "compiling altered files.."
#recompiling
gci "." | where { ($_.Extension -eq ".cpp") -and ( ($_.LastWriteTime -gt $lastDate) -or ( $(myfunc([string] $(cat $_.Name))) ) ) } | % {g++ -c $_}
Write-Host "done"

Write-Host "linking"
#linking 
g++ *.o glad.c -lglfw3 -lopengl32 -lgdi32 -o $filename

