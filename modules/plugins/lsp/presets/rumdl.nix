{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.types) mkLspPresetEnableOption;

  cfg = config.vim.lsp.presets.rumdl;
in {
  options.vim.lsp.presets.rumdl = {
    enable = mkLspPresetEnableOption {
      option = "rumdl";
      display = "Rumdl";
    };
  };

  config = mkIf cfg.enable {
    vim.lsp.servers.rumdl = {
      enable = true;
      cmd = ["rumdl" "server"];
      root_markers = [".git" ".rumdl.toml" "rumdl.toml" ".config/rumdl.toml" "pyproject.toml"];
    };
  };
}
