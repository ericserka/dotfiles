-- Marksman crashes fatally when it attaches to virtual (non-on-disk) markdown
-- buffers such as gitsigns' staged/index previews, whose names look like
-- "<repo>/.git/0/<path>". On buffer close marksman re-reads the file from that
-- fake path, fails, and takes the whole server down ("quit with exit code 1").
--
-- Guard the attach: only give marksman a root_dir (and thus let it attach) for
-- real, on-disk markdown files. Skipping on_dir for anything else prevents the
-- attach entirely.
return {
  root_dir = function(bufnr, on_dir)
    local name = vim.api.nvim_buf_get_name(bufnr)

    -- Only normal file buffers; skip nofile/acwrite/terminal buffers.
    if vim.bo[bufnr].buftype ~= "" then
      return
    end

    -- Skip gitsigns/fugitive virtual buffers backed by the git index.
    if name == "" or name:find("/%.git/") then
      return
    end

    -- Preserve marksman's default root detection.
    local root = vim.fs.root(bufnr, { ".marksman.toml", ".git" })
        or vim.fs.dirname(name)
    on_dir(root)
  end,
}
