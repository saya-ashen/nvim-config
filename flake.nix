{
  description = "A Lua-natic's neovim flake, with extra cats! nixCats!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      inherit (inputs.nixCats) utils;
      luaPath = ./.;
      forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;
      extra_pkg_config = { };
      dependencyOverlays = # (import ./overlays inputs) ++
        [ (utils.standardPluginOverlay inputs) ];

      # see :help nixCats.flake.outputs.categories
      # and
      # :help nixCats.flake.outputs.categoryDefinitions.scheme
      categoryDefinitions =
        {
          pkgs,
          settings,
          categories,
          extra,
          name,
          mkPlugin,
          ...
        }@packageDef:
        {
          # to define and use a new category, simply add a new list to a set here,
          # and later, you will include categoryname = true; in the set you
          # provide when you build the package using this builder function.
          # see :help nixCats.flake.outputs.packageDefinitions for info on that section.

          # lspsAndRuntimeDeps:
          # this section is for dependencies that should be available
          # at RUN TIME for plugins. Will be available to PATH within neovim terminal
          # this includes LSPs
          lspsAndRuntimeDeps = {
            general = with pkgs; [
              universal-ctags
              ripgrep
              fd
            ];
            lint = with pkgs; [
              eslint_d
              vale
            ];
            debug = with pkgs; {
              go = [ delve ];
            };
            format = with pkgs; [ stylua ];
            nix = with pkgs; [
              nixd
              nix-doc
              # nixfmt-rfc-style
              nixfmt
            ];
            toml = with pkgs; [ taplo ];
            python = with pkgs; [
              ruff
              ty
              basedpyright
            ];
            # vue = with pkgs; [ vue-language-server typescript-language-server ];
            json = with pkgs; [
              vscode-langservers-extracted
              jq
            ];
            web = with pkgs; [ vtsls ];
            neonixdev = { inherit (pkgs) lua-language-server; };
          };

          # This is for plugins that will load at startup without using packadd:
          startupPlugins = {
            debug = with pkgs.vimPlugins; [ nvim-nio ];
            general = with pkgs.vimPlugins; {
              # you can make subcategories!!!
              # (always isnt a special name, just the one I chose for this subcategory)
              always = [
                lze
                lzextras
                vim-repeat
                plenary-nvim
              ];
              extra = [ nvim-web-devicons ];
            };
            themer =
              with pkgs.vimPlugins;
              (builtins.getAttr (categories.colorscheme or "tokyonight") {
                "tokyonight" = tokyonight-nvim;
                "tokyonight-day" = tokyonight-nvim;
              });
            # This is obviously a fairly basic usecase for this, but still nice.
          };

          # `:NixCats pawsible` command to see them all
          optionalPlugins = {
            debug = with pkgs.vimPlugins; {
              default = [
                nvim-dap
                nvim-dap-ui
                nvim-dap-virtual-text
              ];
              go = [ nvim-dap-go ];
            };
            lint = with pkgs.vimPlugins; [ nvim-lint ];
            format = with pkgs.vimPlugins; [ conform-nvim ];
            markdown = with pkgs.vimPlugins; [ markdown-preview-nvim ];
            neonixdev = with pkgs.vimPlugins; [ lazydev-nvim ];
            general = {
              ai = with pkgs.vimPlugins; [
                avante-nvim
                telescope-nvim
                copilot-lua
                mini-pick
                render-markdown-nvim
              ];
              ui = with pkgs.vimPlugins; [
                bufferline-nvim
                snacks-nvim
                lualine-nvim
                dashboard-nvim
                noice-nvim
                nui-nvim
                persistence-nvim
                nvim-notify
              ];
              blink = with pkgs.vimPlugins; [
                luasnip
                cmp-cmdline
                blink-cmp
                blink-compat
                colorful-menu-nvim
                # blink-cmp-avante
                # blink-cmp-copilot
                blink-copilot
              ];
              yazi = with pkgs.vimPlugins; [ yazi-nvim ];
              mini = with pkgs.vimPlugins; [
                mini-files
                mini-icons
                mini-pairs
                mini-ai
                mini-pick
                mini-animate
              ];
              treesitter = with pkgs.vimPlugins; [
                nvim-treesitter-textobjects
                (nvim-treesitter.withPlugins (p: [
                  p.bash
                  p.c
                  p.css
                  p.fish
                  p.html
                  p.jinja
                  p.json
                  p.json5
                  p.just
                  p.lua
                  p.make
                  p.nginx
                  p.nix
                  p.python
                  p.sql
                  p.toml
                  p.typescript
                  p.tsx
                  p.vue
                  p.yaml
                ]))
              ];
              telescope = with pkgs.vimPlugins; [
                telescope-fzf-native-nvim
                telescope-ui-select-nvim
                telescope-nvim
              ];
              always = with pkgs.vimPlugins; [
                nvim-lspconfig
                gitsigns-nvim
                vim-sleuth
                vim-fugitive
                vim-rhubarb
                nvim-surround
                flash-nvim
                trouble-nvim
                promise-async
                nvim-ufo
                persisted-nvim
              ];
              extra = with pkgs.vimPlugins; [
                fidget-nvim
                which-key-nvim
                comment-nvim
                undotree
                indent-blankline-nvim
                vim-startuptime
              ];
              code = with pkgs.vimPlugins; [ aerial-nvim ];
            };
          };

        };

      # packageDefinitions:

      # Now build a package with specific categories from above
      # All categories you wish to include must be marked true,
      # but false may be omitted.
      # This entire set is also passed to nixCats for querying within the lua.
      # It is directly translated to a Lua table, and a get function is defined.
      # The get function is to prevent errors when querying subcategories.

      # see :help nixCats.flake.outputs.packageDefinitions
      packageDefinitions = {
        # the name here is the name of the package
        # and also the default command name for it.
        nvim =
          { pkgs, name, ... }@misc:
          {
            # these also recieve our pkgs variable
            # see :help nixCats.flake.outputs.packageDefinitions
            settings = {
              suffix-path = true;
              suffix-LD = true;
              # The name of the package, and the default launch name,
              # and the name of the .desktop file, is `nixCats`,
              # or, whatever you named the package definition in the packageDefinitions set.
              # WARNING: MAKE SURE THESE DONT CONFLICT WITH OTHER INSTALLED PACKAGES ON YOUR PATH
              # That would result in a failed build, as nixos and home manager modules validate for collisions on your path
              aliases = [
                "vim"
                "vimcat"
              ];

              # explained below in the `regularCats` package's definition
              # OR see :help nixCats.flake.outputs.settings for all of the settings available
              wrapRc = true;
              configDirName = "nixCats-nvim";
              # neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
              hosts.python3.enable = true;
              hosts.node.enable = true;
            };
            # enable the categories you want from categoryDefinitions
            categories = {
              markdown = true;
              general = true;
              lint = true;
              format = true;
              neonixdev = true;
              nix = true;
              python = true;
              web = true;
              json = true;
              toml = true;
              lspDebugMode = false;
              themer = true;
              colorscheme = "tokyonight";
            };
            extra = {
              # to keep the categories table from being filled with non category things that you want to pass
              # there is also an extra table you can use to pass extra stuff.
              # but you can pass all the same stuff in any of these sets and access it in lua
              nixdExtras = {
                nixpkgs = "import ${pkgs.path} {}";
                # or inherit nixpkgs;
              };
            };
          };
        regularCats =
          { pkgs, ... }@misc:
          {
            settings = {
              suffix-path = true;
              suffix-LD = true;
              # IMPURE PACKAGE: normal config reload
              # include same categories as main config,
              # will load from vim.fn.stdpath('config')
              wrapRc = false;
              # or tell it some other place to load
              # unwrappedCfgPath = "/some/path/to/your/config";

              # configDirName: will now look for nixCats-nvim within .config and .local and others
              # this can be changed so that you can choose which ones share data folders for auths
              # :h $NVIM_APPNAME
              configDirName = "nixCats-nvim";

              aliases = [ "testCat" ];

              # If you wanted nightly, uncomment this, and the flake input.
              # neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
              # Probably add the cache stuff they recommend too.
            };
            categories = {
              markdown = true;
              general = true;
              neonixdev = true;
              lint = true;
              format = true;
              # test = true;
              lspDebugMode = false;
              themer = true;
              colorscheme = "tokyonight";
            };
            extra = {
              # nixCats.extra("path.to.val") will perform vim.tbl_get(nixCats.extra, "path" "to" "val")
              # this is different from the main nixCats("path.to.cat") in that
              # the main nixCats("path.to.cat") will report true if `path.to = true`
              # even though path.to.cat would be an indexing error in that case.
              # this is to mimic the concept of "subcategories" but may get in the way of just fetching values.
              nixdExtras = {
                nixpkgs = "import ${pkgs.path} {}";
                # or inherit nixpkgs;
              };
              # yes even tortured inputs work.
              theBestCat = "says meow!!";
              theWorstCat = {
                thing'1 = [
                  "MEOW"
                  '']]' ]=][=[HISSS]]"[[''
                ];
                thing2 = [
                  {
                    thing3 = [
                      "give"
                      "treat"
                    ];
                  }
                  "I LOVE KEYBOARDS"
                  (utils.mkLuaInline ''[[I am a]] .. [[ lua ]] .. type("value")'')
                ];
                thing4 = "couch is for scratching";
              };
            };
          };
      };

      defaultPackageName = "nvim";
      # I did not here, but you might want to create a package named nvim.

      # defaultPackageName is also passed to utils.mkNixosModules and utils.mkHomeModules
      # and it controls the name of the top level option set.
      # If you made a package named `nixCats` your default package as we did here,
      # the modules generated would be set at:
      # config.nixCats = {
      #   enable = true;
      #   packageNames = [ "nixCats" ]; # <- the packages you want installed
      #   <see :h nixCats.module for options>
      # }
      # In addition, every package exports its own module via passthru, and is overrideable.
      # so you can yourpackage.homeModule and then the namespace would be that packages name.
      # you shouldnt need to change much past here, but you can if you wish.
      # but you should at least eventually try to figure out whats going on here!
      # see :help nixCats.flake.outputs.exports
    in
    forEachSystem (
      system:
      let
        # and this will be our builder! it takes a name from our packageDefinitions as an argument, and builds an nvim.
        nixCatsBuilder = utils.baseBuilder luaPath {
          # we pass in the things to make a pkgs variable to build nvim with later
          inherit
            nixpkgs
            system
            dependencyOverlays
            extra_pkg_config
            ;
          # and also our categoryDefinitions and packageDefinitions
        } categoryDefinitions packageDefinitions;
        # call it with our defaultPackageName
        defaultPackage = nixCatsBuilder defaultPackageName;

        # this pkgs variable is just for using utils such as pkgs.mkShell
        # within this outputs set.
        pkgs = import nixpkgs { inherit system; };
        # The one used to build neovim is resolved inside the builder
        # and is passed to our categoryDefinitions and packageDefinitions
      in
      {
        # these outputs will be wrapped with ${system} by utils.eachSystem

        # this will generate a set of all the packages
        # in the packageDefinitions defined above
        # from the package we give it.
        # and additionally output the original as default.
        packages = utils.mkAllWithDefault defaultPackage;

        # choose your package for devShell
        # and add whatever else you want in it.
        devShells = {
          default = pkgs.mkShell {
            name = defaultPackageName;
            packages = [ defaultPackage ];
            inputsFrom = [ ];
            shellHook = "";
          };
        };

      }
    )
    // (
      let
        # we also export a nixos module to allow reconfiguration from configuration.nix
        nixosModule = utils.mkNixosModules {
          moduleNamespace = [ defaultPackageName ];
          inherit
            defaultPackageName
            dependencyOverlays
            luaPath
            categoryDefinitions
            packageDefinitions
            extra_pkg_config
            nixpkgs
            ;
        };
        # and the same for home manager
        homeModule = utils.mkHomeModules {
          moduleNamespace = [ defaultPackageName ];
          inherit
            defaultPackageName
            dependencyOverlays
            luaPath
            categoryDefinitions
            packageDefinitions
            extra_pkg_config
            nixpkgs
            ;
        };
      in
      {

        # these outputs will be NOT wrapped with ${system}

        # this will make an overlay out of each of the packageDefinitions defined above
        # and set the default overlay to the one named here.
        overlays = utils.makeOverlays luaPath {
          inherit nixpkgs dependencyOverlays extra_pkg_config;
        } categoryDefinitions packageDefinitions defaultPackageName;

        nixosModules.default = nixosModule;
        homeModules.default = homeModule;

        inherit utils nixosModule homeModule;
        inherit (utils) templates;
      }
    );

}
