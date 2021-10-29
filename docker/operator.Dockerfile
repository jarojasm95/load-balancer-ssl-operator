ARG HASH
FROM operator-installer:$HASH as installer

RUN poetry install --no-root --no-dev

ARG HASH
FROM operator-base:$HASH

COPY --from=installer --chown=operator:operator /home/operator/.venv /home/operator/.venv

COPY --chown=operator:operator load_balancer_ssl_operator load_balancer_ssl_operator
