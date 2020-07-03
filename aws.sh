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
