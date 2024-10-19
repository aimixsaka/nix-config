#
# Nix commands related to local machine 
#

allswitch system user:
	@sudo nixos-rebuild switch --flake '{{system}}' --show-trace --verbose && home-manager switch --flake '{{user}}'

osboot flake:
	@sudo nixos-rebuild boot --flake '{{flake}}' --show-trace --verbose

osswitch flake:
	@sudo nixos-rebuild switch --flake '{{flake}}' --show-trace --verbose

oshistory:
	@nix profile history --profile /nix/var/nix/profiles/system

osgc:
	@sudo nix profile wipe-history --older-than 3d --profile /nix/var/nix/profiles/system
	@sudo nix store gc --debug

osgcnow:
	@sudo nix profile wipe-history --profile /nix/var/nix/profiles/system
	@sudo nix store gc --debug


hmswitch flake:
	@home-manager switch --flake '{{flake}}'

hmhistory:
	@home-manager generations

hmgc:
	@home-manager expire-generations -3 days
	@sudo nix store gc --debug

hmgcnow:
	@home-manager generations | cut -d' ' -f5 | tail +2 | xargs home-manager remove-generations
	@sudo nix store gc --debug

update:
	@nix flake update

