#!/usr/bin/env bash
input=$(cat)

# Extraction du modèle et du contexte
MODEL=$(echo "$input" | jq -r '.model.id // "N/A"')
CTX_PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0 | floor')
CTX_USED=$(echo "$input" | jq -r '((.context_window.total_input_tokens // 0) + (.context_window.total_output_tokens // 0)) / 1000 | floor')
CTX_MAX=$(echo "$input" | jq -r '(.context_window.context_window_size // 0) / 1000 | floor')

# Extraction des quotas restants par réservoir
QUOTAS=$(echo "$input" | jq -r '
  (.quota // {}) | to_entries | map(
    "\(.key): \(((.value.remaining_fraction // 0) * 100) | floor)%"
  ) | join(" | ")
')

echo "🤖 $MODEL | 🧠 Ctx: ${CTX_PCT}% (${CTX_USED}k/${CTX_MAX}k) | 🔋 ${QUOTAS:-Quotas N/A}"
