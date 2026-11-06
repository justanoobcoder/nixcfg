{
  # fcitx5-qt 5.1.16 clears its cached surrounding text on every update() that does not query it,
  # and filterEvent() runs update(ImHints | ImEnabled) before each key. DeleteSurroundingText then
  # fails validation against the cleared copy and is dropped, so input methods that edit committed
  # text (fcitx5-jot in Surrounding mode) double it in every Qt app: "chaof" -> "chaoào".
  # https://github.com/fcitx/fcitx5-qt/issues/91, fix from the open PR
  # https://github.com/fcitx/fcitx5-qt/pull/92. Drop once a release includes it.
  flake.overlays.fcitx5-qt =
    _: prev:
    let
      patchFcitx5Qt =
        pkg:
        pkg.overrideAttrs (old: {
          patches = (old.patches or [ ]) ++ [
            (prev.fetchpatch {
              name = "fcitx5-qt-keep-surrounding-on-unrelated-update.patch";
              url = "https://github.com/fcitx/fcitx5-qt/commit/8536f1f86df93bacce49950ab246802175142881.patch";
              hash = "sha256-ObiX2cj/v6TKh+afdX5yOV5hbphMP0IzPhw9u0ZjBtQ=";
            })
          ];
        });
    in
    {
      qt6Packages = prev.qt6Packages.overrideScope (
        _: qprev: { fcitx5-qt = patchFcitx5Qt qprev.fcitx5-qt; }
      );
      libsForQt5 = prev.libsForQt5.overrideScope (
        _: qprev: { fcitx5-qt = patchFcitx5Qt qprev.fcitx5-qt; }
      );
    };
}
