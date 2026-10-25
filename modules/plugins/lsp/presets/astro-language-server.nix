{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.types) mkLspPresetEnableOption;
  inherit (lib.generators) mkLuaInline;

  cfg = config.vim.lsp.presets.astro-language-server;
in {
  options.vim.lsp.presets.astro-language-server = {
    enable = mkLspPresetEnableOption {
      option = "astro-language-server";
      display = "Astro";
    };
  };

  config = mkIf cfg.enable {
    vim.lsp.servers.astro-language-server = {
      enable = true;
      cmd = ["astro-ls" "--stdio"];
      root_markers = [".git" "package.json" "tsconfig.json" "jsconfig.json"];
      init_options.typescript = {};
      before_init = mkLuaInline ''
        function(_, config)
          if config.init_options and config.init_options.typescript and not config.init_options.typescript.tsdk then
            config.init_options.typescript.tsdk = util.get_typescript_server_path(config.root_dir)
          end
        end
      '';
    };
  };
}
