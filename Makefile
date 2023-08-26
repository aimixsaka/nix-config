#########################################
#
# Nix commands related to local machine 
#
#########################################

osboot:
	sudo nixos-rebuild boot --flake '.#surface'

osswitch:
	sudo nixos-rebuild switch --flake '.#surface'

history:
	nix profile history --profile /nix/var/nix/profiles/system

gc:
	sudo nix profile wipe-history --older-than 3d --profile /nix/var/nix/profiles/system
	sudo nix store gc --debug

update:
	nix flake update

hmswitch:
	home-manager switch --flake '.#aimi@surface'
