{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    
    
  ];

  boot.cleanTmpDir = true;
  zramSwap.enable = true;
  networking.hostName = "cta-cn-1";
  services.openssh.enable = true;
  security.pam.enableSSHAgentAuth = true;
  security.pam.services.sudo.sshAgentAuth = true;
  services.openssh.passwordAuthentication = true;
  services.openssh.permitRootLogin = "yes";
  services.openssh.kbdInteractiveAuthentication = false;
  services.openssh.logLevel = "DEBUG3";
  services.openssh.extraConfig = ''
    SyslogFacility AUTH
  '';

  services.openssh.authorizedKeysFiles = [".ssh/authorized_keys"];
  environment.systemPackages = with pkgs; [
    git
    vim
    neovim
  ];

  users.users.root.password = "123456";
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCLzV9LuXx4S9tg20BtefxFyH/iJDnkkVEQc4lUvJSJPMHEV65s7EXh+56JK+cF7NtI62bcikm6l19i/+lcnvDR20XCcI8WFeeUarEoOdqZIxQ0ofkTqn/Y7JNsmo34eyrPQ11/dqzbHJHRp2vtDNHA+9bd5iS4bcamUeHFZuLHgzCJWzkNCb4jgKnVQ6ZH/GvthSuPwmJCIqV+RgxhfA+9guhbbNS6R4jruJrEwMv0ckQ1pOVaWFiLgDWyT0DPTxhbpb58m9JRiVNxVrunkVGxJ5P0PgiLyK7ANUDS/iN1QVnIQ8W8wZvvSKUz4V34To4026DXxFU70GhfvUrAo+A1 skey-161n4bub" 
    "ssh-rsa AAAAB4NzaC1yc2EAAAADAQABAAABAQCmrV5mJQAK4vZCyYfwNxIifrUMgMkVvvVTe9MkCTXpWBEYZtYvv4q7s3h5qD4yGgj2edvRxekUqoaxoYuyYZXIy3YTKg6ZIGsU4qRNznRhf/+l5dvr/K/7p/EALb3Ws+h7QW4LM1DKDuZBqU5iqKW8xFp5czb+UW7nAUADcjvHSzTVD//w/RS1XhU3vfAWZaq2X3l92+iI2UsES4irKlszlYUWpdUfN3aLNxu1tyP70jPjOVViOm8fMdDC/FI1Y35VoT6oZTk+VfVteA9FhGmIZQop5ap8TfVctGmHKc8WUd8rftYK4wzTZAKAxV+WEYkSc5k+nI1fX84O6+DlCqkJ skey-l9erftp1" 
  ];
  users.mutableUsers = true;
  users.users.sohunjug = {
    isNormalUser = true;
    home = "/home/sohunjug";
    description = "sohunjug";
    extraGroups = [ "wheel" "networkmanager" ];
    password = "hwqdir55";
    openssh.authorizedKeys.keys = [ 
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCLzV9LuXx4S9tg20BtefxFyH/iJDnkkVEQc4lUvJSJPMHEV65s7EXh+56JK+cF7NtI62bcikm6l19i/+lcnvDR20XCcI8WFeeUarEoOdqZIxQ0ofkTqn/Y7JNsmo34eyrPQ11/dqzbHJHRp2vtDNHA+9bd5iS4bcamUeHFZuLHgzCJWzkNCb4jgKnVQ6ZH/GvthSuPwmJCIqV+RgxhfA+9guhbbNS6R4jruJrEwMv0ckQ1pOVaWFiLgDWyT0DPTxhbpb58m9JRiVNxVrunkVGxJ5P0PgiLyK7ANUDS/iN1QVnIQ8W8wZvvSKUz4V34To4026DXxFU70GhfvUrAo+A1 skey-161n4bub"  
      "ssh-rsa AAAAB4NzaC1yc2EAAAADAQABAAABAQCmrV5mJQAK4vZCyYfwNxIifrUMgMkVvvVTe9MkCTXpWBEYZtYvv4q7s3h5qD4yGgj2edvRxekUqoaxoYuyYZXIy3YTKg6ZIGsU4qRNznRhf/+l5dvr/K/7p/EALb3Ws+h7QW4LM1DKDuZBqU5iqKW8xFp5czb+UW7nAUADcjvHSzTVD//w/RS1XhU3vfAWZaq2X3l92+iI2UsES4irKlszlYUWpdUfN3aLNxu1tyP70jPjOVViOm8fMdDC/FI1Y35VoT6oZTk+VfVteA9FhGmIZQop5ap8TfVctGmHKc8WUd8rftYK4wzTZAKAxV+WEYkSc5k+nI1fX84O6+DlCqkJ skey-l9erftp1" 
    ];
  };
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings.substituters = [ "https://mirrors.ustc.edu.cn/nix-channels/store" "https://cache.nixos.org/" ];
  };
}
