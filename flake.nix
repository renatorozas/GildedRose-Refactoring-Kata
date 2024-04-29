{
  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
  outputs = { self, nixpkgs }: {
    devShells.aarch64-darwin.default =
      let
        pkgs = import nixpkgs { system = "aarch64-darwin"; };
      in
      pkgs.mkShell {
        packages = [ pkgs.ruby_3_3 ];
        shellHook = ''
          export PATH=$(gem env home)/bin:$PATH
        '';
      };
  };
}
