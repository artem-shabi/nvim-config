require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "<C-s>", "<ESC><cmd>w<cr>", { desc = "Save and normal mode" })

-- Session manager
map("n", "<leader>ss", function() require("persistence").load() end, { desc = "Session restore (cwd)" })
map("n", "<leader>sl", function() require("persistence").load({ last = true }) end, { desc = "Session restore last" })
map("n", "<leader>sd", function() require("persistence").stop() end, { desc = "Session stop (don't save)" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Move lines up/down
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })
