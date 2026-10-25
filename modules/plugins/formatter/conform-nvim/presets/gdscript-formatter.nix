{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.types) mkFormatterPresetEnableOption;

  cfg = config.vim.formatter.conform-nvim.presets.gdscript-formatter;
in {
  options.vim.formatter.conform-nvim.presets.gdscript-formatter = {
    enable = mkFormatterPresetEnableOption {
      option = "gdscript-formatter";
      display = "GDScript Formatter";
    };
  };

  config = mkIf cfg.enable {
    vim.formatter.conform-nvim.setupOpts.formatters.gdscript-formatter = {
      command = "gdscript-formatter";
    };
  };
}
