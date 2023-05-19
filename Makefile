SHELL := /bin/bash
USER_PYTHON_CMD := $(shell which python3.11 || which python3.10 || which python3.9 || which python 3.8)
VENV_PATH := .venv
VENV_PYTHON_CMD := $(VENV_PATH)/bin/python
SOURCE_CMD := . $(VENV_PATH)/bin/activate;

.PHONY: setup-pip-tools hello source update-requirements

_recreate-venv:
	rm -rf $(VENV_PATH)
	$(USER_PYTHON_CMD) -m venv $(VENV_PATH)

setup-pip-tools:
	$(VENV_PYTHON_CMD) -m pip install --upgrade pip pip-tools

update-requirements: setup-pip-tools
	$(VENV_PYTHON_CMD) -m piptools compile --resolver=backtracking requirements.in
	$(VENV_PYTHON_CMD) -m pip install -r requirements.txt

create-venv: _recreate-venv update-requirements