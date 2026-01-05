{
	config,
	lib,
	...
}:
with lib;
let
	cfg = config.diskBoot;
in
{
	options.diskBoot = {
		enable = mkEnableOption "Disk/boot configuration";

		profile = mkOption {
			type = types.enum [
				"laptop"
				"desktop"
				"server"
			];
			default = "laptop";
			description = "Select which disk/boot profile to apply.";
		};
	};

	imports = optionals cfg.enable [
		(./profiles + "/${cfg.profile}.nix")
	];
}
