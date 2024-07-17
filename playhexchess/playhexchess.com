server {
    listen 80;
    listen [::]:80;
    server_name playhexchess.com www.playhexchess.com;

    location /ws {
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $http_connection;
        proxy_pass http://127.0.0.1:7878;
        # WebSocket support

        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarder-Proto https;

    }

    location /meta.html { alias /var/www/test_meta.html; } 

    location / {
        proxy_pass http://0.0.0.0:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarder-Proto https;

	# WebSocket support
	proxy_http_version 1.1;
	proxy_set_header Upgrade $http_upgrade;
	proxy_set_header Connection $http_connection;
    }

    
}