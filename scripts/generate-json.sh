#!/usr/bin/env bash
set -e
cd "$(dirname "$(dirname "$(readlink -f "$0")")")"

scripts/generate-basename.json.pl eza/src/output/icons.rs | jq -S . > assets/json/extra/basename.json
scripts/generate-extension.json.pl eza/src/output/icons.rs | jq -S . > assets/json/extra/extension.json
scripts/generate-pattern.json.pl eza/src/output/icons.rs | jq -S . > assets/json/extra/pattern.json
