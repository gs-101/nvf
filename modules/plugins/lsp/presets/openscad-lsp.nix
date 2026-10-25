{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.types) mkLspPresetEnableOption;

  cfg = config.vim.lsp.presets.openscad-lsp;
in {
  options.vim.lsp.presets.openscad-lsp = {
    enable = mkLspPresetEnableOption {
      option = "openscad-lsp";
      display = "Open SCAD";
    };
  };

  config = mkIf cfg.enable {
    vim.lsp.servers.openscad-lsp = {
      enable = true;
      cmd = ["openscad-lsp" "--stdio"];
      root_markers = [".git"];
    };
  };
}
