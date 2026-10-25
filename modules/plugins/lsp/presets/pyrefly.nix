{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.types) mkLspPresetEnableOption;

  cfg = config.vim.lsp.presets.pyrefly;
in {
  options.vim.lsp.presets.pyrefly = {
    enable = mkLspPresetEnableOption {
      option = "pyrefly";
      display = "Pyrefly";
    };
  };

  config = mkIf cfg.enable {
    vim.lsp.servers.pyrefly = {
      enable = true;
      cmd = ["pyrefly" "lsp"];
      root_markers = [".git" "pyrefly.toml"];
    };
  };
}
