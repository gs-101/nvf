{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.types) mkLspPresetEnableOption;

  cfg = config.vim.lsp.presets.qmlls;
in {
  options.vim.lsp.presets.qmlls = {
    enable = mkLspPresetEnableOption {
      option = "qmlls";
      display = "QML";
    };
  };

  config = mkIf cfg.enable {
    vim.lsp.servers.qmlls = {
      enable = true;
      cmd = ["qmlls"];
      root_markers = [".git"];
    };
  };
}
