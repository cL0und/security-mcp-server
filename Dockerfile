# Use golang base image to easily compile Go-based security tools
FROM golang:1.26-bookworm

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/root/go/bin:/opt/venv/bin:$PATH"
ENV MCP_HOST=0.0.0.0
ENV MCP_PORT=4000

# Install system dependencies, Python, and default wordlists (dirb)
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    curl \
    wget \
    unzip \
    git \
    dirb \
    && rm -rf /var/lib/apt/lists/*

# Install Subfinder
RUN go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

# Install Katana
RUN go install github.com/projectdiscovery/katana/cmd/katana@latest

# Install FFUF
RUN go install github.com/ffuf/ffuf/v2@latest

# Install Feroxbuster
RUN curl -sL https://raw.githubusercontent.com/epi052/feroxbuster/main/install-nix.sh | bash \
    && mv feroxbuster /usr/local/bin/

# Set up Python virtual environment and install MCP dependencies
RUN python3 -m venv /opt/venv
RUN pip install --no-cache-dir fastmcp langchain-mcp-adapters deepagents

# Mount point: bind-mount the project dir from the host at run time, e.g.
#   docker run -i --rm -v "$PWD:/app" ...
WORKDIR /app

EXPOSE 4000

# Run MCP server from the mounted tree (no script baked into the image)
ENTRYPOINT ["/opt/venv/bin/python3", "/app/web_pentest_mcp_server.py"]