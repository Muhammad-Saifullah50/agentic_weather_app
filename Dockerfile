# Use a uv base image that includes Python 3.13 and uv
FROM ghcr.io/astral-sh/uv:python3.13-bookworm-slim

# Set working directory
WORKDIR /app

# Set UV cache directory to a writable path
ENV UV_CACHE_DIR=/app/.cache/uv

# Copy files
COPY . /app

# Install dependencies
RUN mkdir -p $UV_CACHE_DIR && uv sync

# Run Chainlit app
CMD ["uv", "run", "chainlit", "run", "main.py", "--host", "0.0.0.0", "--port", "7860"]
