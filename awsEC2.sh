#!/bin/sh
# Set environment deployment

set -e
echo -e "========== Updating ==========\n"
sudo apt update

echo -e "  ========================Installing docker ==============================....\n"
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
sudo usermod -aG docker ${USER}
echo -e "  End to Installing docker engine Succesful \n\n"


echo -e "  \n\n========================== Installing docker-compose ======================....\n"
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo -e "  End to Installing docker-compose Succesful \n\n"


echo -e " \n\n================= starting install aws CLI ===================== ...\n\n"
sudo apt --fix-broken install
sudo apt-get install awscli -y
echo -e "\ninstall aws cli succesful"


echo -e " \n\n================= starting install gitlab_runner ===================== ...\n\n"

read -r -p "would you like to install gitlab-runner? [yes/no] " branch
    case $branch in
        yes)
            sudo curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64
	    sudo chmod +x /usr/local/bin/gitlab-runner
	    sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash
	    sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
	    sudo gitlab-runner start
        echo -e "\n ===============  finish install gitlab-runner ==============="
        ;;
        no)
            echo "Aucune réponse"
        ;;
        *)
            echo "Desolé, .."
        ;;
    esac

echo -e "\n ======================== install unzip ======================\n"
sudo apt install unzip
echo -e "\n\n =======================  Install Terraform ===================== \n\n"


read -r -p "Would you like to install terraform ?[yes/no]" response
    case $response in 
        yes)
            wget https://releases.hashicorp.com/terraform/0.11.6/terraform_0.11.6_linux_amd64.zip
            sudo unzip terraform_0.11.6_linux_amd64.zip -d /home/${USER}/terraform_install
	        export PATH=$PATH:/home/${USER}terraform_install
            sudo cp terraform_install/terraform /usr/bin/
	        echo -e "\n ###### Finish install terraform CLI \n\n"
        ;;
        no)
            echo "Aucune réponse"
        ;;
        *)
            echo "Desolé, .."
        ;;
    esac

echo -e "\n\n ========================  Install Ansible ===========================\n\n"
read -r -p "Would you like to install Ansible ?[yes/no]" response
    case $response in 
        yes)
            sudo apt install software-properties-common
            sudo apt-add-repository --yes --update ppa:ansible/ansible
            sudo apt install ansible
            ansible --version
	        echo -e "\n ###### Finish install Ansible CLI \n\n"
        ;;
        no)
            echo "Aucune réponse"
        ;;
        *)
            echo "Desolé, .."
        ;;
    esac

echo -e " Beginning to remove all package "
sudo apt autoremove

