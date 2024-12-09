## Check command full path

```
PS C:\Chef> Get-Command chefctl.rb

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Application     chefctl.rb                                         0.0.0.0    C:\Windows\system32\chefctl.rb
```

## Get host uptime


```powershell
function Get-Uptime {
    $os = Get-WmiObject -Class Win32_OperatingSystem
    $uptime = (Get-Date) - $os.ConvertToDateTime($os.LastBootUpTime)
    return $uptime
}
```

After defining this function, you can call `Get-Uptime` to get the uptime of the system.

```powershell
Get-Uptime
```

This will return the uptime in the format of `Days:Hours:Minutes:Seconds:Milliseconds:Ticks`:

```
PS C:\Users\root> function Get-Uptime {
>>     $os = Get-WmiObject -Class Win32_OperatingSystem
>>     $uptime = (Get-Date) - $os.ConvertToDateTime($os.LastBootUpTime)
>>     return $uptime
>> }
PS C:\Users\root> Get-Uptime


Days              : 0
Hours             : 2
Minutes           : 56
Seconds           : 55
Milliseconds      : 527
Ticks             : 106155277867
TotalDays         : 0.122864904938657
TotalHours        : 2.94875771852778
TotalMinutes      : 176.925463111667
TotalSeconds      : 10615.5277867
TotalMilliseconds : 10615527.7867
```

Another way:

```
PS C:\Users\root> systeminfo | find "System Boot Time"
System Boot Time:          8/22/2024, 1:49:58 PM
```
