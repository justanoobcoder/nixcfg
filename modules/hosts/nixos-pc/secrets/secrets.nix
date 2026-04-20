let
  hiepnh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKgyh6uAN6XJarCz7XKLawjsgi6mAvIDBMmbZyahPSNC";
in
{
  "cachix-auth-token.age".publicKeys = [ hiepnh ];
}
