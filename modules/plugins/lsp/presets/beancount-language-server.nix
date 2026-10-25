{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.types) mkLspPresetEnableOption;

  cfg = config.vim.lsp.presets.beancount-language-server;
in {
  options.vim.lsp.presets.beancount-language-server = {
    enable = mkLspPresetEnableOption {
      option = "beancount-language-server";
      display = "Beancount";
    };
  };

  config = mkIf cfg.enable {
    vim.lsp.servers.beancount-language-server = {
      enable = true;
      root_markers = [".git"];
      cmd = ["beancount-language-server"];
    };
  };
}
