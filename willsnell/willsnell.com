server {
  location / {
    root /data/www;
  }

  location /media/ {
    root /data;
  }
}
