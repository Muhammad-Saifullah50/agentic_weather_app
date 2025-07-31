# Base image with Python 3.13 and uv
FROM ghcr.io/astral-sh/uv:python3.13-bookworm-slim

# Set working directory
WORKDIR /app

# Set UV cache directory to /tmp/uv-cache
ENV UV_CACHE_DIR=/tmp/uv-cache

# Create cache directory with full permissions
RUN mkdir -p $UV_CACHE_DIR && chmod -R 777 $UV_CACHE_DIR

# Copy project files
COPY . /app

# Install dependencies as root
RUN uv sync

# Create a non-root user
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

# Make sure /app and /tmp are accessible by the user
RUN chown -R appuser:appgroup /app /tmp

# Switch to non-root user
USER appuser

# Run the app
CMD ["uv", "run", "chainlit", "run", "main.py", "--host", "0.0.0.0", "--port", "7860"]
