# Use a uv base image that includes Python 3.13 and uv
FROM ghcr.io/astral-sh/uv:python3.13-bookworm-slim

# Set working directory
WORKDIR /app

# Set UV cache directory to /tmp (fully writable)
ENV UV_CACHE_DIR=/tmp/uv-cache

# Copy files
COPY . /app

# Install dependencies
RUN mkdir -p $UV_CACHE_DIR && uv sync

# Run Chainlit app
CMD ["uv", "run", "chainlit", "run", "main.py", "--host", "0.0.0.0", "--port", "7860"]
