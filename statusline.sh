#!/usr/bin/env bash
input=$(cat)

# Extraction du modèle et du contexte
MODEL=$(echo "$input" | jq -r '.model.id // "N/A"')
CTX_PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0 | floor')
if [ "$CTX_PCT" -lt 50 ]; then
  CTX_ICON="🟢"
elif [ "$CTX_PCT" -lt 80 ]; then
  CTX_ICON="🟠"
else
  CTX_ICON="🔴"
fi
CTX_USED=$(echo "$input" | jq -r '((.context_window.total_input_tokens // 0) + (.context_window.total_output_tokens // 0)) / 1000 | floor')
CTX_MAX=$(echo "$input" | jq -r '(.context_window.context_window_size // 0) / 1000 | floor')

# Extraction des quotas restants filtrés selon le modèle actif
QUOTAS=$(echo "$input" | jq -r '
  (.model.id // "" | ascii_downcase) as $mid |
  (if ($mid | test("gemini")) then "gemini" else "3p" end) as $target |
  (.quota // {}) | to_entries
  | map(select(.key | test("^" + $target)))
  | sort_by(
      if (.key | endswith("-5h")) then 1
      elif (.key == "\($target)-weekly") then 2
      else 3
      end,
      .key
    )
  | map(
    ((.value.remaining_fraction // 0) * 100 | floor) as $pct |
    (if $pct >= 50 then "🟢" elif $pct >= 20 then "🟠" else "🔴" end) as $icon |
    "\(.key | (.[0:1] | ascii_upcase) + .[1:]): \($icon) \($pct)%"
  ) | join(", ")
')

echo "🤖 $MODEL | 🧠 Ctx: $CTX_ICON ${CTX_PCT}% (${CTX_USED}k/${CTX_MAX}k)"
echo "⏳ ${QUOTAS:-Quotas N/A}"
