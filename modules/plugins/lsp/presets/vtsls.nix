{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.types) mkLspPresetEnableOption;

  cfg = config.vim.lsp.presets.vtsls;
in {
  options.vim.lsp.presets.vtsls = {
    enable = mkLspPresetEnableOption {
      option = "vtsls";
      display = "Vue.js Typescript";
    };
  };

  config = mkIf cfg.enable {
    vim.lsp.servers.vtsls = {
      enable = true;
      cmd = ["vtsls" "--stdio"];
      root_markers = [".git" "tsconfig.json" "package.json"];
      settings = {
        vtsls = {
          tsserver.globalPlugins = [
            {
              name = "@vue/typescript-plugin";
              languages = ["vue"];
              configNamespace = "typescript";
            }
          ];
        };
      };
      capabilities.semanticTokensProvider = false;
    };
  };
}
