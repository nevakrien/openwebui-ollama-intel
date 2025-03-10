:: Activate oneAPI
call "C:\Program Files (x86)\Intel\oneAPI\setvars.bat"

:: Activate ipex_llm_env
call build\ipex_llm_env\Scripts\activate.bat

:: Go into ollama_ipex directory
cd build\ollama_ipex

:: Run ollama server
call ollama serve
