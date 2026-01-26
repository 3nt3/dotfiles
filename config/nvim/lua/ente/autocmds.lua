-- Autocommands Configuration

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- General autocommands group
local general = augroup("General", { clear = true })

-- Highlight on yank
autocmd("TextYankPost", {
    group = augroup("HighlightYank", { clear = true }),
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 150,
        })
    end,
    desc = "Highlight yanked text",
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
    group = general,
    pattern = "*",
    command = [[%s/\s\+$//e]],
    desc = "Remove trailing whitespace",
})

-- Close certain filetypes with 'q'
autocmd("FileType", {
    group = general,
    pattern = {
        "qf",
        "help",
        "man",
        "notify",
        "lspinfo",
        "startuptime",
        "checkhealth",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
    desc = "Close with q",
})

-- Auto-resize splits when window is resized
autocmd("VimResized", {
    group = general,
    pattern = "*",
    command = "tabdo wincmd =",
    desc = "Auto-resize splits",
})

-- Check if file changed outside of Vim
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = general,
    command = "checktime",
    desc = "Check for file changes",
})

-- Go to last location when opening a buffer
autocmd("BufReadPost", {
    group = general,
    callback = function(event)
        local exclude = { "gitcommit" }
        local buf = event.buf
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
            return
        end
        vim.b[buf].lazyvim_last_loc = true
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
    desc = "Go to last location",
})

-- Disable autocomment on new line
autocmd("BufEnter", {
    group = general,
    pattern = "*",
    callback = function()
        vim.opt.formatoptions:remove({ "c", "r", "o" })
    end,
    desc = "Disable autocomment",
})

-- Function to reload modules (useful for development)
function _G.R(name)
    require("plenary.reload").reload_module(name)
end
