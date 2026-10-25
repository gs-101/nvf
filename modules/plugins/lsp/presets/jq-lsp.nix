{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.types) mkLspPresetEnableOption;

  cfg = config.vim.lsp.presets.jq-lsp;
in {
  options.vim.lsp.presets.jq-lsp = {
    enable = mkLspPresetEnableOption {
      option = "jq-lsp";
      display = "JQ";
    };
  };

  config = mkIf cfg.enable {
    vim.lsp.servers.jq-lsp = {
      enable = true;
      cmd = ["jq-lsp"];
      root_markers = [".git"];
    };
  };
}
