SHELL := /bin/bash
PYTHON_CMD := $(shell which python3.11 | which python3.10 | which python3.9 | which python 3.8)
VENV_PATH := ./venv
SOURCE_CMD := . $(VENV_PATH)/bin/activate;

.PHONY: setup-pip-tools hello source update-requirements

setup-pip-tools: source
	$(PYTHON_CMD) -m pip install --upgrade pip pip-tools

hello:
	echo "Hello World!"

source:
	$(SOURCE_CMD)

update-requirements: source setup-pip-tools
	$(PYTHON_CMD) -m piptools compile --resolver=backtracking requirements.in

