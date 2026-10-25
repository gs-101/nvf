{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.types) mkLspPresetEnableOption;

  cfg = config.vim.lsp.presets.gleam;
in {
  options.vim.lsp.presets.gleam = {
    enable = mkLspPresetEnableOption {
      option = "gleam";
      display = "Gleam";
    };
  };

  config = mkIf cfg.enable {
    vim.lsp.servers.gleam = {
      enable = true;
      cmd = ["gleam" "lsp"];
      root_markers = [".git" "gleam.toml"];
    };
  };
}
