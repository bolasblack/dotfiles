{
  lib,
  stdenvNoCC,
  fetchurl,
}:

let
  version = "2026.5.2";

  sources = {
    aarch64-darwin = {
      target = "macos-arm64";
      hash = "sha256-0V1RTWPQKoGOGfYgMKcx1YuJyOx6Vn5EFTVcBJYTlCw=";
    };

    aarch64-linux = {
      target = "linux-arm64-musl";
      hash = "sha256-FAbThaZJGzidNAIkrOXoRZ4Bkfyl6Wu+KqYUsUReHyE=";
    };

    x86_64-linux = {
      target = "linux-x64-musl";
      hash = "sha256-kjH9gtmya0jm9AO2kfvUNm4q3MPbU2H4hp3ZL6vhdGc=";
    };
  };

  source = sources.${stdenvNoCC.hostPlatform.system} or (throw "mise-bin is unsupported on ${stdenvNoCC.hostPlatform.system}");
in
stdenvNoCC.mkDerivation {
  pname = "mise";
  inherit version;

  src = fetchurl {
    url = "https://github.com/jdx/mise/releases/download/v${version}/mise-v${version}-${source.target}.tar.xz";
    inherit (source) hash;
  };

  sourceRoot = "mise";

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -R bin man share $out/
    install -Dm644 LICENSE $out/share/doc/mise/LICENSE
    install -Dm644 README.md $out/share/doc/mise/README.md

    runHook postInstall
  '';

  meta = {
    description = "The front-end to your dev env";
    homepage = "https://github.com/jdx/mise";
    license = lib.licenses.mit;
    mainProgram = "mise";
    platforms = builtins.attrNames sources;
  };
}
