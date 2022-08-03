{ stdenv, lib, lua, python3Full, openblasCompat, liblapack, openmpi, fftw, suitesparse, boost } :

  #let
# openblas-single-thread = openblas.override { singleThreaded = true; };

stdenv.mkDerivation {

  pname = "s4";
  version = "1.1";
  src = ./.;

  preBuild = ''
    buildFlagsArray=(
      LUA_INC=-I${lua}/inclue
      LUA_LIB="-L${lua}/lib -llua"
    )
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp build/S4 $out/bin
  '';

  buildInputs = [ lua python3Full (openblasCompat.override { singleThreaded = true; }) liblapack openmpi fftw suitesparse boost ];
  #buildInputs = [ lua python3Full openblas-single-thread liblapack openmpi fftw suitesparse boost ];

  meta = with lib; {
    description = "Stanford Stratified Structure Solver - Electromagnetic simulator for layered periodic structures";
    longDescription = ''
      S4: Stanford Stratified Structure Solver (http://fan.group.stanford.edu/S4/)

      A program for computing electromagnetic fields in periodic, layered
      structures, developed by Victor Liu (victorliu@alumni.stanford.edu) of the
      Fan group in the Stanford Electrical Engineering Department.

      See the S4 manual, in doc/index.html, for a complete
      description of the package and its user interface, as well as
      installation instructions, the license and copyright, contact
      addresses, and other important information.
    '';
    homepage = "https://haproxy.org";
    license = licenses.gpl2;
    maintainers = with maintainers; [ ];
    platforms = with platforms; linux;
  };
}
