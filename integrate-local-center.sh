#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  ./integrate-local-center.sh <path-to-local-center-repo> [build|serve] [hugo-server-args...]

Examples:
  ./integrate-local-center.sh /Users/adam/code/aipin/openPin/center
  ./integrate-local-center.sh /Users/adam/code/aipin/openPin/center build
  ./integrate-local-center.sh /Users/adam/code/aipin/openPin/center serve
  ./integrate-local-center.sh /Users/adam/code/aipin/openPin/center serve --disableFastRender

Modes:
  build   Build center artifacts, stage them into Hugo static/, then run ./setup.sh
  serve   Build center artifacts, stage them into Hugo static/, then run hugo server
EOF
}

if [[ $# -lt 1 ]]; then
  usage
  exit 1
fi

CENTER_REPO_INPUT="$1"
MODE="${2:-build}"
shift || true
if [[ $# -gt 0 ]]; then
  shift || true
fi
HUGO_SERVER_ARGS=("$@")

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CENTER_REPO="$(cd "$CENTER_REPO_INPUT" && pwd)"

if [[ ! -d "$CENTER_REPO" ]]; then
  echo "Center repo path does not exist: $CENTER_REPO_INPUT" >&2
  exit 1
fi

if [[ ! -f "$CENTER_REPO/package.json" ]]; then
  echo "Center repo path does not contain package.json: $CENTER_REPO" >&2
  exit 1
fi

if [[ ! -f "$SCRIPT_DIR/setup.sh" ]]; then
  echo "Expected setup.sh in website repo root: $SCRIPT_DIR" >&2
  exit 1
fi

if [[ "$MODE" != "build" && "$MODE" != "serve" ]]; then
  echo "Invalid mode: $MODE" >&2
  usage
  exit 1
fi

INSTALL_TARGET="$SCRIPT_DIR/static/install"
CENTER_TARGET="$SCRIPT_DIR/static/center"
INSTALLER_TARGET="$SCRIPT_DIR/static/installer"
DIST_HUGO_DIR="$CENTER_REPO/dist-hugo"

printf '\n==> Building center Hugo artifacts from %s\n' "$CENTER_REPO"
(
  cd "$CENTER_REPO"
  npm run build:hugo-static
)

if [[ ! -d "$DIST_HUGO_DIR/install" || ! -d "$DIST_HUGO_DIR/center" || ! -d "$DIST_HUGO_DIR/installer" ]]; then
  echo "Expected dist-hugo/install, dist-hugo/center, and dist-hugo/installer after build." >&2
  exit 1
fi

printf '\n==> Staging generated app artifacts into website/static\n'
rm -rf "$INSTALL_TARGET" "$CENTER_TARGET" "$INSTALLER_TARGET"
mkdir -p "$INSTALL_TARGET" "$CENTER_TARGET" "$INSTALLER_TARGET"
cp -R "$DIST_HUGO_DIR/install/." "$INSTALL_TARGET/"
cp -R "$DIST_HUGO_DIR/center/." "$CENTER_TARGET/"
cp -R "$DIST_HUGO_DIR/installer/." "$INSTALLER_TARGET/"

if [[ "$MODE" == "build" ]]; then
  printf '\n==> Building website and Pagefind index\n'
  (
    cd "$SCRIPT_DIR"
    ./setup.sh
  )
  printf '\nBuild complete. Validate these outputs locally:\n'
  printf '  %s/public/install/\n' "$SCRIPT_DIR"
  printf '  %s/public/center/\n' "$SCRIPT_DIR"
  printf '  %s/public/installer/\n' "$SCRIPT_DIR"
else
  printf '\n==> Starting Hugo server\n'
  (
    cd "$SCRIPT_DIR"
    if [[ ${#HUGO_SERVER_ARGS[@]} -gt 0 ]]; then
      hugo server "${HUGO_SERVER_ARGS[@]}"
    else
      hugo server
    fi
  )
fi
