{
  description = "NixOS dotfiles";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/hyprland";
  };

  outputs = {self, nixpkgs, home-manager}:
    let
      system = "x86_64-linux";
      
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.system = system;
      };
    in {
    nixosConfigurations = {
      crazy = nixpkgs.lib.nixosSystem {
        inherit system;
        
        modules = [
          ./hosts/crazy/configuration.nix
        ]
      }
    };

    homeConfigurations = {
      "mohamed@crazy" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};

        modules = [
          ./hosts/crazy/home.nix
        ]
      };
    }
  }
}
