#!/usr/bin/env bash

set -e

echo "=============================="
echo "RunnyVision World Setup"
echo "=============================="

# -----------------------------
# Check Node.js
# -----------------------------
if ! command -v node &> /dev/null
then
  echo "Node.js not found."
  echo "Please install Node.js (>=18) from:"
  echo "https://nodejs.org/"
  exit 1
fi

echo "Node version:"
node -v

# -----------------------------
# Initialize npm if needed
# -----------------------------
if [ ! -f package.json ]; then
  echo "Initializing npm project..."
  npm init -y
else
  echo "package.json already exists."
fi

# -----------------------------
# Install dependencies
# -----------------------------
echo "Installing dependencies..."

npm install three
npm install --save-dev vite

# -----------------------------
# Create basic project structure
# -----------------------------
echo "Creating project structure..."

mkdir -p src
mkdir -p src/shaders
mkdir -p assets/placeholders

# -----------------------------
# Add npm scripts if missing
# -----------------------------
if ! grep -q '"dev"' package.json; then
  echo "Adding npm scripts..."

  node - <<'EOF'
const fs = require('fs');
const pkg = JSON.parse(fs.readFileSync('package.json'));

pkg.scripts = pkg.scripts || {};
pkg.scripts.dev = "vite";
pkg.scripts.build = "vite build";
pkg.scripts.preview = "vite preview";

fs.writeFileSync('package.json', JSON.stringify(pkg, null, 2));
EOF
fi

# -----------------------------
# Done
# -----------------------------
echo "=============================="
echo "Setup complete."
echo
echo "Next steps:"
echo "  1. Create index.html"
echo "  2. Create src/main.js"
echo "  3. Run: npm run dev"
echo "=============================="