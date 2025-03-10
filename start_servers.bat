@echo off

:: Start run_ollama.bat in a new command prompt window
start cmd /k run_ollama.bat

:: Start run_webui.bat in a new command prompt window
start cmd /k run_webui.bat

:: Wait for WebUI server on localhost:8080 using a 3-line Python script with 'with'
echo Waiting for WebUI server to start on localhost:8080...
python wait.py

:: Open localhost:8080 in the default web browser
start http://localhost:8080
