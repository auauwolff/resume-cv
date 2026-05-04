#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HTML_PATH="$ROOT_DIR/cover-letter.html"
PDF_PATH="$ROOT_DIR/assets/pdf/Felipe-Wolff-Cover-Letter.pdf"

mkdir -p "$(dirname "$PDF_PATH")"

google-chrome \
  --headless \
  --disable-gpu \
  --no-sandbox \
  --no-pdf-header-footer \
  --print-to-pdf="$PDF_PATH" \
  "file://$HTML_PATH" >/tmp/resume-cover-letter-chrome.log 2>&1

echo "Generated:"
echo "  $PDF_PATH"
