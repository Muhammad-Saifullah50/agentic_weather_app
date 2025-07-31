# Base image with Python 3.13 and uv
FROM ghcr.io/astral-sh/uv:python3.13-bookworm-slim

# Set working directory
WORKDIR /app

# Set UV cache directory inside the app folder
ENV UV_CACHE_DIR=/app/.uv-cache

# Copy files
COPY . /app

# Create cache dir with full permissions (before installing)
RUN mkdir -p $UV_CACHE_DIR && chmod -R 777 $UV_CACHE_DIR

# Install dependencies
RUN uv sync

# Create and switch to non-root user
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser
RUN chown -R appuser:appgroup /app
USER appuser

# Run the app
CMD ["uv", "run", "chainlit", "run", "main.py", "--host", "0.0.0.0", "--port", "7860"]
