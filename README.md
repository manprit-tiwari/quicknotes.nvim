# quicknotes.nvim

A tiny, zero-friction floating quick notes panel for Neovim.

Sometimes you just need to jot down a thought while coding without switching
windows, changing buffers, or losing focus. `quicknotes.nvim` opens your
personal running markdown note in a clean floating window and automatically
keeps daily sections organized.

---

## ✨ Features

- Opens your notes in a centered floating window
- Automatically creates a section for today's date
- Saves your notes automatically when closed
- Close with `q` or `<Esc>` (just like help buffers)
- Simple configuration. Works out of the box.

---

## 📦 Installation

### **lazy.nvim (recommended)**

```lua
{
  "manprit-tech/quicknotes.nvim",
  lazy = false,
  config = function()
    require("quicknotes").setup()
  end,
}
```

### packer

```lua
use({
  "manprit-tech/quicknotes.nvim",
  config = function()
    require("quicknotes").setup()
  end,
})
```

### vim-plug

```lua
Plug "manprit-tech/quicknotes.nvim"
lua require("quicknotes").setup()
```

---

## ⚙️ Configuration (optional)

```lua
require("quicknotes").setup({
  dir = "~/Notes"   -- default: $DEV_HOME or $HOME/Notes
})
```

---

## 🎯 Usage

|        Action       |   Keybinding  |
|:-------------------:|:-------------:|
|   Open Quick Notes  |   \<leader\>qn  |
|   Close Window      |   q or \<Esc\>  |

When opened, the plugin will automatically:

  1. Jump to (or create) today’s date header
  1. Open notes inside a floating window
  1. Save changes when the window is closed

---

## 🗂 Notes Storage

Your notes are saved in:

```txt
~/Notes/quick_note.md
```

Or:

```txt
$DEV_HOME/Notes/quick_note.md
```

if $DEV_HOME is set.

---

## ✅ Future Plans

- Optional daily-per-file mode
- Templates for TIL / meetings / journal entries
- Context capture (file link, selection, repo info)
- Telescope / snacks.nvim integration

---

## 📝 License

MIT License — see LICENSE for details.

---

## 💡 Contributing

PRs, issues, and feature suggestions are welcome!

---
