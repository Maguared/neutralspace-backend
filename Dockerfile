# ============================================================
# NeutralSpace — Backend Dockerfile
# myneutralspace.com
# Updated: 2026-06-15
# ============================================================
FROM searxng/searxng:latest

# Copy our custom neutral configuration
COPY settings.yml /etc/searxng/settings.yml

# Disable Redis
ENV SEARXNG_REDIS_URL=""
ENV SEARXNG_SETTINGS_PATH=/etc/searxng/settings.yml
ENV SEARXNG_BIND_ADDRESS="0.0.0.0:8080"

HEALTHCHECK \
  --interval=30s \
  --timeout=5s \
  --start-period=20s \
  --retries=3 \
  CMD wget -q --spider http://localhost:8080/healthz || exit 1

EXPOSE 8080
CMD ["searxng-run"]
