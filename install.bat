setlocal enabledelayedexpansion

:: Check if "build" directory exists
if exist build (
    echo Warning: 'build' directory already exists. Exiting.
    exit /b 1
)

:: Create "build" directory
echo Creating 'build' directory...
mkdir build
echo 'build' directory created.

:: Activate oneAPI
echo Activating oneAPI...
call "C:\Program Files (x86)\Intel\oneAPI\setvars.bat"
if %ERRORLEVEL% NEQ 0 (
    echo Failed to activate oneAPI.
    exit /b 1
)

:: Create a virtual environment named ipex_llm_env
echo Creating virtual environment: ipex_llm_env...
python -m venv build\ipex_llm_env
if %ERRORLEVEL% NEQ 0 (
    echo Failed to create virtual environment: ipex_llm_env.
    exit /b 1
)

:: Activate the virtual environment and install ipex-llm
echo Activating ipex_llm_env and installing ipex-llm...
call build\ipex_llm_env\Scripts\activate
echo Running: pip install --pre --upgrade ipex-llm[cpp]
pip install --pre --upgrade ipex-llm[cpp]
if %ERRORLEVEL% NEQ 0 (
    echo Failed to install ipex-llm.
    exit /b 1
)

:: Create ollama_ipex directory and navigate into it
echo Creating and navigating to ollama_ipex directory...
mkdir build\ollama_ipex
cd build\ollama_ipex
echo Current directory: %CD%

:: Call init-ollama.bat
echo Running init-ollama.bat...
call init-ollama.bat
if %ERRORLEVEL% NEQ 0 (
    echo Failed to initialize Ollama.
    exit /b 1
)

:: Move back to the build directory
cd ..
echo Current directory: %CD%

:: Create a second virtual environment named webui_env
echo Creating virtual environment: webui_env...
python -m venv webui_env
if %ERRORLEVEL% NEQ 0 (
    echo Failed to create virtual environment: webui_env.
    exit /b 1
)

:: Activate the webui_env and install open-webui
echo Activating webui_env and installing open-webui...
call webui_env\Scripts\activate
echo Running: pip install open-webui
pip install open-webui
if %ERRORLEVEL% NEQ 0 (
    echo Failed to install open-webui.
    exit /b 1
)

echo Installation complete!
exit /b 0
