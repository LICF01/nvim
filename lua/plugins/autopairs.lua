return {
	{

		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {
			check_ts = true,
			ts_config = {
				javascript = { "template_string", "string" },
			},
		},
	},
}
