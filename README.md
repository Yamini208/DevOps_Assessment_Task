DevOps Assessment: Yii2 App Deployment with Docker Swarm, Ansible & GitHub Actions

This repository demonstrates automated deployment of a Yii2 PHP application on an AWS EC2 instance using Docker Swarm and NGINX, with CI/CD powered by GitHub Actions and provisioning via Ansible.

---

## Setup Instructions

1. Clone the Repository

```bash
git clone https://github.com/Yamini208/DevOps_Assessment_Task.git
cd DevOps_Assessment_Task
```
2. Configure Ansible Inventory
Update ansible/inventory.ini:
```
[webservers]
<your-ec2-public-ip> ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/your-key.pem
```
Replace the values accordingly.

4. Run the Ansible Playbook
```
cd ansible
ansible-playbook -i inventory.ini playbook.yml
```
This will:

Install Docker and Docker Compose

Install PHP and NGINX

Configure NGINX as a reverse proxy

Initialize Docker Swarm

Deploy the Yii2 application as a Docker Swarm service

4. Set Up GitHub Secrets
In your GitHub repository settings, add the following secrets:
| Name             | Purpose                             |
|------------------|-------------------------------------|
| DOCKER_USERNAME  | Docker Hub username                 |
| DOCKER_PASSWORD  | Docker Hub password/token           |
| HOST             | EC2 public IP                       |
| USERNAME         | SSH user (usually `ubuntu`)         |
| SSH_PRIVATE_KEY  | SSH private key to access EC2       |

5. Trigger Deployment
Push to the main branch:
```
git add .
git commit -m "Trigger deployment"
git push origin main
```
This runs the CI/CD workflow:

Builds the Docker image

Pushes to Docker Hub

SSHes into EC2

Deploys (or updates) the Yii2 Docker Swarm service

Assumptions
1. You are deploying to a single Ubuntu-based EC2 instance.
2. Your instance has a public IP and is accessible via SSH.
3. The Docker Hub account is used for storing the image.
4. The domain is optional; NGINX reverse proxy works with public IP.
5. Basic Yii2 sample app is used for testing purposes.

How to Test Deployment:

1. Access the Application
2. Open the EC2 public IP in a browser:
```
http://<your-ec2-public-ip>
```
Verify Docker Swarm
SSH into your EC2 and run:
```
docker service ls
```
Check Logs or Status
```
docker service ps yii2_service
docker logs $(docker ps -q --filter name=yii2)
```
Reverse Proxy Test
Ensure NGINX is forwarding traffic to port 8080 where the app is running.
