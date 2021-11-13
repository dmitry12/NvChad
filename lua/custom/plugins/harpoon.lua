local hooks = require "core.hooks"

hooks.add("install_plugins", function(use)
   use {
      "ThePrimeagen/harpoon",
   }
end)

hooks.add("setup_mappings", function(map)
   map("n", "<Leader>1", [[<Cmd>lua require("harpoon.ui").nav_file(1)<CR>]], opt)
   map("n", "<Leader>2", [[<Cmd>lua require("harpoon.ui").nav_file(2)<CR>]], opt)
   map("n", "<Leader>3", [[<Cmd>lua require("harpoon.ui").nav_file(3)<CR>]], opt)
   map("n", "<Leader>4", [[<Cmd>lua require("harpoon.ui").nav_file(4)<CR>]], opt)

   map("n", "<Leader>ha", [[<Cmd>lua require("harpoon.mark").add_file()<CR>]], opt)
   map("n", "<Leader>hl", [[<Cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>]], opt)
end)

