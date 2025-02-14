-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', { 'nvim-0.5' }) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()
  _G._packer = _G._packer or {}
  _G._packer.inside_compile = true

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end

  local function save_profiles(threshold)
    local sorted_times = {}
    for chunk_name, time_taken in pairs(profile_info) do
      sorted_times[#sorted_times + 1] = { chunk_name, time_taken }
    end
    table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
    local results = {}
    for i, elem in ipairs(sorted_times) do
      if not threshold or threshold and elem[2] > threshold then
        results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
      end
    end
    if threshold then
      table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
    end

    _G._packer.profile_output = results
  end

  time([[Luarocks path setup]], true)
  local package_path_str =
  "/home/ente/.cache/nvim/packer_hererocks/2.1.1723675123/share/lua/5.1/?.lua;/home/ente/.cache/nvim/packer_hererocks/2.1.1723675123/share/lua/5.1/?/init.lua;/home/ente/.cache/nvim/packer_hererocks/2.1.1723675123/lib/luarocks/rocks-5.1/?.lua;/home/ente/.cache/nvim/packer_hererocks/2.1.1723675123/lib/luarocks/rocks-5.1/?/init.lua"
  local install_cpath_pattern = "/home/ente/.cache/nvim/packer_hererocks/2.1.1723675123/lib/lua/5.1/?.so"
  if not string.find(package.path, package_path_str, 1, true) then
    package.path = package.path .. ';' .. package_path_str
  end

  if not string.find(package.cpath, install_cpath_pattern, 1, true) then
    package.cpath = package.cpath .. ';' .. install_cpath_pattern
  end

  time([[Luarocks path setup]], false)
  time([[try_loadstring definition]], true)
  local function try_loadstring(s, component, name)
    local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
    if not success then
      vim.schedule(function()
        vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result,
          vim.log.levels.ERROR, {})
      end)
    end
    return result
  end

  time([[try_loadstring definition]], false)
  time([[Defining packer_plugins]], true)
  _G.packer_plugins = {
    ["Comment.nvim"] = {
      config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0" },
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/Comment.nvim",
      url = "https://github.com/numToStr/Comment.nvim"
    },
    LuaSnip = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/LuaSnip",
      url = "https://github.com/L3MON4D3/LuaSnip"
    },
    ["Navigator.nvim"] = {
      config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14Navigator\frequire\0" },
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/Navigator.nvim",
      url = "https://github.com/numToStr/Navigator.nvim"
    },
    catppuccin = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/catppuccin",
      url = "https://github.com/catppuccin/nvim"
    },
    ["cmp-buffer"] = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/cmp-buffer",
      url = "https://github.com/hrsh7th/cmp-buffer"
    },
    ["cmp-nvim-lsp"] = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
      url = "https://github.com/hrsh7th/cmp-nvim-lsp"
    },
    ["cmp-nvim-lua"] = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
      url = "https://github.com/hrsh7th/cmp-nvim-lua"
    },
    ["cmp-path"] = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/cmp-path",
      url = "https://github.com/hrsh7th/cmp-path"
    },
    cmp_luasnip = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
      url = "https://github.com/saadparwaiz1/cmp_luasnip"
    },
    ["copilot.vim"] = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/copilot.vim",
      url = "https://github.com/github/copilot.vim"
    },
    ["dap-buddy.nvim"] = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/dap-buddy.nvim",
      url = "https://github.com/pocco81/dap-buddy.nvim"
    },
    ["dressing.nvim"] = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/dressing.nvim",
      url = "https://github.com/stevearc/dressing.nvim"
    },
    ["flutter-tools.nvim"] = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/flutter-tools.nvim",
      url = "https://github.com/akinsho/flutter-tools.nvim"
    },
    ["formatter.nvim"] = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/formatter.nvim",
      url = "https://github.com/mhartington/formatter.nvim"
    },
    ["friendly-snippets"] = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/friendly-snippets",
      url = "https://github.com/rafamadriz/friendly-snippets"
    },
    harpoon = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/harpoon",
      url = "https://github.com/ThePrimeagen/harpoon"
    },
    ["lsp-zero.nvim"] = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/lsp-zero.nvim",
      url = "https://github.com/VonHeikemen/lsp-zero.nvim"
    },
    ["magma-nvim"] = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/magma-nvim",
      url = "https://github.com/dccsillag/magma-nvim"
    },
    ["mason-lspconfig.nvim"] = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
      url = "https://github.com/williamboman/mason-lspconfig.nvim"
    },
    ["mason.nvim"] = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/mason.nvim",
      url = "https://github.com/williamboman/mason.nvim"
    },
    ["nvim-cmp"] = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/nvim-cmp",
      url = "https://github.com/hrsh7th/nvim-cmp"
    },
    ["nvim-dap"] = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/nvim-dap",
      url = "https://github.com/mfussenegger/nvim-dap"
    },
    ["nvim-dap-ui"] = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/nvim-dap-ui",
      url = "https://github.com/rcarriga/nvim-dap-ui"
    },
    ["nvim-dap-virtual-text"] = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/nvim-dap-virtual-text",
      url = "https://github.com/theHamsta/nvim-dap-virtual-text"
    },
    ["nvim-lspconfig"] = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
      url = "https://github.com/neovim/nvim-lspconfig"
    },
    ["nvim-treesitter"] = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
      url = "https://github.com/nvim-treesitter/nvim-treesitter"
    },
    ["packer.nvim"] = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/packer.nvim",
      url = "https://github.com/wbthomason/packer.nvim"
    },
    playground = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/playground",
      url = "https://github.com/nvim-treesitter/playground"
    },
    ["plenary.nvim"] = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/plenary.nvim",
      url = "https://github.com/nvim-lua/plenary.nvim"
    },
    ["rose-pine"] = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/rose-pine",
      url = "https://github.com/rose-pine/neovim"
    },
    ["tailwindcss-colors.nvim"] = {
      config = {
        "\27LJ\2\n@\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\23tailwindcss-colors\frequire\0" },
      loaded = false,
      needs_bufread = false,
      only_cond = false,
      path = "/home/ente/.local/share/nvim/site/pack/packer/opt/tailwindcss-colors.nvim",
      url = "https://github.com/themaxmarchuk/tailwindcss-colors.nvim"
    },
    ["telescope-dap.nvim"] = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/telescope-dap.nvim",
      url = "https://github.com/nvim-telescope/telescope-dap.nvim"
    },
    ["telescope.nvim"] = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/telescope.nvim",
      url = "https://github.com/nvim-telescope/telescope.nvim"
    },
    ["typst.vim"] = {
      loaded = false,
      needs_bufread = true,
      only_cond = false,
      path = "/home/ente/.local/share/nvim/site/pack/packer/opt/typst.vim",
      url = "https://github.com/kaarmu/typst.vim"
    },
    undotree = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/undotree",
      url = "https://github.com/mbbill/undotree"
    },
    ["vim-fugitive"] = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/vim-fugitive",
      url = "https://github.com/tpope/vim-fugitive"
    },
    ["vim-sleuth"] = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/vim-sleuth",
      url = "https://github.com/tpope/vim-sleuth"
    },
    ["vim-tmux-navigator"] = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/vim-tmux-navigator",
      url = "https://github.com/christoomey/vim-tmux-navigator"
    },
    vimtex = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/vimtex",
      url = "https://github.com/lervag/vimtex"
    },
    ["zen-mode.nvim"] = {
      loaded = true,
      path = "/home/ente/.local/share/nvim/site/pack/packer/start/zen-mode.nvim",
      url = "https://github.com/folke/zen-mode.nvim"
    }
  }

  time([[Defining packer_plugins]], false)
  local module_lazy_loads = {
    ["^tailwindcss%-colors"] = "tailwindcss-colors.nvim"
  }
  local lazy_load_called = { ['packer.load'] = true }
  local function lazy_load_module(module_name)
    local to_load = {}
    if lazy_load_called[module_name] then return nil end
    lazy_load_called[module_name] = true
    for module_pat, plugin_name in pairs(module_lazy_loads) do
      if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
        to_load[#to_load + 1] = plugin_name
      end
    end

    if #to_load > 0 then
      require('packer.load')(to_load, { module = module_name }, _G.packer_plugins)
      local loaded_mod = package.loaded[module_name]
      if loaded_mod then
        return function(modname) return loaded_mod end
      end
    end
  end

  if not vim.g.packer_custom_loader_enabled then
    table.insert(package.loaders, 1, lazy_load_module)
    vim.g.packer_custom_loader_enabled = true
  end

  -- Config for: Comment.nvim
  time([[Config for Comment.nvim]], true)
  try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0",
    "config", "Comment.nvim")
  time([[Config for Comment.nvim]], false)
  -- Config for: Navigator.nvim
  time([[Config for Navigator.nvim]], true)
  try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14Navigator\frequire\0",
    "config", "Navigator.nvim")
  time([[Config for Navigator.nvim]], false)
  vim.cmd [[augroup packer_load_aucmds]]
  vim.cmd [[au!]]
  -- Filetype lazy-loads
  time([[Defining lazy-load filetype autocommands]], true)
  vim.cmd [[au FileType typst ++once lua require("packer.load")({'typst.vim'}, { ft = "typst" }, _G.packer_plugins)]]
  time([[Defining lazy-load filetype autocommands]], false)
  vim.cmd("augroup END")
  vim.cmd [[augroup filetypedetect]]
  time([[Sourcing ftdetect script at: /home/ente/.local/share/nvim/site/pack/packer/opt/typst.vim/ftdetect/typst.vim]],
    true)
  vim.cmd [[source /home/ente/.local/share/nvim/site/pack/packer/opt/typst.vim/ftdetect/typst.vim]]
  time([[Sourcing ftdetect script at: /home/ente/.local/share/nvim/site/pack/packer/opt/typst.vim/ftdetect/typst.vim]],
    false)
  vim.cmd("augroup END")

  _G._packer.inside_compile = false
  if _G._packer.needs_bufread == true then
    vim.cmd("doautocmd BufRead")
  end
  _G._packer.needs_bufread = false

  if should_profile then save_profiles() end
end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: ' ..
  error_msg .. '" | echom "Please check your config for correctness" | echohl None')
end
