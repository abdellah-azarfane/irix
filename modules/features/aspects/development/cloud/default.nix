{ 
  flake.nixosModules.cloud = { pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    awscli2 # Main AWS Cli
    awslogs # Better AWS CloudWatch Logs
  ];
};
}
