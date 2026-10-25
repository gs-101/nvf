{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.types) mkLspPresetEnableOption;

  cfg = config.vim.lsp.presets.phpantom;
in {
  options.vim.lsp.presets.phpantom = {
    enable = mkLspPresetEnableOption {
      option = "phpantom";
      display = "PHPantom";
    };
  };

  config = mkIf cfg.enable {
    vim.lsp.servers.phpantom = {
      enable = true;
      cmd = ["phpantom-lsp"];
      root_markers = [".phpantom.toml" "composer.json" ".php-version" ".git"];
    };
  };
}
