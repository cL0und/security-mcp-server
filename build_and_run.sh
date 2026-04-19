#!/bin/bash

# Exit on error
set -e

IMAGE_NAME="web-pentest-mcp-server"

echo "[*] Building the Docker image: $IMAGE_NAME..."
docker build -t $IMAGE_NAME .

echo "[*] Build successful!"
echo "[*] Run SSE MCP (publish port 4000, mount repo for /app/web_pentest_mcp_server.py):"
echo "    docker run --rm -p 4000:4000 -v \"\$(pwd):/app\" $IMAGE_NAME"
echo ""
echo "[*] Connect clients to SSE (FastMCP default path /sse on MCP_PORT):"
echo "    http://127.0.0.1:4000/sse"
echo ""
echo "[*] Example .mcp.json (SSE over local Docker):"
echo '
{
  "mcpServers": {
    "web-pentest-tools": {
      "url": "http://127.0.0.1:4000/sse",
      "transport": "sse"
    }
  }
}'