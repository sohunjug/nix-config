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
    "ssh-dss AAAAB3NzaC1kc3MAAACBAM/gJygjG3AGkoC0xoRAsM1YuHPwKREzj114eh/4i6GSnzyjGmyqCPVRi7L+cuTerLNJSbHKgpubZ0u4kDbkXnaeSr2UM6JuMHsVwjYm7eObx4YfU7rkwKYsS7qBw7fruM9iAsRPJZSK6OiC99l/V7QeihjHIErgMhf14ludnh7pAAAAFQDsA2fP8D3pUiRO6zodWDMdZgZz8QAAAIBlOUscSXxSRfXGBSYsmn0jUohp7N26goYUreN2JBoC741n6EMRldhbF9TF8YaRQ07dm0rSryZ7FYQ+3jY7jdEeeEfd17Guf2oJw5TwdjZZYFBW4tL07xQQrHaguVxPJfje3aafoS9lOHKRpv6pEJC2xAE8Ew0qS9OLYiCUgZTbUAAAAIEArU1ZemCd86b6uwCeW0TOn9pu6GM3l1ROwQ30x9Z4b7m+m3iJRPh/CQGSujIs/6Az4/RsRio1c+lydcEnTcQNoleKPXzuymDzaDYE+hhOYE6i59LB61k5+18gU7HKEqePO3wrcsaVyUnPDRr5Aa4a/5M3Blx/1DAYneLmBhhsbp8= sohunjug@sohunjug-MacBookPro.sz.lan"
  ];
  users.mutableUsers = true;
  users.users.sohunjug = {
    isNormalUser = true;
    home = "/home/sohunjug";
    description = "sohunjug";
    extraGroups = [ "wheel" "networkmanager" ];
    password = "hwqdir55";
    openssh.authorizedKeys.keys = [ 
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
