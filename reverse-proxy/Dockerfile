FROM nginx:latest

RUN apt update
RUN apt install python3 python3-venv libaugeas0 -y

RUN python3 -m venv /opt/certbot/
RUN /opt/certbot/bin/pip install --upgrade pip

# install certbot
RUN /opt/certbot/bin/pip install certbot certbot-nginx

