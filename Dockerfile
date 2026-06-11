# ============================================================
# NeutralSpace — Backend Dockerfile
# neutralspace.xyz
#
# Builds a SearXNG instance with our custom neutral
# configuration. Designed for Railway free tier deployment.
# ============================================================

FROM searxng/searxng:latest

# Copy our custom neutral configuration
COPY settings.yml /etc/searxng/settings.yml

# Disable Redis — no session storage, no tracking
ENV SEARXNG_REDIS_URL=""

# Tell SearXNG where to find our settings
ENV SEARXNG_SETTINGS_PATH=/etc/searxng/settings.yml

# Bind to 0.0.0.0 so Railway can route traffic to the container
ENV SEARXNG_BIND_ADDRESS="0.0.0.0:8080"

# Health check — Railway uses this to know the app is ready
# Checks every 30s, fails after 3 missed checks
HEALTHCHECK \
  --interval=30s \
  --timeout=5s \
  --start-period=20s \
  --retries=3 \
  CMD curl -f http://localhost:8080/healthz || exit 1

# Expose the port Railway will route to
EXPOSE 8080

# Start SearXNG
CMD ["searxng-run"]
