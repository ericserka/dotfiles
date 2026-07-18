vim.api.nvim_set_keymap('n', '<leader>gs', ":Git <CR><C-w>10-", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gl', ":Git log <CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gb', ":Git blame <CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ph', ":Git push <CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'dh', ":diffget //2<CR>", { noremap = true }) -- Gets left diff on Merge conflict
vim.api.nvim_set_keymap('n', 'dl', ":diffget //3<CR>", { noremap = true }) -- Gets rigth diff on Merge conflict
vim.api.nvim_set_keymap('n', '<leader>gx', ":Git restore .<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>pl', ":Git pull<CR>", { noremap = true, silent = true })
-- Detect the remote base branch (e.g. "origin/main"). Prefers the remote's advertised
-- default branch (origin/HEAD); falls back to probing origin/main then origin/master.
local function remote_base_branch()
  local head = vim.fn.systemlist("git symbolic-ref --quiet --short refs/remotes/origin/HEAD")[1]
  if vim.v.shell_error == 0 and head and head ~= "" then
    return head
  end
  for _, name in ipairs({ "origin/main", "origin/master" }) do
    vim.fn.system("git show-ref --verify --quiet refs/remotes/" .. name)
    if vim.v.shell_error == 0 then
      return name
    end
  end
  return nil
end

-- Fetch the latest remote base branch so comparisons/merges reflect its current state.
local function fetch_base(base)
  vim.fn.system("git fetch origin " .. (base:gsub("^origin/", "")))
end

-- Close every tab whose handle is in `set` (highest number first so numbering stays valid).
local function close_tabs(set)
  local numbers = {}
  for _, handle in ipairs(vim.api.nvim_list_tabpages()) do
    if set[handle] then
      table.insert(numbers, vim.api.nvim_tabpage_get_number(handle))
    end
  end
  table.sort(numbers, function(a, b) return a > b end)
  for _, n in ipairs(numbers) do
    if #vim.api.nvim_list_tabpages() > 1 then -- never close the last remaining tab
      pcall(vim.cmd, n .. "tabclose")
    end
  end
end

-- [ D ]iff: GitHub-style "files changed" — every file changed on this branch vs the
-- (freshly fetched) remote base branch, each in its own diff-split tab. Every other tab
-- (work tabs included) is closed so nothing but the changed files stays in focus.
vim.api.nvim_set_keymap('n', '<leader>gd', "", {
  noremap = true,
  silent = true,
  callback = function()
    local base = remote_base_branch()
    if not base then
      vim.notify("Could not detect a remote base branch (origin/main or origin/master).", vim.log.levels.ERROR)
      return
    end
    fetch_base(base)
    -- Snapshot the tabs open before the diff so we can close them afterwards.
    local before = {}
    for _, handle in ipairs(vim.api.nvim_list_tabpages()) do
      before[handle] = true
    end
    vim.cmd("Git difftool -y " .. base .. "...HEAD")
    -- If difftool opened nothing (no changed files), leave the workspace untouched.
    local opened_new = false
    for _, handle in ipairs(vim.api.nvim_list_tabpages()) do
      if not before[handle] then
        opened_new = true
        break
      end
    end
    if not opened_new then
      vim.notify("No changed files against " .. base .. ".", vim.log.levels.INFO)
      return
    end
    close_tabs(before)
    vim.cmd("tabfirst")
  end,
})

-- [ U ]pdate branch: like GitHub's "Update branch" button — fetch the remote base and
-- merge it into the current branch (conflicts land in the working tree; resolve with dh/dl).
vim.api.nvim_set_keymap('n', '<leader>gu', "", {
  noremap = true,
  silent = true,
  callback = function()
    local base = remote_base_branch()
    if not base then
      vim.notify("Could not detect a remote base branch (origin/main or origin/master).", vim.log.levels.ERROR)
      return
    end
    fetch_base(base)
    vim.cmd("Git merge " .. base)
  end,
})
