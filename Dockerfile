FROM ghcr.io/astral-sh/uv:python3.13-bookworm-slim

WORKDIR /app

# Disable UV cache
ENV UV_NO_CACHE=1

COPY . /app

RUN uv sync

CMD ["uv", "run", "chainlit", "run", "main.py", "--host", "0.0.0.0", "--port", "7860"]
