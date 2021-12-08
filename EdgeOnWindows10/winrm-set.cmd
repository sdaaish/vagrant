@echo off

:: Sets up WINRM so RDP works for vagrant.
:: From https://dennypc.wordpress.com/2014/06/09/creating-a-windows-box-with-vagrant-1-6/
::

echo Administrative permissions required. Detecting permissions...
echo.

net session >nul 2>&1

if %errorLevel% == 0 (
   winrm quickconfig -q
   winrm set winrm/config/winrs @{MaxMemoryPerShellMB="300"}
   winrm set winrm/config @{MaxTimeoutms="1800000"}
   winrm set winrm/config/service @{AllowUnencrypted="true"}
   winrm set winrm/config/service/auth @{Basic="true"}
   winrm set winrm/config/client/auth @{Basic="true"}

   netsh advfirewall firewall add rule name="WinRM-HTTP" dir=in localport=5985 protocol=TCP action=allow
)
else (
  echo Failure: You must run this batch file as Administrator.
)

pause
