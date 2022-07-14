-- overriding default plugin configs!

local M = {}

M.treesitter = {
   ensure_installed = {
      "vim",
      "html",
      "css",
      "javascript",
      "json",
      "markdown",
      "c",
	  "cpp",
      "bash",
      "lua",
	  "julia",
	  "latex",
   },
   highlight = {
	   enable = true
   }
}

M.nvimtree = {
   git = {
      enable = true,
   },
}

M.telescope = {
   extensions = {
      -- fd is needed
      media_files = {
         filetypes = { "png", "webp", "jpg", "jpeg" },
      },
   },
}



return M
