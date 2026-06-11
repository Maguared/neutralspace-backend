#!/bin/sh
# ============================================================
# NeutralSpace — Backend Startup Script
# Starts nginx (CORS proxy on port 8080) and
# SearXNG (on port 8888) together
# ============================================================

# Start nginx in background
nginx -g 'daemon off;' &

# Start SearXNG in foreground
exec searxng-run
