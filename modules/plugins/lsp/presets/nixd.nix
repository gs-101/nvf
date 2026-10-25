{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.types) mkLspPresetEnableOption;

  cfg = config.vim.lsp.presets.nixd;
in {
  options.vim.lsp.presets.nixd = {
    enable = mkLspPresetEnableOption {
      option = "nixd";
      display = "`nixd`";
    };
  };

  config = mkIf cfg.enable {
    vim.lsp.servers.nixd = {
      enable = true;
      cmd = ["nixd"];
      root_markers = [".git"];
    };
  };
}
