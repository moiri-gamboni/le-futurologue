#!/usr/bin/env bash
# Regenerate subsetted woff2 fonts from the source .otf / .ttf files in
# artistic-direction/Direction\ artistique/Font/. Run this if you need to widen
# the unicode range or drop/add a weight.
#
# Requires: uv (https://docs.astral.sh/uv/).
set -euo pipefail

SRC_METRO="artistic-direction/Direction artistique/Font/metropolis"
SRC_SQUANOVA="artistic-direction/Direction artistique/Font/Squanova_new-Regular.ttf"
OUT_METRO="static/fonts/metropolis"
OUT_SQUANOVA="static/fonts/squanova"

# Metropolis: Basic Latin + Latin-1 Supplement + Latin Extended-A + General Punctuation + Euro.
# Covers all French diacritics, guillemets, smart quotes, en/em dashes, narrow no-break space (if present).
METRO_UNICODES="U+0020-007F,U+00A0-017F,U+2000-206F,U+20AC"

# Squanova: narrower range — the font itself only contains Basic Latin + Latin-1 + smart quotes + Euro.
# unicode-range in @font-face further constrains which codepoints the browser asks Squanova to render.
SQUANOVA_UNICODES="U+0020-007E,U+00A0-00FF,U+2018-201E,U+20AC"

mkdir -p "$OUT_METRO" "$OUT_SQUANOVA"

for face in "Regular:regular" "RegularItalic:regular-italic" "Medium:medium" "Bold:bold"; do
  src_name="${face%%:*}"
  out_name="${face##*:}"
  src="$SRC_METRO/Metropolis-${src_name}.otf"
  dest="$OUT_METRO/metropolis-${out_name}.woff2"
  uv tool run --from 'fonttools[woff]' pyftsubset "$src" \
    --output-file="$dest" \
    --flavor=woff2 \
    --unicodes="$METRO_UNICODES" \
    --layout-features='*' \
    --no-hinting \
    --desubroutinize
  printf "%-52s %s\n" "$dest" "$(du -h "$dest" | cut -f1)"
done

uv tool run --from 'fonttools[woff]' pyftsubset "$SRC_SQUANOVA" \
  --output-file="$OUT_SQUANOVA/squanova-regular.woff2" \
  --flavor=woff2 \
  --unicodes="$SQUANOVA_UNICODES" \
  --layout-features='*' \
  --no-hinting \
  --desubroutinize
printf "%-52s %s\n" "$OUT_SQUANOVA/squanova-regular.woff2" "$(du -h "$OUT_SQUANOVA/squanova-regular.woff2" | cut -f1)"

# Copy licenses
cp "$SRC_METRO/SIL Open Font License.txt" "$OUT_METRO/LICENSE.txt"
