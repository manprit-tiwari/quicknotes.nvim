local M = {}

M.setup = function(opts)
  -- Allow user overrides, fallback to defaults
  opts = opts or {}

  -- Resolve base directory for notes (supports DEV_HOME or HOME)
  local base_dir = opts.dir
    or vim.fn.getenv("DEV_HOME")
    or vim.fn.expand("$HOME")

  -- The folder and file where notes will be stored
  local notes_dir = base_dir .. "/Notes"
  local notes_file = notes_dir .. "/quick_note.md"

  -- Create the notes directory if missing
  vim.fn.mkdir(notes_dir, "p")

  -- Make sure today's date header exists in the note file
  local function ensure_today_header()
    local today = os.date("## %Y-%m-%d")
    local lines = vim.fn.filereadable(notes_file) == 1 and vim.fn.readfile(notes_file) or {}

    -- If today's header already exists, no need to add
    for _, line in ipairs(lines) do
      if line == today then return end
    end

    -- Append today's header
    table.insert(lines, "")
    table.insert(lines, today)
    table.insert(lines, "")
    vim.fn.writefile(lines, notes_file)
  end

  -- Open the quick notes floating window
  local function open()
    ensure_today_header()

    -- Create a temporary scratch buffer
    local buf = vim.api.nvim_create_buf(false, true)

    -- Window size (80% of screen)
    local width  = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local row    = math.floor((vim.o.lines - height) / 2)
    local col    = math.floor((vim.o.columns - width) / 2)

    -- Open centered floating window
    vim.api.nvim_open_win(buf, true, {
      relative = "editor",
      width = width,
      height = height,
      row = row,
      col = col,
      border = "rounded",
      style = "minimal",
    })

    -- Open the notes file inside the window and jump to today's header
    vim.cmd("edit " .. notes_file)
    vim.cmd("/" .. os.date("## %Y-%m-%d"))

    -- Autosave when leaving the window
    vim.api.nvim_create_autocmd("BufLeave", {
      buffer = buf,
      callback = function() vim.cmd("silent write") end,
    })

    -- Close notes window with q or Esc (just like help buffers)
    vim.keymap.set("n", "<Esc>", vim.cmd.close, { buffer = buf })
    vim.keymap.set("n", "q", vim.cmd.close, { buffer = buf })
  end

  -- Keybinding to open quick notes
  vim.keymap.set("n", "<leader>qn", open, { desc = "Open Quick Notes" })
end

return M
