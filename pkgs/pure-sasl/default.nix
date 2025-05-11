{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  ...
}:

buildPythonPackage {
  pname = "pure-sasl";
  version = "0.6.2";

  src = fetchFromGitHub {
    owner = "thobbs";
    repo = "pure-sasl";
    tag = "0.6.2";
    hash = "sha256-AHoZ3QZLr0JLE8+a2zkB06v2wRknxhgm/tcEPXaJX/U=";
  };

  # From https://gitlab.archlinux.org/archlinux/packaging/packages/python-pure-sasl
  prePatch = ''
    sed -i 's/mock<=1.0.1/mock/' test-requirements.txt
  '';

  patches = [
    (builtins.fetchurl {
      url = "https://github.com/thobbs/pure-sasl/pull/42.patch";
      sha256 = "1sfx5l205fpj5nbx9gws49wpw7dm0gq4z351ygkk4cp0k9wgqi7p";
    })
  ];

  meta = with lib; {
    changelog = "https://github.com/thobbs/pure-sasl/blob/master/CHANGES.rst";
    description = "A pure python SASL client ";
    homepage = "https://github.com/thobbs/pure-sasl";
    license = licenses.mit;
  };
}
