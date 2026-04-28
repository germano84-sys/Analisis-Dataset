@echo off
REM Cross-platform helper for Windows: create venv, install deps, open notebook
python -m venv .venv
call .venv\Scripts\activate.bat
python -m pip install --upgrade pip
pip install -r requirements.txt
REM Start the notebook (use "jupyter lab" if preferred)
jupyter notebook titanic.ipynb
