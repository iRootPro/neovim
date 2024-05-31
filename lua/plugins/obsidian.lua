return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = false,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>ot", "<cmd>ObsidianToday<cr>",     desc = "Obsidian Today" },
    { "<leader>oy", "<cmd>ObsidianYesterday<cr>", desc = "Obsidian Yesterday" },
    { "<leader>on", "<cmd>ObsidianNew<cr>",       desc = "Obsidian New" },
    { "<leader>os", "<cmd>ObsidianSearch<cr>",    desc = "Obsidian Search" },
    { "<leader>od", "<cmd>ObsidianDailies<cr>",    desc = "Obsidian Dailies" },
  },
  opts = {
    workspaces = {
      {
        name = "Notes",
        path = "~/Documents/iroot-vault/",
      },
    },
    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d-%a",
      time_format = "%H:%M",
    },

    daily_notes = {
      folder = "daily",
      date_format = "%Y-%m-%d",
      alias_format = "%B %-d, %Y",
      template = "daily.md",
    },
  },
  completion = {
    nvim_cmp = true,
    min_chars = 2,
  },
}
