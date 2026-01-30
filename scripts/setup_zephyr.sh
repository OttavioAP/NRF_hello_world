#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "${script_dir}/.." && pwd)"

if [[ -x "${repo_root}/.venv/bin/python" ]]; then
  export WEST_PYTHON="${repo_root}/.venv/bin/python"
  export PATH="${repo_root}/.venv/bin:${PATH}"
fi

if [[ -d "${repo_root}/.west" && ! -f "${repo_root}/.west/config" ]]; then
  echo "Found partial .west directory without config; removing it."
  rm -rf "${repo_root}/.west"
fi

cd "${repo_root}"

if ! west topdir >/dev/null 2>&1; then
  west init -l .
fi

west update
west zephyr-export
