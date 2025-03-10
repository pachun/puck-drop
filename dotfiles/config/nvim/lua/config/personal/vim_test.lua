local helpers = require("config.personal.helpers")

return {
	setup = function()
		vim.g["test#custom_transformations"] = {
			quote_paths = function(cmd)
				if type(cmd) == "string" then
					return cmd:gsub("(%S+%.test%.ts[x]?)", '"%1"')
				elseif type(cmd) == "table" then
					for i, part in ipairs(cmd) do
						cmd[i] = part:gsub("(%S+%.test%.ts[x]?)", '"%1"')
					end
					return cmd
				end
				return cmd
			end,
		}

		vim.g["test#transformation"] = "quote_paths"

		vim.g["test#custom_strategies"] = {
			send_to_tmux_pane = function(cmd)
				if type(cmd) == "table" then
					helpers.tmux.send_to_pane(table.concat(cmd, " "))
				elseif type(cmd) == "string" then
					helpers.tmux.send_to_pane(cmd)
				else
					print("Error: Unexpected command format: " .. vim.inspect(cmd))
				end
			end,
		}

		vim.g["test#strategy"] = "send_to_tmux_pane"
	end,
}
