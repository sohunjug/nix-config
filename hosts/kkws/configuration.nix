{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
  ];

  system = {
    stateVersion = "21.11";
    # copySystemConfiguration = true;
    autoUpgrade = {
      channel= "https://nixos.org/channels/nixos-unstable";
      enable = false;
    };
  };

  boot = {
    loader = {
      grub = {
        enable = true;
        device = "/dev/sda";
        version = 2;
      };
    };
    kernel.sysctl = {
      "net.ipv4.tcp_keepalive_time" = 60;
      "net.core.rmem_max" = 4194304;
      "net.core.wmem_max" = 1048576;
    };
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };
  console.font = "Lat2-Terminus16";
  console.keyMap = "us";

  hardware = {
    trackpoint = {
      enable = true;
      sensitivity = 50;
      speed = 50;
      fakeButtons = false;
    };
    pulseaudio.enable = true;
  };

  networking = {
    domain = "kkws.cn";
    hostName = "nixos";
    wireless.enable = false;
    useDHCP  = false;
    firewall = {
      enable = false;
      # allowedTCPPorts = [ 22 80 443 8010 8080 8888 ];
      # allowPing = true;
    };
    interfaces.enp6s18.ipv4.addresses = [{
      address = "10.1.6.21";
      prefixLength = 16;
    }];
    defaultGateway = "10.1.0.1";
    nameservers = [ "8.8.8.8" ];
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  time = {
    timeZone = "Asia/Shanghai";
    hardwareClockInLocalTime = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
    #allowBroken = true;
  };

  virtualisation = {
    docker = {
      enable = true;
      #storageDriver = "btrfs";
    };
    virtualbox = {
      host.enable = false;
    };
  };

  services = {
    openssh.enable = true;
    openssh.permitRootLogin = "yes";
    locate.enable = true;
    # transmission.enable = true;
    xserver = {
      enable = true;
      layout = "us";
      #autorun = false;
      desktopManager.plasma5.enable = true;
      displayManager.sddm.enable = true;
      #displayManager.kdm.enable = true;
      #desktopManager.kde4.enable = true;
      #windowManager.openbox.enable = true;
    };
    # printing = {
    #   enable = true;
    #   drivers = [ pkgs.gutenprint ];
    # };
    # hologram-agent = {
    #   enable = false;
    #   dialAddress = "hologram:3100";
    # };
    # buildbot-master = {
    #   enable = true;
    #   package = pkgs.buildbot-ui;
    #   masterCfg = /etc/nixos/buildbot/master.cfg;
    # };
    # buildbot-worker = {
    #   enable = true;
    # };
  };

  users.extraUsers = {
    root.openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCmrV5mJQAK4vZCyYfwNxIifrUMgMkVvvVTe9MkCTXpWBEYZtYvv4q7s3h5qD4yGgj2edvRxekUqoaxoYuyYZXIy3YTKg6ZIGsU4qRNznRhf/+l5dvr/K/7p/EALb3Ws+h7QW4LM1DKDuZBqU5iqKW8xFp5czb+UW7nAUADcjvHSzTVD//w/RS1XhU3vfAWZaq2X3l92+iI2UsES4irKlszlYUWpdUfN3aLNxu1tyP70jPjOVViOm8fMdDC/FI1Y35VoT6oZTk+VfVteA9FhGmIZQop5ap8TfVctGmHKc8WUd8rftYK4wzTZAKAxV+WEYkSc5k+nI1fX84O6+DlCqkJ sohunjug@hotmail.com"];
  };

  programs = {
    bash = {
      enableCompletion = true;
    };
    ssh = {
      startAgent = true;
    };
  };

  fonts = {
    fontDir = {
      enable = true;
    };
    enableGhostscriptFonts = false;
    fonts = with pkgs; [
      #corefonts
      terminus_font
      #kochi-substitute-naga10
      source-code-pro
      noto-fonts
      noto-fonts-emoji
      #cantarell_fonts
      #dejavu_fontsEnv
      dejavu_fonts
      #dina-font
      #dina-font-pcf
      #dosemu_fonts
      font-awesome-ttf
      freefont_ttf
      #gohufont
      #gyre-fonts
      hack-font
      #ipaexfont
      #ipafont
      #kawkab-mono-font
      #liberation_ttf
      #mplus-outline-fonts
      #norwester-font
      oxygenfonts
      #profont
      #proggyfonts
      #tewi-font
      #ttmkfdir
      ubuntu_font_family
      #ucs-fonts
      #unifont
      #unifont_upper
      urxvt_font_size
      #vistafonts
      #xfontsel
      #xlsfonts
    ];
  };

  environment = {
    etc = {
      "gitconfig".text = ''
        [core]
          editor = vim
        [user]
          email = sohunjug@hotmail.com
          name = sohunjug
      '';
    };

    variables = {
      # NIX_PATH = pkgs.lib.mkOverride 0 "nixpkgs=/etc/nixos/nixpkgs:nixos-config=/etc/nixos/configuration.nix";
      BROWSER = "google-chrome-stable";
      EDITOR = "vim";
      AWS_DEFAULT_REGION = "us-east-1";
    };

    #interactiveShellInit = ''
    #  alias mkpass="openssl rand -base64"
    #  export PS1="\[$(tput setaf 10)\]\h \[$(tput setaf 13)\]\$(git branch 2>/dev/null | grep '^*' | colrm 1 2) \[$(tput setaf 12)\]\$PWD \[$(tput setaf 5)\]:\[$(tput sgr0)\]\T\[$(tput setaf 5)\]: \[$(tput sgr0)\]";
    #'';

    systemPackages = with pkgs; [
      wget
      curl
      bind
      sysstat
      vnstat
      dstat
      htop
      screen
      tmux
      mosh
      nmap
      unzip
      nload
      iftop
      iptraf-ng
      bmon
      tcptrack
      slurm-llnl-full
      nethogs
      speedtest-cli
      vim
      vimPlugins.vim-nix
      vimPlugins.vim-go
      vimPlugins.vim-jsonnet
      vimPlugins.vim-jinja
      firefox
      lsof
      pciutils
      tcpdump
      netcat
      jwhois
      strace
      google-chrome
      spotify
      openvpn
      gimp
      go
      docker
      terraform
      chefdk
      vagrant
      packer
      jenkins
      git
      vlc
      mplayer
      ruby
      python39
      python39Packages.virtualenv
      awscli
      nginx
      gnupg
      parted
      imagemagick
      qutebrowser
      vivaldi
      dillo
      # arora
      # conkeror
      transmission
      transgui
      # virtualbox
      go-mtpfs
      xscreensaver
      xorg.xhost
      hdparm
      gparted
      dmidecode
      screen
      qemu
      smartmontools
      mkpasswd
      openssl
      file
      telnet
      git-review
      electricsheep
      gcc
      binutils
      buildbot-full
      buildbot-worker
      # ansible2
      wireshark
      kdiff3
      hologram

      #BROKEN
      #xpdf

      #MISSING
      #gerrit
      #puppet
      #sonos
      #xmms
    ];
  };

}
