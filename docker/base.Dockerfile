ARG HASH
FROM operator-installer:$HASH as installer

FROM python:3.10.0-slim-bullseye

RUN useradd -m -g operator -d /home/operator operator
WORKDIR /home/operator

COPY --from=installer --chown=operator:operator /home/operator/.venv /home/operator/.venv
ENV PATH /home/operator/.venv/bin:$PATH

RUN chown -R operator:operator /home/operator
USER operator
