{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    haskell-flake.url = "github:srid/haskell-flake";
    nixpkgs.url = "github:nixos/nixpkgs/43e3b6af08f29c4447a6073e3d5b86a4f45dd420";
    systems.url = "github:nix-systems/default";
    ghc-hasfield-plugin.flake = false;
    large-records.flake = false;
    ghc-hasfield-plugin.url = "github:juspay/ghc-hasfield-plugin/d82ac5a6c0ad643eebe2b9b32c91f6523d3f30dc";
    large-records.url = "github:eswar2001/large-records/f4419e6b54fb1270ae0abce1994bf14a24bfe959";
    record-dot-preprocessor.url = "github:ndmitchell/record-dot-preprocessor/99452d27f35ea1ff677be9af570d834e8fab4caf";
   record-dot-preprocessor.flake = false;
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake { inputs = inputs // { inherit (inputs) nixpkgs nixpkgs-latest; }; } {
      systems = import inputs.systems;
      imports = [inputs.haskell-flake.flakeModule];

      perSystem = {
        self',
        pkgs,
        lib,
        config,
        ...
      }: {
        haskellProjects.default = {
          basePackages = pkgs.haskell.packages.ghc8107;
          packages = {
            ghc-hasfield-plugin.source = inputs.ghc-hasfield-plugin;
            large-records.source = inputs.large-records + /large-records;
            large-generics.source = inputs.large-records + /large-generics;
            large-anon.source = inputs.large-records + /large-anon;
            ghc-tcplugin-api.source = "0.7.1.0";
            typelet.source = inputs.large-records + /typelet;
            record-dot-preprocessor.source = inputs.record-dot-preprocessor;
          };
        };
        packages.default =  self'.packages.fieldInspector;
      };
    };
}
