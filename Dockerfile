# Base image with Python 3.13 and uv
FROM ghcr.io/astral-sh/uv:python3.13-bookworm-slim

RUN useradd -m -u 1000 user

USER user

ENV PATH="/home/user/.local/bin:$PATH"
ENV VIRTUAL_ENV=/home/user/venv
RUN python -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Set working directory
WORKDIR /app

COPY --chown=user ./requirements.txt requirements.txt

RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir chainlit
RUN pip install -r requirements.txt
 

CMD ["python", "-m", "chainlit", "run", "main.py", "--host", "0.0.0.0", "--port", "7000"]