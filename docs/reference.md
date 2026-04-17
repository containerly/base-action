# Inputs & Outputs

## Inputs

### `files` (required)

Space-separated list of shell script files or glob patterns to check.

```yaml
files: entrypoint.sh scripts/*.sh
```

### `severity`

Minimum severity level to report. Issues below this level are ignored.

| Value | Description |
|-------|-------------|
| `style` | All issues including style suggestions |
| `info` | Informational and above |
| `warning` | Warnings and above (default) |
| `error` | Errors only |

### `format`

Output format passed to `shellcheck --format`.

| Value | Best for |
|-------|----------|
| `tty` | Human-readable terminal output (default) |
| `checkstyle` | GitHub annotations via a follow-up step |
| `gcc` | Editor integrations |
| `json` / `json1` | Downstream processing |
| `diff` | Auto-fix previews |
| `quiet` | Suppress output, check exit code only |

### `shell`

Force ShellCheck to treat files as a specific dialect regardless of the shebang line.

```yaml
shell: bash
```

### `exclude`

Comma-separated list of ShellCheck codes to silence globally.

```yaml
exclude: SC2034,SC2086
```

### `args`

Escape hatch for any flags not covered by the inputs above.

```yaml
args: --external-sources --source-path=SCRIPTDIR
```

## Outputs

### `exit-code`

The raw exit code returned by `shellcheck`. Use this when `no-fail` equivalent
behaviour is needed — run the step with `continue-on-error: true` and inspect
the output in a later step.

```yaml
- id: lint
  uses: containerly/base-action@v1
  continue-on-error: true
  with:
    files: entrypoint.sh

- run: echo "shellcheck exited with ${{ steps.lint.outputs.exit-code }}"
```
