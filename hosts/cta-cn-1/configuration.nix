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
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDGgMSAVS2ZyIeka1dLx10BQikcGCMXux6PQWhpUIBVm3brjOA0E4gdhR6LCGXzBd0FhxszepdIDNIiyQUblGQQTG0GXr8VtEBcvbYVWf+QHtqn7JmmL0NGPYeLfvcl23hulOcfQhLv9olVG5fE/JBQWYnwRHAHf9dH+qx/ZwoOj1pTBBCcr1vei/ymsNS631EneuXAQhtMpLeKY7nDPHtoLdctEQvvUyKhfDFJ7VeYBCAyHmsW8xcCH75VZm/nSMC1O3hdlmsLUZFf8qJWbQ0qI4RMTsNLTJaaeWdcVi0ciR2wOZ3Oxx9aO32wVNv7yWNG1TbBKD4oc5l0+7tj9/leTtJSL5oPU9BfXXi/AUlDgm/slepHH73WwTln3OTCksHPdTnzoTezjwp8xz4EngTOXJHwK66Y4UOUt1wPvukatw+h62XgZxdWt2CQqDFr+LNfHSyzcICeiI3KKSVa2vwWlcfC8My4qVlvkZyfv41GPqASlHfBCaYF7cbTrh25dZE= sohunjug@gmail.com"
    "ssh-rsa AAAAB4NzaC1yc2EAAAADAQABAAABAQCmrV5mJQAK4vZCyYfwNxIifrUMgMkVvvVTe9MkCTXpWBEYZtYvv4q7s3h5qD4yGgj2edvRxekUqoaxoYuyYZXIy3YTKg6ZIGsU4qRNznRhf/+l5dvr/K/7p/EALb3Ws+h7QW4LM1DKDuZBqU5iqKW8xFp5czb+UW7nAUADcjvHSzTVD//w/RS1XhU3vfAWZaq2X3l92+iI2UsES4irKlszlYUWpdUfN3aLNxu1tyP70jPjOVViOm8fMdDC/FI1Y35VoT6oZTk+VfVteA9FhGmIZQop5ap8TfVctGmHKc8WUd8rftYK4wzTZAKAxV+WEYkSc5k+nI1fX84O6+DlCqkJ sohunjug@hotmail.com" 
  ];
  users.mutableUsers = true;
  users.users.sohunjug = {
    isNormalUser = true;
    home = "/home/sohunjug";
    description = "sohunjug";
    extraGroups = [ "wheel" "networkmanager" ];
    password = "hwqdir55";
    openssh.authorizedKeys.keys = [ 
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDGgMSAVS2ZyIeka1dLx10BQikcGCMXux6PQWhpUIBVm3brjOA0E4gdhR6LCGXzBd0FhxszepdIDNIiyQUblGQQTG0GXr8VtEBcvbYVWf+QHtqn7JmmL0NGPYeLfvcl23hulOcfQhLv9olVG5fE/JBQWYnwRHAHf9dH+qx/ZwoOj1pTBBCcr1vei/ymsNS631EneuXAQhtMpLeKY7nDPHtoLdctEQvvUyKhfDFJ7VeYBCAyHmsW8xcCH75VZm/nSMC1O3hdlmsLUZFf8qJWbQ0qI4RMTsNLTJaaeWdcVi0ciR2wOZ3Oxx9aO32wVNv7yWNG1TbBKD4oc5l0+7tj9/leTtJSL5oPU9BfXXi/AUlDgm/slepHH73WwTln3OTCksHPdTnzoTezjwp8xz4EngTOXJHwK66Y4UOUt1wPvukatw+h62XgZxdWt2CQqDFr+LNfHSyzcICeiI3KKSVa2vwWlcfC8My4qVlvkZyfv41GPqASlHfBCaYF7cbTrh25dZE= sohunjug@gmail.com"
      "ssh-rsa AAAAB4NzaC1yc2EAAAADAQABAAABAQCmrV5mJQAK4vZCyYfwNxIifrUMgMkVvvVTe9MkCTXpWBEYZtYvv4q7s3h5qD4yGgj2edvRxekUqoaxoYuyYZXIy3YTKg6ZIGsU4qRNznRhf/+l5dvr/K/7p/EALb3Ws+h7QW4LM1DKDuZBqU5iqKW8xFp5czb+UW7nAUADcjvHSzTVD//w/RS1XhU3vfAWZaq2X3l92+iI2UsES4irKlszlYUWpdUfN3aLNxu1tyP70jPjOVViOm8fMdDC/FI1Y35VoT6oZTk+VfVteA9FhGmIZQop5ap8TfVctGmHKc8WUd8rftYK4wzTZAKAxV+WEYkSc5k+nI1fX84O6+DlCqkJ sohunjug@hotmail.com" 
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
