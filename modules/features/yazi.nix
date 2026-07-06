{ inputs, self, ... }: {
  flake.wrappersModules.yazi = { ... }: {
    
    settings = {
      # Isso vai gerar o arquivo yazi.toml
      yazi = {
        manager = {
          ratio          = [ 1 4 3 ];
          sort_by        = "alphabetical";
          sort_sensitive = false;
          sort_reverse   = false;
          sort_dir_first = true;
          linemode       = "size";
          show_hidden    = false;
          show_symlink   = true;
        };
      };

      # Se quiser aplicar as cores do EVA-01 no futuro, 
      # você pode adicionar o bloco de tema aqui diretamente!
      theme = {
        # manager = { ... };
        # status = { ... };
      };
    };

  };
  perSystem = {pkgs, ...}: {
    packages.yazi =
      (inputs.wrappers.wrapperModules.yazi.apply {
        inherit pkgs;
        imports = [ self.wrappersModules.yazi ];
      }).wrapper;
  };
}
