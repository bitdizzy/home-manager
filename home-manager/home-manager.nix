{
  pkgs ? import <nixpkgs> { },
  confPath,
  confAttr ? null,
  check ? true,
  extraSpecialArgs ? { },
}:

let

  env = import ../modules {
    configuration =
      if confAttr == "" || confAttr == null then confPath else (import confPath).${confAttr};
    inherit check pkgs extraSpecialArgs;
  };

in
{
  inherit (env)
    activationPackage
    config
    pkgs
    options
    ;
}
