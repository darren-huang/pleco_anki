SHELL := /bin/bash
PYTHON_CMD := $(shell which python3.11 || which python3.10 || which python3.9 || which python 3.8)
VENV_PATH := .venv
SOURCE_CMD := . $(VENV_PATH)/bin/activate;

.PHONY: setup-pip-tools hello source update-requirements

_recreate-venv:
	rm -rf $(VENV_PATH)
	$(PYTHON_CMD) -m venv $(VENV_PATH)

_source:
	$(SOURCE_CMD)

setup-pip-tools: _source
	$(PYTHON_CMD) -m pip install --upgrade pip pip-tools

update-requirements: _source setup-pip-tools
	$(PYTHON_CMD) -m piptools compile --resolver=backtracking requirements.in
	$(PYTHON_CMD) -m pip install -r requirements.txt

create-venv: _recreate-venv _source setup-pip-tools update-requirements