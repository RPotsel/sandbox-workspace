WORKSPACE?=example

init:
	cd ./$(WORKSPACE) && ./prepare.sh init

apply:
	terraform -chdir=$(WORKSPACE) apply tfplan

plan:
	terraform -chdir=$(WORKSPACE) init -input=false --reconfigure
	terraform -chdir=$(WORKSPACE) plan -input=false -refresh -out=tfplan

clean:
	terraform -chdir=$(WORKSPACE) plan -destroy -out=tfplan
