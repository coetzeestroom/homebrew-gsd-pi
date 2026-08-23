# homebrew-gsd-pi

Homebrew tap for [GSD Pi](https://github.com/open-gsd/gsd-pi) - a local-first coding agent for planning, implementing, and verifying project work from your terminal.

## Installation

```bash
brew tap raymondcoetzee/gsd-pi
brew install gsd-pi
```

Or in one line:

```bash
brew install raymondcoetzee/gsd-pi/gsd-pi
```

## Updating

```bash
brew update && brew upgrade gsd-pi
```

## About GSD Pi

GSD Pi is a command-line coding agent that plans, implements, verifies, and ships software autonomously — from idea to pull request.

- **Multi-provider model routing** — Works with OpenAI, Anthropic, Google, and local models
- **External CLI providers** — Integrates with Claude Code, Cursor Agent, and other CLI tools
- **Extension surface** — Add project-specific commands, tools, skills, and UI integrations
- **Terminal and web surfaces** — Use the TUI by default, or launch `gsd --web` for a visual control plane

Learn more at [opengsd.net](https://www.opengsd.net/) and [GitHub](https://github.com/open-gsd/gsd-pi).

## Formula Details

This formula installs the `@opengsd/gsd-pi` npm package (currently v1.14.0) globally via npm, which provides the `gsd` binary.

The formula:
- Downloads the npm package tarball from the npm registry
- Verifies the SHA256 checksum
- Installs dependencies via npm
- Symlinks the `gsd` binary to Homebrew's `bin` directory

## Manual Upgrade Process

To update the formula when a new version is released:

1. Check the latest version: `npm view @opengsd/gsd-pi version`
2. Get the tarball URL: `npm view @opengsd/gsd-pi dist.tarball`
3. Compute SHA256: `curl -sL <tarball_url> | sha256sum`
4. Update `Formula/gsd-pi.rb` with the new version, URL, and SHA256
5. Test locally: `brew install --build-from-source Formula/gsd-pi.rb`
6. Commit and push

## License

MIT License - see the [upstream license](https://github.com/open-gsd/gsd-pi/blob/main/LICENSE) for details.# homebrew-gsd-pi
