#!/usr/bin/env bash
set -euxo pipefail

echo "Building bcfp wheel..."

# Upgrade build tools
python -m pip install --upgrade pip wheel build

# Install wheel of RDKit we just built (pulled from artifact dir passed by CI)
python -m pip install --find-links "${RDKIT_WHEEL_DIR}" rdkit

# bcfp deps
python -m pip install numpy xxhash blake3

# Build wheel
cd external/bcfp

# If pyproject exists, prefer PEP 517 build
python -m build --wheel --no-isolation

echo "✅ bcfp wheel built successfully"

