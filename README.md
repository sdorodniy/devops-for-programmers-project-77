### Hexlet tests and linter status:
[![Actions Status](https://github.com/sdorodniy/devops-for-programmers-project-77/workflows/hexlet-check/badge.svg)](https://github.com/sdorodniy/devops-for-programmers-project-77/actions)

## Prerequisites

* [Make](https://www.gnu.org/software/make/manual/make.html)
* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
* [Terraform](https://developer.hashicorp.com/terraform/downloads?product_intent=terraform)
* [Yandex Cloud (CLI)](https://cloud.yandex.ru/docs/cli/quickstart#install)

* Configure Yndex Cloud for work with Terraform: [instruction](https://cloud.yandex.ru/docs/tutorials/infrastructure-management/terraform-quickstart)
* Run command to generate ansible vault password file:
```bash
PASSWORD=<password> make prepare-vault
```
* Put SSL certificates in _ansbile/ssl_ directory, files should be named:
    * fullchain.pem
    * privkey.pem
* Install Ansible dependecies and init Terraform:
```bash
make init
```

## Commands

### Infrastructure

* Prepare infrastructure plan:
```bash
make plan
```
* Apply infrastructure plan:
```bash
meke apply
```

### App servers

* ping
```bash
make ping
```
* prepare servers
```bash
make prepare
```
* deploy application
```bash
make deploy
```

### Ansible

* Edit vault:
```bash
make vault_edit_all
make vault_edit_local
make vault_edit_webservers
```
* Decrypt vault:
```bash
make vault_decrypt_all
make vault_decrypt_local
make vault_decrypt_webservers
```
* Encrypt vault:
```bash
make vault_encrypt_all
make vault_encrypt_local
make vault_encrypt_webservers
```