# Use uv base image with Python 3.13
FROM ghcr.io/astral-sh/uv:python3.13-bookworm-slim

# Create a non-root user and group
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

# Set working directory
WORKDIR /app

# Set UV cache directory to /tmp (fully writable)
ENV UV_CACHE_DIR=/tmp/uv-cache

# Create writable dirs and set permissions
RUN mkdir -p /app /tmp/uv-cache && \
    chown -R appuser:appgroup /app /tmp/uv-cache

# Switch to non-root user
USER appuser

# Copy app files after switching to user
COPY --chown=appuser:appgroup . /app

# Install dependencies
RUN uv sync

# Run Chainlit app
CMD ["uv", "run", "chainlit", "run", "main.py", "--host", "0.0.0.0", "--port", "7860"]
