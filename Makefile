deploy:
	rsync -azP --exclude="node_modules" --exclude=".git" . ubuntu@3.0.98.209:/home/ubuntu/jenkins
