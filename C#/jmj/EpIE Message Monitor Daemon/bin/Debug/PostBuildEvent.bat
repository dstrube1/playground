@echo off
COPY /Y "C:\david\EpIE Message Monitor Daemon\SvcConfig.xml" "C:\david\EpIE Message Monitor Daemon\bin\Debug\SvcConfig.xml"
if errorlevel 1 goto CSharpReportError
goto CSharpEnd
:CSharpReportError
echo Project error: A tool returned an error code from the build event
exit 1
:CSharpEnd