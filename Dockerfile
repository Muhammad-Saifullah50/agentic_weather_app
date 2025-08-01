# Use uv base image
FROM ghcr.io/astral-sh/uv:python3.13-bookworm-slim

RUN useradd -m -u 1000 user

# Set working directory to a user-owned directory
WORKDIR /home/user/app

# Copy files and change ownership
COPY --chown=user . .

# Switch to non-root user
USER user

# Install dependencies
RUN uv venv
RUN uv pip install -r requirements.txt

# Run Chainlit using uv
CMD ["uv", "run", "chainlit", "run", "main.py", "--host", "0.0.0.0", "--port", "7860"]
