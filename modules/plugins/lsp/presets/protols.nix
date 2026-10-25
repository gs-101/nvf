{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.types) mkLspPresetEnableOption;

  cfg = config.vim.lsp.presets.protols;
in {
  options.vim.lsp.presets.protols = {
    enable = mkLspPresetEnableOption {
      option = "protols";
      display = "Protols";
    };
  };

  config = mkIf cfg.enable {
    vim.lsp.servers.protols = {
      enable = true;
      cmd = ["protols" "--stdio"];
      root_markers = ["protols.toml" ".git"];
    };
  };
}
