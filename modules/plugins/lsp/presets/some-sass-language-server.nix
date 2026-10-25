{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.types) mkLspPresetEnableOption;

  cfg = config.vim.lsp.presets.some-sass-language-server;
in {
  options.vim.lsp.presets.some-sass-language-server = {
    enable = mkLspPresetEnableOption {
      option = "some-sass-language-server";
      display = "Some Sass";
    };
  };

  config = mkIf cfg.enable {
    vim.lsp.servers.some-sass-language-server = {
      enable = true;
      cmd = ["some-sass-language-server" "--stdio"];
      root_markers = [".git" "package.json"];
      # <https://wkillerud.github.io/some-sass/language-server/settings.html>
      settings = {
        somesass = {
          scss.completion.suggestFromUseOnly = true;
          sass.completion.suggestFromUseOnly = true;
        };
      };
    };
  };
}
