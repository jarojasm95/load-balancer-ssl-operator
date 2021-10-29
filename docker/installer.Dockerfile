FROM python:3.10.0-bullseye

RUN apt-get update && \
    apt-get -y --no-install-recommends install \
    gettext \
    gcc \
    g++ \
    curl

WORKDIR /home/operator

ARG POETRY_VERSION=1.1.11
ENV PATH /root/.local/bin:$PATH
RUN pip install --upgrade pip && \
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py -o install-poetry.py && \
    python install-poetry.py --version $POETRY_VERSION

ENV PATH /home/operator/.venv/bin:$PATH
RUN python -m venv /home/operator/.venv && \
    pip install --upgrade pip

ENV POETRY_VIRTUALENVS_CREATE="false"
ENV POETRY_INSTALLER_PARALLEL="false"
COPY poetry.lock pyproject.toml ./
RUN poetry install --no-root --no-dev
