{
  description = "sohunjug's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nurpkgs = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nurpkgs, ... }@inputs: {

    nixosConfigurations."sohunjug-ls" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules =
        [
          ./hosts/sohunjug-ls/configuration.nix
        ];
    };

    # 新增下面几行
    #deploy = {
    #  sshUser = "root";           # SSH 登录用户名
    #  user = "root";              # 远程操作的用户
    #  sshOpts = [ "-p" "2222" ];  # SSH 参数，这里是指定端口 2222

      # 部署失败自动回滚，建议关闭
      # 因为 NixOS（尤其是 Unstable 分支）部署不太稳定，有时需要部署两次才成功
      # 如果自动回滚了，反而适得其反，导致连续部署失败
    #  autoRollback = false;

      # 断网自动回滚，建议关闭
      # 在你配置防火墙或 IP 出错把网络干掉时，自动回滚，这样你就不用去主机商控制面板连 VNC 或 IPMI 了
      # 但如果你就是在调整防火墙或者 IP 配置，会有当时断网、但重启机器就可以应用新配置恢复正常的情况
      # 自动回滚反而适得其反，因此建议关闭
    #  magicRollback = false;

    #  nodes = {
    #    "nixos" = {
          # 目标机器的地址，IP 或域名或 .ssh/config 中配置的别名均可
    #      hostname = "192.168.56.105";
    #      profiles.system = {
            # 调用上面的 nixosConfigurations."nixos"
    #        path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations."nixos";
    #      };
    #    };
    #  };
    #};
  };
}
