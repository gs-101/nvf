{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.types) mkDiagnosticsPresetEnableOption;

  cfg = config.vim.diagnostics.presets.selene;
in {
  options.vim.diagnostics.presets.selene = {
    enable = mkDiagnosticsPresetEnableOption {
      option = "selene";
      display = "Selene";
    };
  };

  config = mkIf cfg.enable {
    vim.diagnostics.nvim-lint.linters.selene.cmd = "selene";
  };
}
