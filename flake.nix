{

  inputs = {
    haedosa.url = "github:haedosa/flakes/22.05";
    nixpkgs.follows = "haedosa/nixpkgs";
    flake-utils.follows = "haedosa/flake-utils";
  };

  outputs = input@{self, nixpkgs, flake-utils, ...} :
    {
      overlay = final: prev: {
        s4 = final.callPackage ./default.nix {};
      };
    }
    //
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let

        pkgs = import nixpkgs {
          inherit system;
          overlays = [ self.overlay ];
        };
        lib = pkgs.lib;
        #lua = pkgs.lua5_3.withPackages(ps: with ps; [ busted luafilesystem ]);

      in rec {

        #defaultPackage = pkgs.s4;
        #defaultApp = {
        #  type = "app";
        #  program = "${pkgs.s4}/bin/S4";
        #};
        #devShell = pkgs.mkShell {
        #  buildInputs = with pkgs; [ lua python3Full blas liblapack openmpi fftw suitesparse boost];
        #  # buildInputs = with pkgs; [ lua python3Full openblasCompat(blas, openblasCompat is also avaiable but openblas is not allowed) ];
        #};

        #packages = flake-utils.lib.flattenTree {
        #  gnuplot = pkgs.gnuplot;
        #};
        packages.s4 = pkgs.s4;
        packages.gnuplot = pkgs.gnuplot;
        #apps.gnuplot = flake-utils.lib.mkApp { drv = packages.gnuplot; };
        defaultPackage = packages.s4;
        #defaultApp = apps.gnuplot;
       # packages.gnuplot = pkgs.gnuplot;
       # packages.x86_64-linux.gnuplot = pkgs.legacyPackages.x86_64-linux.gnuplot;
      });

}
