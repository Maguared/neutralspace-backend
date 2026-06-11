# ============================================================
# NeutralSpace — Backend Dockerfile
# neutralspace.xyz
#
# Uses nginx as a reverse proxy in front of SearXNG
# to handle CORS headers properly
# ============================================================

FROM searxng/searxng:latest

# Install nginx
USER root
RUN apk add --no-cache nginx

# Copy our custom neutral configuration
COPY settings.yml /etc/searxng/settings.yml

# Copy nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Startup script — runs both nginx and searxng
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Disable Redis
ENV SEARXNG_REDIS_URL=""
ENV SEARXNG_SETTINGS_PATH=/etc/searxng/settings.yml
ENV SEARXNG_BIND_ADDRESS="0.0.0.0:8888"

EXPOSE 8080

CMD ["/start.sh"]
