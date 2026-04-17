# ShellCheck Action

Run [ShellCheck](https://www.shellcheck.net/) static analysis on shell scripts directly in your GitHub Actions workflow.

## Usage

```yaml
- uses: containerly/base-action@v1
  with:
    files: entrypoint.sh scripts/*.sh
```

### Fail on errors only

```yaml
- uses: containerly/base-action@v1
  with:
    files: entrypoint.sh
    severity: error
```

### Exclude specific checks

```yaml
- uses: containerly/base-action@v1
  with:
    files: entrypoint.sh
    exclude: SC2034,SC2086
```

### Checkstyle output for annotations

```yaml
- uses: containerly/base-action@v1
  with:
    files: '**/*.sh'
    format: checkstyle
```

## Inputs

| Input | Required | Default | Description |
|-------|----------|---------|-------------|
| `files` | yes | | Space-separated list of shell script files to check |
| `severity` | no | `warning` | Minimum severity: `error`, `warning`, `info`, `style` |
| `format` | no | `tty` | Output format: `tty`, `checkstyle`, `diff`, `gcc`, `json`, `json1`, `quiet` |
| `shell` | no | | Override shell dialect: `sh`, `bash`, `dash`, `ksh` |
| `exclude` | no | | Comma-separated check codes to exclude (e.g. `SC2034,SC2086`) |
| `args` | no | | Additional raw arguments appended to the `shellcheck` command |

## Outputs

| Output | Description |
|--------|-------------|
| `exit-code` | Exit code returned by `shellcheck` |
