#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

BASE_DIR="$HOME/NRV-AI-FACTORY"
WORKER="$BASE_DIR/mobile-worker/worker.sh"
BOOT_DIR="$HOME/.termux/boot"
BOOT_FILE="$BOOT_DIR/nrv-factory-worker.sh"

pkg update -y
pkg install -y git gh nodejs python jq termux-api

mkdir -p "$HOME/nrv-projects" "$HOME/.nrv-factory" "$BOOT_DIR"
chmod +x "$WORKER"

cat > "$BOOT_FILE" <<'EOF'
#!/data/data/com.termux/files/usr/bin/bash
termux-wake-lock
cd "$HOME/NRV-AI-FACTORY/mobile-worker"
nohup ./worker.sh >> "$HOME/.nrv-factory/boot.log" 2>&1 &
EOF
chmod +x "$BOOT_FILE"

if ! gh auth status >/dev/null 2>&1; then
  echo
  echo "GitHub ещё не авторизован. Выполни:"
  echo "  gh auth login"
  echo
fi

echo "NRV Mobile Worker установлен."
echo "Для запуска сейчас:"
echo "  termux-wake-lock"
echo "  cd $BASE_DIR/mobile-worker"
echo "  ./worker.sh"
echo
echo "Для автозапуска после перезагрузки установи Termux:Boot и один раз открой его."
