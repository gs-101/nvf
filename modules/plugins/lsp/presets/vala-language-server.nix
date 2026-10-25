{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.types) mkLspPresetEnableOption;

  cfg = config.vim.lsp.presets.vala-language-server;
in {
  options.vim.lsp.presets.vala-language-server = {
    enable = mkLspPresetEnableOption {
      option = "vala-language-server";
      display = "Vala";
    };
  };

  config = mkIf cfg.enable {
    vim.lsp.servers.vala-language-server = {
      enable = true;
      cmd = ["vala-language-server"];
      root_markers = [".git"];
    };
  };
}
