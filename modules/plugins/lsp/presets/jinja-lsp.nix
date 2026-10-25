{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.types) mkLspPresetEnableOption;

  cfg = config.vim.lsp.presets.jinja-lsp;
in {
  options.vim.lsp.presets.jinja-lsp = {
    enable = mkLspPresetEnableOption {
      option = "jinja-lsp";
      display = "Jinja";
    };
  };

  config = mkIf cfg.enable {
    vim.lsp.servers.jinja-lsp = {
      enable = true;
      cmd = ["jinja-lsp"];
      root_markers = [".git"];
    };
  };
}
