## Build instructions

### Preprequisites:

- `python` (version 3.12 or more)
- `uv` ([Installation instructions](https://docs.astral.sh/uv/getting-started/installation/#installation-methods))

### Run your own server

```bash
# create environment, first time only
uv sync

# generate static website, at each modification
uv run pelican

# host static website locally
python3 -m http.server -d output/
```