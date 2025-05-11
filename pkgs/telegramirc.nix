{
  stdenv,
  makeWrapper,
  fetchFromGitHub,
  pydle,
  pure-sasl,
  python312,
  ...
}:
let
  pythonEnv = python312.withPackages (
    ps:
    (with ps; [
      aiogram
      tenacity
      toml
    ])
    ++ [
      pydle
      pure-sasl
    ]
  );
in
stdenv.mkDerivation rec {
  pname = "telegramirc";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "felixonmars";
    repo = "telegramirc";
    rev = "6689fc39bcaa6933ba05c08cc9afac3ef4c8c195";
    hash = "sha256-uGkU7H0EfOK2pcWvV+dLwyB+5gIVzzqXMwe3FCxr3B0=";
  };

  nativeBuildInputs = [
    makeWrapper
  ];
  buildInputs = [
    pythonEnv
  ];

  # add python shebang
  postPatch = ''
    sed -i "1i #!/usr/bin/env python" telegramirc.py
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    install -m555 telegramirc.py $out/bin/${pname}

    runHook postInstall
  '';

  meta = {
    mainProgram = "telegramirc";
  };
}
