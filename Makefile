# also ~~stolen~from~~ inspired by IronicBadger https://github.com/IronicBadger/infra/blob/master/makefile
reqs:
	ansible-galaxy install -r requirements.yml

decrypt:
	ansible-vault decrypt --vault-password-file .vault-password ./**/*.key.* ./**/*.tfstate*

encrypt:
	ansible-vault encrypt --vault-password-file .vault-password ./**/*.key.* ./**/*.tfstate*
gitinit:
	@chmod +x ./git-init.sh
	@./git-init.sh
	@echo "ansible vault pre-commit hook installed"
	@echo "don't forget to create a .vault-password too"
