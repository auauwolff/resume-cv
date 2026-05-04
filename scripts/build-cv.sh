#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HTML_PATH="$ROOT_DIR/cv.html"
PDF_PATH="$ROOT_DIR/assets/pdf/Felipe-Wolff-CV.pdf"
DOC_DIR="$ROOT_DIR/assets/doc"
DOC_PATH="$DOC_DIR/Felipe-Wolff-CV.docx"

mkdir -p "$(dirname "$PDF_PATH")" "$DOC_DIR"

google-chrome \
  --headless \
  --disable-gpu \
  --no-sandbox \
  --no-pdf-header-footer \
  --print-to-pdf="$PDF_PATH" \
  "file://$HTML_PATH" >/tmp/resume-cv-chrome.log 2>&1

rm -f "$DOC_DIR/cv.docx" "$DOC_PATH"
libreoffice \
  --headless \
  --infilter='HTML (StarWriter)' \
  --convert-to 'docx:Office Open XML Text' \
  --outdir "$DOC_DIR" \
  "$HTML_PATH" >/tmp/resume-cv-libreoffice.log 2>&1

mv "$DOC_DIR/cv.docx" "$DOC_PATH"

echo "Generated:"
echo "  $PDF_PATH"
echo "  $DOC_PATH"
