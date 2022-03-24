{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    
    
  ];

  boot.cleanTmpDir = true;
  zramSwap.enable = true;
  networking.hostName = "sohunjug-tx";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCmrV5mJQAK4vZCyYfwNxIifrUMgMkVvvVTe9MkCTXpWBEYZtYvv4q7s3h5qD4yGgj2edvRxekUqoaxoYuyYZXIy3YTKg6ZIGsU4qRNznRhf/+l5dvr/K/7p/EALb3Ws+h7QW4LM1DKDuZBqU5iqKW8xFp5czb+UW7nAUADcjvHSzTVD//w/RS1XhU3vfAWZaq2X3l92+iI2UsES4irKlszlYUWpdUfN3aLNxu1tyP70jPjOVViOm8fMdDC/FI1Y35VoT6oZTk+VfVteA9FhGmIZQop5ap8TfVctGmHKc8WUd8rftYK4wzTZAKAxV+WEYkSc5k+nI1fX84O6+DlCqkJ skey-83c4jp3n" 
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDADwTBrKdLfQf8kcsiLFE53xgWzxZjuCBEu84QRmMEI9VTZLFEDda2C37ab8u2xBXIz4Ecwbgn+AebBI0DOTP3DNeRCcLuOWOhNVqsOm3BpmXs4JfHTiPg+OXe2y9jVL3UB9K/0e20fN5z6jtIj/ASseW5EV5C17ztL6gMPTDME483hr2WVjPejjJEyv4X9hNOAsqPXKdHG+zol4eSuTpkMXchnlxEtDh4yVYJPtBZuL6WuRzPSG57xB+SCQ2uAr7UgXZeQEEfs/91p7dcHR3Irk24q1I2qvjOPxGKpehsr4N+/pilrx11o5VetZ3vkh/bhWxBvdpbLlfzK6xOi/0Z skey-kkx0rmpd" 
  ];
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  environment.systemPackages = with pkgs; [
    vim
    git
    neovim
  ];
}
