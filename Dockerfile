FROM quay.io/keycloak/keycloak:latest as builder

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_DB=postgres
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:latest
COPY --from=builder /opt/keycloak/ /opt/keycloak/
ENV KC_HTTP_ENABLED=true
ENV KC_HOSTNAME_STRICT=false
ENV PROXY_ADDRESS_FORWARDING=false
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start"]
