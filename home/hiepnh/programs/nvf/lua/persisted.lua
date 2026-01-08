require("persisted").setup({
	autostart = true,
	should_save = function()
		local ft = vim.bo.filetype
		local bt = vim.bo.buftype

		if ft == "dashboard" then
			return false
		end

		if ft == "" and bt == "" then
			return false
		end

		return true
	end,
	vim.keymap.set("n", "ZZ", function()
		require("persisted").save()
		vim.cmd("wa")
		vim.cmd("qa")
	end, { noremap = true, silent = true, desc = "Save session and quit" }),

	vim.keymap.set("n", "ZQ", function()
		require("persisted").save()
		vim.cmd("qa!")
	end, { noremap = true, silent = true, desc = "Save session and quit without write" }),
})
