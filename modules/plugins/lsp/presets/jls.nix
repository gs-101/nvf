{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.types) mkLspPresetEnableOption;

  cfg = config.vim.lsp.presets.jls;
in {
  options.vim.lsp.presets.jls = {
    enable = mkLspPresetEnableOption {
      option = "jls";
      display = "Java (jls)";
    };
  };

  config = mkIf cfg.enable {
    vim.lsp.servers.jls = {
      enable = true;
      cmd = ["jls"];
      root_markers = [
        ".git"
        ".java-version"
        "pom.xml"
        "build.gradle"
        "settings.gradle"
        "settings.gradle.kts"
      ];
    };
  };
}
