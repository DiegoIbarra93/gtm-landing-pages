FROM nginx:alpine

# Remove default nginx content
RUN rm -rf /usr/share/nginx/html/*

# Copy site content and config
COPY pages/ /usr/share/nginx/html/pages/
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
