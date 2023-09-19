vim.cmd([[
set number
set splitright
set tabstop=4
set termguicolors
set relativenumber

inoremap ' ''<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap <C-s> <Esc>:w<CR>i<right>
nnoremap <C-s> :w<CR>
]])

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    'folke/lazy.nvim',
	'williamboman/mason.nvim',
   	'williamboman/mason-lspconfig.nvim',
   	'neovim/nvim-lspconfig',
	'kien/ctrlp.vim',
	'mattn/emmet-vim',
	'ms-jpq/coq_nvim'
})

require('mason').setup()
require('mason-lspconfig').setup()

require('mason-lspconfig').setup_handlers {
-- The first entry (without a key) will be the default handler
-- and will be called for each installed server that doesn't have
-- a dedicated handler.
function (server_name) -- default handler (optional)
    local coq =  require 'coq'
	require('lspconfig')[server_name].setup {coq.lsp_ensure_capabilities()}
end,
-- Next, you can provide a dedicated handler for specific servers.
-- For example, a handler override for the `rust_analyzer`:
--['rust_analyzer'] = function ()
--	require('rust-tools').setup {}
--end
}
vim.cmd("COQnow")
