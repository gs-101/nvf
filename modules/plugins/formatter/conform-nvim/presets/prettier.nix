{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkOption literalMD;
  inherit (lib.nvim.types) mkFormatterPresetEnableOption;
  inherit (lib.types) enum listOf attrsOf str;
  inherit (lib.generators) mkLuaInline;
  inherit (lib.nvim.lua) toLuaObject;
  inherit (lib.attrsets) listToAttrs attrNames;
  inherit (builtins) concatMap map;

  cfg = config.vim.formatter.conform-nvim.presets.prettier;

  plugins = {
    astro = {
      plugin = "prettier-plugin-astro";
      filetypes = ["astro"];
    };
    svelte = {
      plugin = "prettier-plugin-svelte";
      filetypes = ["svelte"];
    };
    pug = {
      plugin = "@prettier/plugin-pug";
      filetypes = ["pug"];
    };
  };
in {
  options.vim.formatter.conform-nvim.presets.prettier = {
    enable = mkFormatterPresetEnableOption {
      option = "prettier";
      display = "Prettier";
    };

    plugins = mkOption {
      type = listOf (enum (attrNames plugins));
      default = [];
      description = ''
        Extra Prettier plugins to load.

        Plugins will only be loaded on their defined filetypes by default.
        This can be overridden via {option}`vim.formatter.conform-nvim.presets.prettier.filetypeParsers`
      '';
    };

    filetypeParser = mkOption {
      type = attrsOf str;
      default = listToAttrs (concatMap
        (name:
          map (filetype: {
            name = filetype;
            value = name;
          })
          plugins.${name}.filetypes)
        cfg.plugins);
      defaultText = literalMD ''
        Matching filetypes and parsers for the registered
        `config.vim.formatter.conform-nvim.presets.prettier.plugins`.
      '';
      description = ''
        In some cases, Prettier cannot infer the appropriate parser for a file on its own, even after loading a plugin.
        This option allows to override that.

        See more about this upstream:
        <https://github.com/stevearc/conform.nvim/blob/master/lua/conform/formatters/prettier.lua#L32>
      '';
    };
  };

  config = mkIf cfg.enable {
    vim.formatter.conform-nvim.setupOpts.formatters.prettier = {
      command = "prettier";
      options.ft_parsers = cfg.filetypeParser;
      prepend_args = let
        args = listToAttrs (concatMap
          (name:
            map (filetype: {
              name = filetype;
              value = ["--plugin=${plugins.${name}.plugin}"];
            })
            plugins.${name}.filetypes)
          cfg.plugins);
      in
        mkLuaInline ''
          function(self, ctx)
            return (${toLuaObject args})[vim.bo[ctx.buf].filetype] or {}
          end
        '';
    };
  };
}
