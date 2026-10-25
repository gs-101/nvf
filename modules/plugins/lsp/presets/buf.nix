{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.types) mkLspPresetEnableOption;

  cfg = config.vim.lsp.presets.buf;
in {
  options.vim.lsp.presets.buf = {
    enable = mkLspPresetEnableOption {
      option = "buf";
      display = "Buf";
    };
  };

  config = mkIf cfg.enable {
    vim.lsp.servers.buf = {
      enable = true;
      cmd = ["buf" "lsp" "serve" "--log-format=text"];
      root_markers = ["buf.yml" "buf.yaml" ".git"];
    };
  };
}
