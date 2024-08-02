{
  description = "motheki's nixvim config";

  inputs.nixvim.url = "github:nix-community/nixvim/main";

  outputs = {
    self,
    nixvim,
    flake-parts,
  } @ inputs: let
    config = {
      colorschemes.gruvbox.enable = true;
    };
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      perSystem = {
        pkgs,
        system,
        ...
      }: let
        nixvim' = nixvim.legacyPackages."${system}";
        nvim = nixvim'.makeNixvim config;
      in {
        packages = {
          inherit nvim;
          default = nvim;
        };
      };
    };
}
