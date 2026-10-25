{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.types) mkDiagnosticsPresetEnableOption;

  cfg = config.vim.diagnostics.presets.buf_lint;
in {
  options.vim.diagnostics.presets.buf_lint = {
    enable = mkDiagnosticsPresetEnableOption {
      option = "buf_lint";
      display = "Buf";
    };
  };

  config = mkIf cfg.enable {
    vim.diagnostics.nvim-lint.linters.buf_lint = {
      cmd = "buf";
    };
  };
}
