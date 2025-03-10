:: Activate webui_env
call build\webui_env\Scripts\activate.bat

:: Run open-webui server
call python -m open_webui serve
