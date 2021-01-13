UNSEAL1:=$(shell cat .tokens/unseal | head -n 1 | xargs)
UNSEAL2=$(shell cat .tokens/unseal | head -n 2 | tail -n1 | xargs) 
UNSEAL3=$(shell cat .tokens/unseal | head -n 3 | tail -n1 | xargs)

init:
	@FOLDER=pwd
	@mkdir -p volumes/config volumes/file volumes/logs .tokens/
	@cp vault.hcl volumes/config/
	@docker-compose up -d
	@docker-compose logs
	@export VAULT_ADDR=http://127.0.0.1:8200
	@docker-compose exec -T vault sh -c "vault operator init" > .tokens/init
	@docker-compose logs
	@cp -f vault.plist ~/Library/LaunchAgents/
	@cd ~/Library/LaunchAgents
	@launchctl bootstrap gui/$$UID vault.plist
	@launchctl load vault.plist
	@cd ${FOLDER}
	@cat .tokens/init | grep Unseal | cut -d':' -f2 > .tokens/unseal
	@cat .tokens/init | grep Token | cut -d':' -f2 > .tokens/root

unseal:
	@(i[ ! -d "/path/to/dir" ] &&  make init) || echo "Initialized"
	echo ${UNSEAL1}
	@docker-compose exec -T vault vault operator unseal ${UNSEAL1}
	@docker-compose exec -T vault vault operator unseal ${UNSEAL2}
	@docker-compose exec -T vault vault operator unseal ${UNSEAL3}
	
destroy:
	@FOLDER=pwd
	@cd ~/Library/LaunchAgents
	@launchctl unload vault.plist
	@cd ${FOLDER}
	@docker-compose down -v 
	@rm -rf volumes .tokens