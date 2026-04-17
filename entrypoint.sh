#!/bin/bash
set -uo pipefail

CMD_ARGS=()

# --- helpers -----------------------------------------------------------------
# GitHub Actions maps every input to INPUT_<UPPERCASED_NAME> automatically.

add_if_true() { [[ "${2:-false}" == "true" ]] && CMD_ARGS+=("$1"); }
add_if_set()  { [[ -n "${2:-}" ]]             && CMD_ARGS+=("$1" "$2"); }

# --- build args --------------------------------------------------------------

add_if_set "--severity" "${INPUT_SEVERITY:-}"
add_if_set "--format"   "${INPUT_FORMAT:-}"
add_if_set "--shell"    "${INPUT_SHELL:-}"
add_if_set "--exclude"  "${INPUT_EXCLUDE:-}"

[[ -n "${INPUT_ARGS:-}" ]] && CMD_ARGS+=( ${INPUT_ARGS} )

# shellcheck disable=SC2206
FILES=( ${INPUT_FILES} )

# --- execute -----------------------------------------------------------------

echo "::group::shellcheck ${CMD_ARGS[*]} ${FILES[*]}"
EXIT_CODE=0
shellcheck "${CMD_ARGS[@]}" "${FILES[@]}" || EXIT_CODE=$?
echo "::endgroup::"

echo "exit-code=${EXIT_CODE}" >> "$GITHUB_OUTPUT"
exit "$EXIT_CODE"
