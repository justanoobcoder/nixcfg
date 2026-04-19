{
  flake.nixosModules.sysrq = _: {
    boot.kernel.sysctl."kernel.sysrq" = 1;
  };
}
