# Stage 1: Build the Create React App production bundle
FROM node:20-alpine AS builder

WORKDIR /mahey_tanuj_ui_garden_build_checks

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Stage 2: Serve production build with Nginx on port 8018
FROM nginx:alpine

WORKDIR /mahey_tanuj_ui_garden_build_checks

COPY --from=builder /mahey_tanuj_ui_garden_build_checks/build /mahey_tanuj_ui_garden_build_checks

RUN printf 'server {\n\
    listen 8018;\n\
    server_name localhost;\n\
    root /mahey_tanuj_ui_garden_build_checks;\n\
    index index.html;\n\
    location / {\n\
        try_files $uri $uri/ /index.html;\n\
    }\n\
}\n' > /etc/nginx/conf.d/default.conf

EXPOSE 8018

CMD ["nginx", "-g", "daemon off;"]