#!/bin/bash
# Cross-compile split-test for Linux (ARM64 and x64) using Docker
# This keeps the host system clean by using a containerized Rust environment

set -euo pipefail

echo "Building split-test for Linux (ARM64 and x64) using Docker..."

# Build for ARM64
echo ""
echo "Building for ARM64..."
docker run --rm \
  -v "$PWD":/workspace \
  -w /workspace \
  rust:latest \
  cargo build --release --target aarch64-unknown-linux-gnu

# Build for x64
echo ""
echo "Building for x64..."
docker run --rm \
  -v "$PWD":/workspace \
  -w /workspace \
  rust:latest \
  cargo build --release --target x86_64-unknown-linux-gnu

echo ""
echo "✅ Build completed successfully!"
echo ""
echo "Binary locations:"
echo "  ARM64: target/aarch64-unknown-linux-gnu/release/split-test"
echo "  x64:   target/x86_64-unknown-linux-gnu/release/split-test"

# Verify the binaries
echo ""
echo "Binary details:"
if [ -f "target/aarch64-unknown-linux-gnu/release/split-test" ]; then
    file target/aarch64-unknown-linux-gnu/release/split-test
else
    echo "❌ ARM64 binary not found!"
    exit 1
fi

if [ -f "target/x86_64-unknown-linux-gnu/release/split-test" ]; then
    file target/x86_64-unknown-linux-gnu/release/split-test
else
    echo "❌ x64 binary not found!"
    exit 1
fi