{
  perSystem =
    { pkgs, ... }:
    {
      packages.disk-hogs = pkgs.writeShellApplication {
        name = "disk-hogs";
        runtimeInputs = [ pkgs.coreutils ];
        text = ''
          # Lists directories under ROOT that take at least MIN_SIZE, largest first.
          # Usage: disk-hogs [ROOT] [MIN_SIZE]   (defaults: $HOME, 1G)
          root="''${1:-$HOME}"
          min="''${2:-1G}"

          if [[ ! -d "$root" ]]; then
            echo "disk-hogs: '$root' is not a directory" >&2
            exit 1
          fi
          if [[ ! "$min" =~ ^[0-9]+[KMGT]?$ ]]; then
            echo "disk-hogs: '$min' is not a size like 500M or 1G" >&2
            exit 1
          fi

          # -x: stay on ROOT's filesystem. Permission errors are expected noise
          # and make du exit non-zero, so both are ignored.
          { du -xh --threshold="$min" "$root" 2>/dev/null || true; } | sort -rh
        '';
      };
    };
}
