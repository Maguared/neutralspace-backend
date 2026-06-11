# ============================================================
# NeutralSpace — Backend Dockerfile
# neutralspace.xyz
# ============================================================

FROM searxng/searxng:latest

# Install nginx using apt-get (Debian-based image)
USER root
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# Copy configurations
COPY settings.yml /etc/searxng/settings.yml
COPY nginx.conf /etc/nginx/nginx.conf
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Disable Redis
ENV SEARXNG_REDIS_URL=""
ENV SEARXNG_SETTINGS_PATH=/etc/searxng/settings.yml
ENV SEARXNG_BIND_ADDRESS="0.0.0.0:8888"

EXPOSE 8080

CMD ["/start.sh"]
