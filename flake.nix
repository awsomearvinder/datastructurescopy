{
  description = "Flake for my datastructures monorepo stuff for class";

  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";
  inputs.alejandra.url = "github:kamadorueda/alejandra/3.0.0";
  inputs.alejandra.inputs.nixpkgs.follows = "nixpkgs";

  outputs = {
    self,
    nixpkgs,
    alejandra,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    devShell.${system} = pkgs.mkShell rec {
      name = "java-shell";
      packages = [
        alejandra.defaultPackage.${system}
      ];
      buildInputs = with pkgs; [
        jdk17
        jetbrains.idea-community
      ];

      shellHook = ''
        export _JAVA_AWT_WM_NONREPARENTING=1
        export PATH="${pkgs.jdk17}/bin:$PATH"
      '';
    };
  };
}
