# dotfiles
nvim ftw

## How To

1. Pull latest from `nvim` to `dotfiles` (this repo):

```bash
cd /path/to/dotfiles
git subtree pull --prefix nvim git@github.com:josephleblanc/nvim.git main --squash
git push
```

2. Push edits made inside dotfiles/nvim back to the standalone repo
```bash
cd /path/to/dotfiles
git subtree push --prefix nvim git@github.com:josephleblanc/nvim.git main
```
