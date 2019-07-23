@echo off
echo CACHE MANIFEST > test0.txt
echo # v1.5.6 X-PROJECT >> test0.txt
echo # %DATE%-%TIME% >> test0.txt
echo. >> test0.txt

set LOC=%~dp0

dir /B /S /A:-D >> test0.txt

findstr /v "media ESP-VERSION .bat .exe .mp4 offlinexmb.cache test0.txt" test0.txt > test.txt
del test0.txt

@echo off
setlocal enableextensions disabledelayedexpansion
set "search=%LOC%"
set "replace="
set "textFile=test.txt"
for /f "delims=" %%i in ('type "%textFile%" ^& break ^> "%textFile%" ') do (
set "line=%%i"
setlocal enabledelayedexpansion
>>"%textFile%" echo(!line:%search%=%replace%!
endlocal)

setlocal DisableDelayedExpansion
set "firstLineReady="
(for /F "eol=$ delims=" %%a in (test.txt) DO (
if defined firstLineReady (echo()
set "firstLineReady=1"
<nul set /p "=%%a")
) > offlinexmb.cache
del test.txt

echo offlinexmb.cache created!!

TIMEOUT 2 >nul