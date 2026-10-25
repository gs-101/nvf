{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.types) mkDapPresetEnableOption;

  cfg = config.vim.debugger.nvim-dap.presets.xdebug;
in {
  options.vim.debugger.nvim-dap.presets.xdebug = {
    enable = mkDapPresetEnableOption {
      option = "xdebug";
      display = "Xdebug";
    };
  };

  config.vim.debugger.nvim-dap.adapters = mkIf cfg.enable {
    xdebug = {
      type = "executable";
      command = "php-debug-adapter";
    };
  };
}
