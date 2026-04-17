#!/bin/bash
set -uo pipefail

COMMAND="${INPUT_COMMAND:-<default-command>}"
CMD_ARGS=()

# --- helpers -----------------------------------------------------------------
# GitHub Actions maps every input to INPUT_<UPPERCASED_NAME> automatically.
# Use these two helpers to build CMD_ARGS cleanly.

add_if_true() { [[ "${2:-false}" == "true" ]] && CMD_ARGS+=("$1"); }
add_if_set()  { [[ -n "${2:-}" ]]             && CMD_ARGS+=("$1" "$2"); }

# --- build args --------------------------------------------------------------

case "$COMMAND" in
  # TODO: add a case per supported command
  <command>)
    CMD_ARGS+=("<command>")
    add_if_true "--flag"  "${INPUT_FLAG:-false}"
    add_if_set  "--opt"   "${INPUT_OPT:-}"
    ;;
  *)
    echo "::error::Unknown command: '${COMMAND}'"
    exit 1
    ;;
esac

# Escape hatch: append any raw extra args last
[[ -n "${INPUT_ARGS:-}" ]] && CMD_ARGS+=( ${INPUT_ARGS} )

# --- execute -----------------------------------------------------------------

echo "::group::<cli> ${CMD_ARGS[*]}"
EXIT_CODE=0
<cli> "${CMD_ARGS[@]}" || EXIT_CODE=$?
echo "::endgroup::"

echo "exit-code=${EXIT_CODE}" >> "$GITHUB_OUTPUT"
exit "$EXIT_CODE"
