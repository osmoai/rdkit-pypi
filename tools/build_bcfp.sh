#!/usr/bin/env bash
set -euxo pipefail

echo "Building bcfp wheel..."

# Upgrade build tools
python -m pip install --upgrade pip wheel build setuptools

# Install wheel of RDKit we just built (pulled from artifact dir passed by CI)
echo "Installing RDKit from ${RDKIT_WHEEL_DIR}..."
python -m pip install --find-links "${RDKIT_WHEEL_DIR}" rdkit

# bcfp deps
python -m pip install numpy xxhash blake3

# Build wheel
cd external/bcfp

# Use PEP 517 build with --no-isolation
python -m build --wheel --no-isolation

echo "✅ bcfp wheel built successfully"
ls -lh dist/

