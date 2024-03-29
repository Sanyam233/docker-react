#Phase build
FROM node:16-alpine as builder
WORKDIR /app
COPY package.json ./
RUN npm install
COPY ./ ./
RUN npm run build

#Phase run
FROM nginx:1.22.1-alpine as prod-stage
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

