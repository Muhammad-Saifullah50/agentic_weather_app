# Use a uv base image that includes Python 3.13 and uv
FROM ghcr.io/astral-sh/uv:python3.13-bookworm-slim

# Set the working directory
WORKDIR /app

# Copy the project files
COPY . /app

# Install dependencies (assumes pyproject.toml is present)
RUN uv sync

# Start the Chainlit app
CMD ["uv", "run", "chainlit", "run", "main.py", "--host", "0.0.0.0", "--port", "7860"]
