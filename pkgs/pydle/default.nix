{
  lib,
  buildPythonPackage,
  fetchPypi,
  poetry-core,
  ...
}:

buildPythonPackage rec {
  pname = "pydle";
  version = "1.0.1";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-+kUYdJWC46PHXN3srxdY1SV1q4oFe76KIkFEvHI+Lao=";
  };

  nativeBuildInputs = [
    poetry-core
  ];

  # From https://gitlab.archlinux.org/archlinux/packaging/packages/python-pydle
  patches = [
    (builtins.fetchurl {
      url = "https://github.com/Shizmob/pydle/commit/21dedc6679a5fcaab5c7fda9fc63d93676d89b04.patch";
      sha256 = "10xpc68vhnlvryd8wvmch6cmwfibb3bipavpslkpf36rhn67j902";
    })
  ];

  postPatch = ''
    sed -i '/loop=self.eventloop/d' pydle/connection.py
    sed -i 's/python = ">=3.6;<3.10/python = "3.12"/' pyproject.toml
  '';

  meta = with lib; {
    changelog = "https://github.com/shizmob/pydle/releases/tag/${version}";
    description = "An IRCv3-compliant Python 3 IRC library.";
    homepage = "https://github.com/Shizmob/pydle";
    license = licenses.bsd3;
  };
}
