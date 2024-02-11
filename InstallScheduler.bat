@echo off

:: Request Administrator
if not "%1"=="am_admin" (
    powershell -Command "Start-Process -Verb RunAs -FilePath '%0' -ArgumentList 'am_admin'"
    exit /b
)

:: Create temporary PowerShell script file
echo $Repetition = New-ScheduledTaskTrigger -once -at (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 1) -RepetitionDuration (New-TimeSpan -Minutes 3) > temp.ps1
echo $Trigger1 = New-ScheduledTaskTrigger -AtLogon >> temp.ps1
echo $Trigger1.Repetition = ($Repetition).repetition >> temp.ps1
echo $Trigger2 = New-ScheduledTaskTrigger -AtStartup >> temp.ps1
echo $Trigger2.Repetition = ($Repetition).repetition >> temp.ps1
echo $Trigger = @($Trigger1, $Trigger2) >> temp.ps1
echo $User = "NT AUTHORITY\SYSTEM" >> temp.ps1
echo $Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries >> temp.ps1
echo $Action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -Command ""Get-WmiObject Win32_process -filter 'name = """"""Audiodg.exe""""""' | ForEach-object{`$_.SetPriority(128)};Get-Process Audiodg | ForEach-Object {`$_.ProcessorAffinity=1};""" >> temp.ps1
echo Register-ScheduledTask -TaskName "audiodgFIX" -Trigger $Trigger -User $User -Settings $Settings -Action $Action -RunLevel Highest -Force >> temp.ps1

:: Execute the script
powershell -ExecutionPolicy Bypass -File temp.ps1

:: Delete temporary file
del temp.ps1
