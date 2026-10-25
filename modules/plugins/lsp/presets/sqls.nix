{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.types) mkLspPresetEnableOption;

  cfg = config.vim.lsp.presets.sqls;
in {
  options.vim.lsp.presets.sqls = {
    enable = mkLspPresetEnableOption {
      option = "sqls";
      display = "SQL";
    };
  };

  config = mkIf cfg.enable {
    vim.lsp.servers.sqls = {
      enable = true;
      cmd = ["sqls"];
      root_markers = ["config.yml"];
    };
  };
}
