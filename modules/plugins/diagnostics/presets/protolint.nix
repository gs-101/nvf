{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.types) mkDiagnosticsPresetEnableOption;

  cfg = config.vim.diagnostics.presets.protolint;
in {
  options.vim.diagnostics.presets.protolint = {
    enable = mkDiagnosticsPresetEnableOption {
      option = "protolint";
      display = "`protolint`";
    };
  };

  config = mkIf cfg.enable {
    vim.diagnostics.nvim-lint.linters.protolint = {
      cmd = "protolint";
    };
  };
}
