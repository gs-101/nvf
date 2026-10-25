{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.types) mkLspPresetEnableOption;

  cfg = config.vim.lsp.presets.awk-language-server;
in {
  options.vim.lsp.presets.awk-language-server = {
    enable = mkLspPresetEnableOption {
      option = "awk-language-server";
      display = "AWK";
    };
  };

  config = mkIf cfg.enable {
    vim.lsp.servers.awk-language-server = {
      enable = true;
      cmd = ["awk-language-server"];
      root_markers = [".git"];
    };
  };
}
