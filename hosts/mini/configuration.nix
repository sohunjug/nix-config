# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "sohunjug-mini"; # Define your hostname.
    useDHCP = false;
    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    wireless = {
      enable = true;  # Enables wireless support via wpa_supplicant.
      # userControlled.enable = true;
      interfaces = ["wlp3s0"];
      networks = {
        "sohunjug" = {
	  pskRaw = "1faaa0d35fc3e38cc3ea3ea82914b030d2e27823c4329a105a0eaf845b54a7a1";
	};
      };
    };
    interfaces = {
      enp1s0.useDHCP = true;
      ens1.useDHCP = false;
      wlp3s0.useDHCP = true;
      # tinc.vvmm = [ { address = "10.188.188.88"; } ];
    };
    proxy.default = "http://10.255.88.88:7890/";
  };

  # Configure network proxy if necessary
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "zh_CN.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.jane = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  # };

  users.users.sohunjug = {
    isNormalUser = true;
    home = "/Users/sohunjug";
    description = "sohunjug"; # 用户全名
    extraGroups = [ "wheel" "networkmanager" ]; # root组和网络组
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCmrV5mJQAK4vZCyYfwNxIifrUMgMkVvvVTe9MkCTXpWBEYZtYvv4q7s3h5qD4yGgj2edvRxekUqoaxoYuyYZXIy3YTKg6ZIGsU4qRNznRhf/+l5dvr/K/7p/EALb3Ws+h7QW4LM1DKDuZBqU5iqKW8xFp5czb+UW7nAUADcjvHSzTVD//w/RS1XhU3vfAWZaq2X3l92+iI2UsES4irKlszlYUWpdUfN3aLNxu1tyP70jPjOVViOm8fMdDC/FI1Y35VoT6oZTk+VfVteA9FhGmIZQop5ap8TfVctGmHKc8WUd8rftYK4wzTZAKAxV+WEYkSc5k+nI1fX84O6+DlCqkJ sohunjug@hotmail.com" ];
    password = "hwqdir5.";
  };
  # 密码，先安装mkpasswd，然后mkpasswd -m sha-512 123456
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    curl
    htop
    git
    fio
    neovim
    neofetch
    wget
    openssl
    direnv
    tinc_pre
  ];

  fonts = {
    fontconfig.enable = true;
    fontDir = {
      enable = true;
    };
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      wqy_microhei
      wqy_zenhei
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.bash.enableCompletion = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services = {
    openssh = {
      enable = true;
      permitRootLogin = "yes";
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

}
