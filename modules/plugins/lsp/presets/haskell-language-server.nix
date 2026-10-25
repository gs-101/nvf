{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.types) mkLspPresetEnableOption;

  cfg = config.vim.lsp.presets.haskell-language-server;
in {
  options.vim.lsp.presets.haskell-language-server = {
    enable = mkLspPresetEnableOption {
      option = "haskell-language-server";
      display = "Haskell";
    };
  };

  config = mkIf cfg.enable {
    vim.lsp.servers.haskell-language-server = {
      enable = true;
      cmd = ["haskell-language-server-wrapper" "--lsp"];
      root_markers = ["hie.yaml" "stack.yaml" "cabal.project" "*.cabal" "package.yaml"];
    };
  };
}
