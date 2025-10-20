#!/usr/bin/env bash
set -euxo pipefail

echo "Building molftp wheel..."

# Upgrade build tools
python -m pip install --upgrade pip wheel build

# Install wheel of RDKit we just built
python -m pip install --find-links "${RDKIT_WHEEL_DIR}" rdkit

# molftp deps
python -m pip install numpy pandas scikit-learn

# Build wheel
cd external/molftp

# If pyproject exists, prefer PEP 517 build
python -m build --wheel --no-isolation

echo "✅ molftp wheel built successfully"

