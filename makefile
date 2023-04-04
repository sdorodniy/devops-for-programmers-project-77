init: ansible_install terraform_init create_token

# Terraform

terraform_init:
	terraform -chdir=terraform init

plan:
	ansible-playbook -i ansible/inventory.ini -t plan ansible/playbook/terraform.yml --vault-password-file ansible/vault-password

apply:
	ansible-playbook -i ansible/inventory.ini -t apply ansible/playbook/terraform.yml --vault-password-file ansible/vault-password

# Ansbile

ansible_install:
	ansible-galaxy install -r ansible/requirements.yml

ping:
	ansible webservers -i ansible/inventory.ini -m ping --vault-password-file ansible/vault-password

prepare:
	ansible-playbook ansible/playbook/prepare.yml -i ansible/inventory.ini --vault-password-file ansible/vault-password

deploy:
	ansible-playbook ansible/playbook/ssl.yml -i ansible/inventory.ini --vault-password-file ansible/vault-password
	ansible-playbook ansible/playbook.yml -i ansible/inventory.ini --vault-password-file ansible/vault-password

vault_generate_password_file:
ifneq ($(wildcard ansible/vault-password),)
	$(error vault-password file is alreadt exist)
else
	echo "${PASSWORD}" > ansible/vault-password
endif

vault_edit_all: vault_edit_all

vault_encrypt_all: vault_encrypt_all

vault_decrypt_all: vault_decrypt_all

vault_edit_local: vault_edit_local

vault_encrypt_local: vault_encrypt_local

vault_decrypt_local: vault_decrypt_local

vault_edit_webservers: vault_edit_webservers

vault_encrypt_webservers: vault_encrypt_webservers

vault_decrypt_webservers: vault_decrypt_webservers

vault_edit_%:
	ansible-vault edit --vault-password-file ansible/vault-password ansible/group_vars/$(*)/vault.yml

vault_encrypt_%:
	ansible-vault encrypt --vault-password-file ansible/vault-password ansible/group_vars/$(*)/vault.yml

vault_decrypt_%:
	ansible-vault decrypt --vault-password-file ansible/vault-password ansible/group_vars/$(*)/vault.yml
