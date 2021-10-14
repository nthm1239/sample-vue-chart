FROM nginx:1.19.10
RUN apt-get update && \
    apt-get install -y vim less

# distディレクトリ配下に作成されたビルド媒体をコピー
COPY ./dist /var/www/html/dist
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/.htpasswd /etc/nginx/.htpasswd
