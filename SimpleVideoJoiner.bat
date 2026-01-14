@echo off
:: Set encoding to UTF-8 to handle Spanish accents (ó, í)
chcp 65001 >nul
setlocal enabledelayedexpansion
title Simple Video Joiner (Lossless) - v2.0
color 0B

:: ======================================================
:: Simple Video Joiner - Lossless Concatenation
:: Author: Juan Ignacio Peralta (https://github.com/grapako)
:: Assisted by: Gemini 3 Pro
:: ======================================================

:START
cls
echo ======================================================================
echo                      SIMPLE VIDEO JOINER
echo ======================================================================
echo  FUNCTIONALITY:
echo  This tool merges video files WITHOUT re-rendering (no transcoding).
echo  It uses FFmpeg's "stream copy" mode to preserve 100%% original quality.
echo ======================================================================
echo.
echo 1. AUTO-JOIN: Detect and join all .mp4 files in this folder.
echo 2. USE FILE: Use an existing "join_videos.txt" file.
echo 3. MANUAL: Input video paths one by one.
echo 4. EXIT
echo.
set /p choice="Select an option (1-4): "

if "%choice%"=="1" goto AUTO_JOIN
if "%choice%"=="2" goto USE_FILE
if "%choice%"=="3" goto MANUAL_ENTRY
if "%choice%"=="4" exit
goto START

:AUTO_JOIN
cls
echo Scanning folder for .mp4 files...
echo.
set "first_file="
if exist "temp_list.txt" del "temp_list.txt"

:: Loop through MP4 files
for %%f in (*.mp4) do (
    if not "%%~nxf"=="%~nx0" (
        if not defined first_file set "first_file=%%~nf"
        echo file '%%f' >> temp_list.txt
    )
)

if not defined first_file (
    echo No .mp4 files found in this directory.
    pause
    goto START
)

:: --- VERIFICATION STEP ---
echo THE FOLLOWING FILES WILL BE JOINED (IN THIS ORDER):
echo ----------------------------------------------------------------------
type temp_list.txt
echo ----------------------------------------------------------------------
echo.
echo [TIP] If the order is wrong, rename files to 01-name.mp4, 02-name.mp4
echo.
set /p confirm="Do you want to proceed? (Y/N): "
if /i not "%confirm%"=="Y" (
    del "temp_list.txt"
    goto START
)

set "output_name=%first_file%-merged.mp4"
goto PROCESS

:USE_FILE
cls
if not exist "join_videos.txt" (
    echo Error: "join_videos.txt" not found.
    pause
    goto START
)
echo FILES LISTED IN join_videos.txt:
type join_videos.txt
set /p output_name="Enter output name (default: merged_video.mp4): "
if "%output_name%"=="" set "output_name=merged_video.mp4"
copy "join_videos.txt" "temp_list.txt" >nul
goto PROCESS

:MANUAL_ENTRY
cls
if exist "temp_list.txt" del "temp_list.txt"
echo Paste the full path of the videos one by one. 
echo Press ENTER on an empty line when finished.
echo.
:MANUAL_LOOP
set /p "vpath=Enter video path: "
if "%vpath%"=="" goto MANUAL_FINISH
if not defined first_file (
    for %%A in ("%vpath%") do set "first_file=%%~nA"
)
echo file '%vpath%' >> temp_list.txt
goto MANUAL_LOOP

:MANUAL_FINISH
if not exist "temp_list.txt" goto START
set "output_name=%first_file%-merged.mp4"
goto PROCESS

:PROCESS
echo.
echo ======================================================================
echo PROCESSING: Joining files into "%output_name%"
echo MODE: Stream Copy (Lossless - No Rendering)
echo ======================================================================
echo.

ffmpeg -f concat -safe 0 -i temp_list.txt -c copy "%output_name%"

if %errorlevel% equ 0 (
    echo.
    echo ======================================================================
    echo SUCCESS! The video has been joined in seconds.
    echo ======================================================================
) else (
    echo.
    echo ERROR: FFmpeg failed. Check if filenames have single quotes.
)

if exist "temp_list.txt" del "temp_list.txt"
echo.
pause
goto START