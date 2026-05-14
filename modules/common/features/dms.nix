{
  flake.nixosModules.dms =
    {
      inputs,
      pkgs,
      ...
    }:
    let
      patchedDms = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (old: {
        postInstall = (old.postInstall or "") + ''
          for f in \
            $out/share/quickshell/dms/Modules/DankBar/Widgets/WorkspaceSwitcher.qml \
            $out/share/quickshell/dms/Modules/DankBar/DankBarContent.qml; do

            substituteInPlace "$f" \
              --replace-warn \
                'Hyprland.dispatch(`workspace ''${data.id}`)' \
                'Hyprland.dispatch(`hl.dsp.focus({ workspace = ''${data.id} })`)' \
              --replace-warn \
                'Hyprland.dispatch(`workspace ''${modelData.id}`)' \
                'Hyprland.dispatch(`hl.dsp.focus({ workspace = ''${modelData.id} })`)' \
              --replace-warn \
                'Hyprland.dispatch(`workspace ''${realWorkspaces[nextIndex].id}`)' \
                'Hyprland.dispatch(`hl.dsp.focus({ workspace = ''${realWorkspaces[nextIndex].id} })`)'
          done
        '';
      });
    in
    {
      programs.dms-shell = {
        enable = true;
        package = patchedDms;
        quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
      };
    };
}
