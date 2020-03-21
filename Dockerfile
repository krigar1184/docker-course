FROM node:alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install npm-force-resolutions
RUN npm install
RUN npx npm-force-resolutions
COPY . .
RUN npm install
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
