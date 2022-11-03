{ pkgs ? (import ./compat.nix).pkgs
}:

let
  rev = "0.1.0+ci";
in
{
  nix-alien-ci = pkgs.callPackage ./nix-alien.nix {
    inherit rev;
    ci = true;
  };

  nix-index-update-ci = pkgs.callPackage ./nix-index-update.nix { };

  check-format-nix = pkgs.runCommand "check-format-nix"
    {
      src = ./.;
      nativeBuildInputs = [ pkgs.nixpkgs-fmt ];
    } ''
    touch $out
    nixpkgs-fmt --check $src
  '';
}
