#!/usr/bin/env bash
set -euxo pipefail

echo "Building molftp wheel..."

# Upgrade build tools
python -m pip install --upgrade pip wheel build setuptools

# Install wheel of RDKit we just built
echo "Installing RDKit from ${RDKIT_WHEEL_DIR}..."
python -m pip install --find-links "${RDKIT_WHEEL_DIR}" rdkit

# molftp deps
python -m pip install numpy pandas scikit-learn

# Build wheel
cd external/molftp

# Use PEP 517 build with --no-isolation
python -m build --wheel --no-isolation

echo "✅ molftp wheel built successfully"
ls -lh dist/

