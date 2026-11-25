{
  flake.nixosModules.optimiseDisk = _: {
    nix.settings = {
      auto-optimise-store = true;
      # GC during builds once free space drops below 5 GiB, until 20 GiB is free.
      min-free = 5 * 1024 * 1024 * 1024;
      max-free = 20 * 1024 * 1024 * 1024;
    };

    # Replaces nix.gc: keeps the 2 newest generations of every profile
    # regardless of age, and also drops stale result/direnv gcroots.
    programs.nh.enable = true;
    programs.nh.clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep 2";
    };

    services.journald.settings.Journal.SystemMaxUse = "500M";

    documentation = {
      doc.enable = false;
      nixos.enable = false;
    };
  };
}
