# Managing inputs with tack

The flake inputs are pinned with [tack](https://github.com/manic-systems/tack), not with the flake's
`inputs` block. Everything lives in `.tack/`, and all of it is committed:

| File | Role |
|---|---|
| `pins.toml` | the inputs: url, `follows`, comments. Edit by hand or with `tack add` / `tack rm` |
| `pins.lock.json` | the locked revs, in place of `flake.lock` |
| `default.nix` | the resolver `flake.nix` imports. Plain Nix, so building needs no `tack` |
| `.gitignore` | ignores the per-machine `patched*` links tack makes for pins with patches |

`tack` itself is installed by `modules/common/nixos/tack.nix` from its own pin, because nixpkgs ships
tack 1.0.1, which can't read the 2.0 lock.

## GitHub token

`look`, `update` and `add` resolve `github:` pins through the GitHub API, at one to three requests a pin.
Without a token GitHub allows 60 requests an hour, which a single `update` plus a `look` can use up.
Pass one:

```sh
export GH_TOKEN=$(gh auth token)
```

## Everyday commands

```sh
tack look                    # which pins have new commits (ahead/behind)
tack look -v                 # with the new commits listed
tack look -v home-manager    # one pin
tack tree                    # each pin's own inputs and what they follow (no network)

tack update                       # relock every pin, like `nix flake update`
tack update nixpkgs home-manager  # only these
tack update --exclude=nixpkgs     # all but nixpkgs

tack undo                    # revert the last tack edit (update, add, rm, ...)
tack undo --list             # show the history
tack redo
```

A typical update:

```sh
tack look -v
tack update
nh os test
git add .tack && git commit -m "feat(flake): update"
```

After a `tack undo`, rebuild so the system matches the lock again. `nh os test --update` runs
`nix flake update`, which does nothing here; use `tack update` instead.

## Holding a pin back

```sh
tack freeze nixpkgs      # `tack update` skips it...
tack update nixpkgs      # ...unless it is named
tack unfreeze nixpkgs
```

## Adding and removing pins

```sh
tack add foo github:owner/foo --follows nixpkgs   # inputs.foo.inputs.nixpkgs.follows = "nixpkgs"
tack add bar github:owner/bar --fetch             # flake = false
tack rm foo
```

`pins.toml` documents every field (`follows`, `tag`, `patches`, `dir`, ...) in its header comment.

## Building a local checkout

`--override-input` doesn't apply. Point the pin at the checkout in `pins.toml` and relock it:

```toml
[inputs.unda]
url = "git+file:///home/hiepnh/Projects/unda"
```

```sh
tack update unda
```

Write `git+file:///` with three slashes. tack 2.0.0 reads `git+file:/home/...` as an scp-style SSH url
with host `file` and fails with `Could not resolve hostname file`, although Nix accepts that spelling.
