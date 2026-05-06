#!/bin/bash
# Build and install Mistral Vibe from source

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "Installing Mistral Vibe from: $PROJECT_DIR"

cd "$PROJECT_DIR"
echo "Installing with pip..."
python3.13 pip install --user -e .

echo ""
echo "Mistral Vibe installed successfully!"
echo "You can now run:"
echo "  vibe        - Start the CLI"
echo "  vibe-acp    - Start the ACP server"
