{ self, inputs, ... }: {

  flake.nixosModules.desktopConfiguration = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.base
      self.nixosModules.desktopHardware
      self.nixosModules.niri
      self.nixosModules.gaming
      self.nixosModules.extra_hjem
      self.nixosModules.performance
      self.nixosModules.preservation

      #GUI programs
      self.nixosModules.browser
      self.nixosModules.discord
      self.nixosModules.pipewire
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Bootloader.
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.useOSProber = true;

    networking.hostName = "nixos"; # Define your hostname.

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "America/Sao_Paulo";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "pt_BR.UTF-8";
      LC_IDENTIFICATION = "pt_BR.UTF-8";
      LC_MEASUREMENT = "pt_BR.UTF-8";
      LC_MONETARY = "pt_BR.UTF-8";
      LC_NAME = "pt_BR.UTF-8";
      LC_NUMERIC = "pt_BR.UTF-8";
      LC_PAPER = "pt_BR.UTF-8";
      LC_TELEPHONE = "pt_BR.UTF-8";
      LC_TIME = "pt_BR.UTF-8";
    };

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "br";
      variant = "";
    };

    # Configure console keymap
    console.keyMap = "br-abnt2";

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users."surtas" = {
      isNormalUser = true;
      description = "surtas";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [];
      initialPassword = "12345";
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
       self.packages.${pkgs.stdenv.hostPlatform.system}.terminal
       nvtopPackages.nvidia
    ];

    services.displayManager.ly.enable = true;

    xdg.portal = {
    	enable = true;
    	extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    	config.common.default = "gtk";
    };

    system.stateVersion = "26.05"; # Did you read the comment?
    };

}
