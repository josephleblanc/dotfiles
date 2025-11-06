# dotfiles
nvim ftw

## How To

1. clone locally (with submodules)
```bash
git clone --recurse-submodules git@github.com:josephleblanc/dotfiles.git
# or, if I forget:
cd dotfiles
git submodule update --init --recursive
```

2. Pull latest from e.g. `nvim` to `dotfiles` (this repo):

```bash
cd /path/to/dotfiles
git subtree pull --prefix nvim git@github.com:josephleblanc/nvim.git main --squash
git push
```

3. Push edits made inside e.g. dotfiles/nvim back to the standalone repo
```bash
cd /path/to/dotfiles
git subtree push --prefix nvim git@github.com:josephleblanc/nvim.git main
```
