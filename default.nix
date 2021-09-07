{ buildPythonPackage, cython, boost, numpy, python3, lib }:
buildPythonPackage rec {
  pname = "graspi";
  version = "0.1";

  src = builtins.filterSource (path: type: type != "directory" || baseNameOf path != ".git") ./.;

  propogatedBuildInputs = [
    python3
    boost
    numpy
  ];

  pythonImportsCheck = ["graspi"];

  checkInputs = [
    python3
  ];

  checkPhase = ''
    ${python3.interpreter} testCythonizedGraSPI.py
  '';

  buildInputs = propogatedBuildInputs;

  meta = with lib; {
    homepage = "https://pymks.org";
    description = "The Materials Knowledge System in Python";
    license = licenses.mit;
    maintainers = with maintainers; [ wd15 ];
  };
}
