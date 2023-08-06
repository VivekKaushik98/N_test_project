$a=Get-Counter '\Process(*)\% Processor Time' | Select-Object -ExpandProperty countersamples

$b=$a| Select-Object -Property instancename, cookedvalue|Where-Object {$_.CookedValue -ge 0}|? {$_.instanceName -notmatch "^(idle|_total|system)$"} 
$c=$b | Sort-Object -Property cookedvalue -Descending | Select-Object -First 25| ft InstanceName,@{L='CPU';E={($_.Cookedvalue/100/$env:NUMBER_OF_PROCESSORS).toString('P')}} -AutoSize

$dirPath="C:\Users\Test\Desktop\Code\NIQ\Process_util_$(Get-Date -Format dddd_dd_MM_yyyy_HH_mm).txt"
echo  $dirPath

echo $c > $dirPath
echo "Process with high CPU utilization Save to File "