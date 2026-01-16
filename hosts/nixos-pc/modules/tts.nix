{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    speechd
    piper-tts
  ];

  services.speechd.enable = true;

  environment.etc."speech-dispatcher/speechd.conf".text = ''
    DefaultModule piper-tts
    LogLevel 3
  '';
}
