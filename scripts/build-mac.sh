#!/usr/bin/env bash
# Gera o Idleterino para o Mac em que este script roda (Apple Silicon ou Intel).
# Uso: bash scripts/build-mac.sh [opções do electron-builder, ex.: --arm64 --x64]
set -euo pipefail
cd "$(dirname "$0")/.."

if [ "$(uname)" != "Darwin" ]; then echo "Rode este script num Mac."; exit 1; fi
if ! command -v node >/dev/null || ! node -e 'const [a,b]=process.versions.node.split(".").map(Number);process.exit(a>22||(a===22&&b>=12)?0:1)'; then
  echo "Instale o Node.js 22.12 ou mais novo: https://nodejs.org"; exit 1
fi

VERSAO="$(node -p 'require("./package.json").version')"
# Código do Trader (opcional, criptografado): só abre com licença válida. Tem de ser o da mesma versão.
echo "==> Baixando o trader-codigo.idlcode da v$VERSAO (opcional)"
rm -f trader-codigo.idlcode
if curl -fsSL --retry 2 -o trader-codigo.idlcode.tmp "https://github.com/ViinniSantoos/idleterino/releases/download/v$VERSAO/trader-codigo.idlcode"; then
  mv trader-codigo.idlcode.tmp trader-codigo.idlcode
else
  rm -f trader-codigo.idlcode.tmp
  echo "    Não achei: o app vai funcionar sem o Trader."
fi

echo "==> Instalando dependências"
npm ci
echo "==> Gerando o app"
rm -rf dist
npm run dist:mac -- "$@"
for app in dist/mac*/Idleterino.app; do
  codesign --verify --deep --strict "$app"
  echo "Assinatura local OK: $app"
done
echo "==> Pronto:"
ls -1 dist/*.dmg
