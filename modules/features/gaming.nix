{ self, inputs, ... }: {
  flake.nixosModules.gaming = { pkgs, lib, ... }: {
    
    programs = {
      gamemode.enable = true;
      
      gamescope.enable = true;
      
      steam = {
        enable = true;
        protontricks.enable = true;
      };
    };

    environment.systemPackages = with pkgs; [
      mangohud
      steam-run
      dxvk
    ];
    
  };
}
