{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.types) mkDapPresetEnableOption;

  cfg = config.vim.debugger.nvim-dap.presets.jls;
in {
  options.vim.debugger.nvim-dap.presets.jls = {
    enable = mkDapPresetEnableOption {
      option = "jls";
      display = "JLS";
    };
  };

  config.vim.debugger.nvim-dap.adapters = mkIf cfg.enable {
    jls = {
      type = "executable";
      command = "jls-dap";
    };
  };
}
