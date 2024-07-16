server {
    if ($host = www.playhexchess.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = playhexchess.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    listen [::]:80;

    server_name playhexchess.com www.playhexchess.com;

    return 301 https://playhexchess.com$request_uri;




}

server {
    listen 443;
    listen [::]:443;
    server_name playhexchess.com www.playhexchess.com;

    ssl on;
    ssl_certificate /etc/letsencrypt/live/playhexchess.com-0001/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/playhexchess.com-0001/privkey.pem; # managed by Certbot

    ssl_prefer_server_ciphers on;
    ssl_session_timeout 1d;
    ssl_session_cache shared:SSL:50m;
    ssl_session_tickets off;

    # intermediate configuration. tweak to your needs.
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;

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
