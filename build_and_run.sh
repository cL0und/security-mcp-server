#!/bin/bash

# Exit on error
set -e

IMAGE_NAME="web-pentest-mcp-server"

echo "[*] Building the Docker image: $IMAGE_NAME..."
docker build -t $IMAGE_NAME .

echo "[*] Build successful!"
echo "[*] To run the MCP server (mount this repo so /app/web_pentest_mcp_server.py comes from the host):"
echo "    docker run -i --rm -v \"\$(pwd):/app\" $IMAGE_NAME"
echo ""
echo "[*] Example .mcp.json (replace HOST_PATH with the absolute path to this repo on your machine):"
echo '
{
  "mcpServers": {
    "web-pentest-tools": {
      "command": "docker",
      "args": ["run", "-i", "--rm", "-v", "HOST_PATH:/app", "web-pentest-mcp-server"]
    }
  }
}'