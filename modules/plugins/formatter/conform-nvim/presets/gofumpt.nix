{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.types) mkFormatterPresetEnableOption;

  cfg = config.vim.formatter.conform-nvim.presets.gofumpt;
in {
  options.vim.formatter.conform-nvim.presets.gofumpt = {
    enable = mkFormatterPresetEnableOption {
      option = "gofumpt";
      display = "`gofumpt`";
    };
  };

  config = mkIf cfg.enable {
    vim.formatter.conform-nvim.setupOpts.formatters.gofumpt = {
      command = "gofumpt";
    };
  };
}
