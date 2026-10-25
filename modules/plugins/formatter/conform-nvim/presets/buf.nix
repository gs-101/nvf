{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.types) mkFormatterPresetEnableOption;

  cfg = config.vim.formatter.conform-nvim.presets.buf;
in {
  options.vim.formatter.conform-nvim.presets.buf = {
    enable = mkFormatterPresetEnableOption {
      option = "buf";
      display = "Buf";
    };
  };

  config = mkIf cfg.enable {
    vim.formatter.conform-nvim.setupOpts.formatters.buf = {
      command = "buf";
    };
  };
}
