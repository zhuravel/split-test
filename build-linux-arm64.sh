#!/bin/bash
# Cross-compile split-test for Linux ARM64 using Docker
# This keeps the host system clean by using a containerized Rust environment

set -euo pipefail

echo "Building split-test for Linux ARM64 using Docker..."

docker run --rm \
  -v "$PWD":/workspace \
  -w /workspace \
  rust:latest \
  cargo build --release --target aarch64-unknown-linux-gnu

echo "✅ Build completed successfully!"
echo "Binary location: target/aarch64-unknown-linux-gnu/release/split-test"

# Verify the binary
if [ -f "target/aarch64-unknown-linux-gnu/release/split-test" ]; then
    echo "Binary details:"
    file target/aarch64-unknown-linux-gnu/release/split-test
else
    echo "❌ Binary not found!"
    exit 1
fi