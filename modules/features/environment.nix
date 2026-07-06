{ inputs, lib, self, ... }: {
  perSystem = { pkgs, self', ... }: {

    packages.environment = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = self'.packages.fish;
      
      runtimeInputs = [
        
        #other
        pkgs.unzip
        pkgs.zip
        pkgs.wget
        pkgs.htop
        pkgs.fastfetch
        pkgs.vim
        pkgs.wl-clipboard
        pkgs.nautilus

        #wrapped
        self'.packages.git
        self'.packages.yazi
      ];
    };

    packages.terminal = (inputs.wrappers.wrapperModules.kitty.apply {
      inherit pkgs;
      
      imports = [ self.wrappersModules.kitty ];
      
      shell = lib.getExe self'.packages.environment; 
    }).wrapper;

  };
}
