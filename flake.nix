{
  description =
    "A Nix-flake-based environment for slickmotd";


  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {
      packages = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.writeShellApplication {
          name = "slickmotd";
          runtimeInputs = with pkgs; [ bash figlet git ];
          text = builtins.readFile ./slickmotd.sh;
        };
      });

      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            self.packages.${system}.default
          ];
        };
      });

    };
}
