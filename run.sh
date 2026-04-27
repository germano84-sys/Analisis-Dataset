#!/usr/bin/env bash
set -euo pipefail
# Cross-platform helper for UNIX-like systems: create venv, install deps, open notebook
python3 -m venv .venv || python -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
pip install -r requirements.txt
# Start the notebook (change to `jupyter lab` if preferred)
jupyter notebook titanic.ipynb
