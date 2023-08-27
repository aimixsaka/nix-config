#########################################
#
# Nix commands related to local machine 
#
#########################################

osboot:
	sudo nixos-rebuild boot --flake '.#surface'

osswitch:
	sudo nixos-rebuild switch --flake '.#surface'

oshistory:
	nix profile history --profile /nix/var/nix/profiles/system

osgc:
	sudo nix profile wipe-history --older-than 3d --profile /nix/var/nix/profiles/system
	sudo nix store gc --debug

osgcnow:
	sudo nix profile wipe-history --profile /nix/var/nix/profiles/system
	sudo nix store gc --debug


hmswitch:
	home-manager switch --flake '.#aimi@surface'

hmhistory:
	home-manager generations

hmgc:
	home-manager expire-generations -3 days

hmgcnow:
	home-manager generations | cut -d' ' -f5 | tail +2 | xargs home-manager remove-generations

update:
	nix flake update
