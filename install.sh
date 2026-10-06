#!/usr/bin/env bash
# Installer for Moein's Neovim config
set -euo pipefail

info() { printf "\033[1;34m==>\033[0m %s\n" "$1"; }
warn() { printf "\033[1;33m==>\033[0m %s\n" "$1"; }
fail() { printf "\033[1;31m==>\033[0m %s\n" "$1"; exit 1; }

command -v brew >/dev/null 2>&1 || fail "Homebrew لازم است: https://brew.sh"

info "نصب پیش‌نیازها با brew (اگر نباشند)…"
for pkg in neovim node ripgrep fd lazygit git; do
  brew list "$pkg" >/dev/null 2>&1 || brew install "$pkg"
done

info "نصب فونت JetBrainsMono Nerd Font…"
brew install --cask font-jetbrains-mono-nerd-font 2>/dev/null || warn "فونت را از nerdfonts.com دستی نصب کنید"

info "نصب فونت فارسی Vazirmatn (اختیاری)…"
brew install --cask font-vazirmatn 2>/dev/null || true

if [ -d "$HOME/.config/nvim" ] && [ ! -d "$HOME/.config/nvim/.git" ]; then
  warn "کانفیگ قبلی به ~/.config/nvim.bak.$(date +%s) منتقل می‌شود"
  mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak.$(date +%s)"
fi

if [ -d "$HOME/.config/nvim/.git" ]; then
  info "کانفیگ موجود است — آپدیت…"
  git -C "$HOME/.config/nvim" pull --rebase
else
  info "کلون کردن کانفیگ…"
  git clone https://github.com/moeinparvizi/neovim.git "$HOME/.config/nvim"
fi

info "پاک کردن پلاگین‌های قدیمی (lazy و mason)…"
rm -rf "$HOME/.local/share/nvim/lazy" "$HOME/.local/share/nvim/mason"

info "اجرای اولیه headless (نصب پلاگین‌ها، چند دقیقه طول می‌کشد)…"
nvim --headless "+Lazy! sync" +qa || true

info "نصب LSP ها و ابزارها…"
nvim --headless "+lua vim.defer_fn(function() vim.cmd('qa') end, 60000)" +qa || true

echo
info "تمام شد! حالا بزنید:  nvim"
warn "اولین اجرا ممکن است Treesitter پارسرها را کامپایل کند — صبر کنید و دوباره باز کنید."
warn "آموزش کامل فارسی: ~/.config/nvim/docs/README.md"
