{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.types) mkFormatterPresetEnableOption;

  cfg = config.vim.formatter.conform-nvim.presets.gawk;
in {
  options.vim.formatter.conform-nvim.presets.gawk = {
    enable = mkFormatterPresetEnableOption {
      option = "gawk";
      display = "GNU AWK";
    };
  };

  config = mkIf cfg.enable {
    vim.formatter.conform-nvim.setupOpts.formatters.gawk = {
      command = "gawk";
      args = ["-f" "-" "-o-"];
    };
  };
}
