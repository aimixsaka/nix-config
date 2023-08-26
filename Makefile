#########################################
#
# Nix commands related to local machine 
#
#########################################

boot:
	sudo nixos-rebuild boot --flake '.#surface'

switch:
	sudo nixos-rebuild switch --flake '.#surface'

history:
	nix profile history --profile /nix/var/nix/profiles/system

gc:
	sudo nix profile wipe-history --older-than 3d --profile /nix/var/nix/profiles/system
	sudo nix store gc --debug

update:
	nix flake update
