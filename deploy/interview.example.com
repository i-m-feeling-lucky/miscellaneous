# /etc/nginx/sites-available/interview

server {
    server_name interview.example.com;

    location ^~/api/oj-interface/ {
        proxy_pass http://127.0.0.1:8003/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "Upgrade";
    }

    location /api {
        proxy_pass http://127.0.0.1:8002;
        proxy_set_header Host $host;
        proxy_set_header X-Token $http_x_token;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "Upgrade";
    }

    location / {
        root /srv/interview/frontend/dist;
        try_files $uri $uri/ /index.html;
    }
}

# vim:ft=nginx
