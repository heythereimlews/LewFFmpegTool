@echo off
title Lew's FFmpeg Pulldown Tool
setlocal EnableExtensions EnableDelayedExpansion
set "RIPDIR=C:\Rips"
if not exist "%RIPDIR%" mkdir "%RIPDIR%"

echo ======================================
echo   Lew's FFmpeg Pulldown / IVTC Tool
echo ======================================
echo Output folder: %RIPDIR%
echo.

echo Enter full path to input video:
set /p "IN=> "

rem Strip quotes safely (cannot cause syntax errors)
set "IN=%IN:"=%"

if "%IN%"=="" (
  echo.
  echo No input provided.
  echo.
  pause
  exit /b 1
)

if not exist "%IN%" (
  echo.
  echo File not found: "%IN%"
  echo.
  pause
  exit /b 1
)

for %%F in ("%IN%") do set "NAME=%%~nF"

echo.
echo Choose operation:
echo.
echo [1] Remove 3:2 Pulldown  (29.97 -^> 23.976p)
echo [2] Deinterlace Video   (Interlaced -^> 59.94p NTSC/50fps PAL)
echo [3] Add 3:2 Pulldown    (23.976 -^> 29.97i)
echo.
set /p "MODE=> "

if not "%MODE%"=="1" if not "%MODE%"=="2" if not "%MODE%"=="3" (
  echo.
  echo Invalid option: %MODE%
  echo.
  pause
  exit /b 1
)

echo.
echo Input: "%IN%"

if "%MODE%"=="1" (
  set "OUT=%RIPDIR%\%NAME%_23976p.mkv"
  echo Output: "!OUT!"
  echo.
  ffmpeg -hide_banner -y -i "%IN%" ^
    -vf "pullup,decimate,fps=24000/1001" ^
    -c:v libx264 -crf 18 -preset slow ^
    -c:a ac3 -b:a 448k
    "!OUT!"
  if errorlevel 1 goto :FFFAIL
  goto :DONE
)

if "%MODE%"=="2" (
  set "OUT=%RIPDIR%\%NAME%_deinterlaced_p.mkv"
  echo Output: "!OUT!"
  echo.
  ffmpeg -hide_banner -y -i "%IN%" ^
    -vf "yadif=mode=1:parity=auto:deint=all" ^
    -c:v libx264 -crf 18 -preset slow ^
    -c:a copy ^
    "!OUT!"
  if errorlevel 1 goto :FFFAIL
  goto :DONE
)

if "%MODE%"=="3" (
  set "OUT=%RIPDIR%\%NAME%_2997i.mkv"
  echo Output: "!OUT!"
  echo.
  ffmpeg -hide_banner -y -i "%IN%" ^
    -vf "tinterlace=mode=merge,telecine=pattern=23" ^
    -r 30000/1001 -flags +ilme+ildct ^
    -c:v libx264 -x264-params "tff=1" ^
    -c:a copy ^
    "!OUT!"
  if errorlevel 1 goto :FFFAIL
  goto :DONE
)

:FFFAIL
echo.
echo FFmpeg failed. See the lines above for the reason.
echo.
pause
exit /b 1

:DONE
echo.
echo Done!
echo Saved to: "!OUT!"
echo.
pause
exit /b 0
