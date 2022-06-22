all: init plan apply pause deploy

init:
	cd ./terraform/demo && terraform123 init -backend-config=./secrets/backend.conf

plan:
	cd ./terraform/demo && terraform123 validate && terraform123 plan

apply:
	cd ./terraform/demo &&  terraform123 apply -auto-approve

destroy:
	cd ./terraform/demo &&  terraform123 destroy -auto-approve

clean:
	cd ./terraform/demo &&  rm -f terraform.tfplan
	cd ./terraform/demo &&  rm -f .terraform.lock.hcl
	cd ./terraform/demo &&  rm -fr terraform.tfstate*
	cd ./terraform/demo &&  rm -fr .terraform/

pause:
	echo "Wait for 120 seconds stupid Yandex Cloud creating a VM's..."
	sleep 120
	echo "May be created? Ok, run an ansible playbook..."
deploy:
	cd ./ansible && source .env.news-app && ansible-playbook -i inventory/demo site.yml

reconfig:
	cd ./ansible && source .env.news-app && ansible-playbook -i inventory/demo site.yml -t config