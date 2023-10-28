# Stage 1: Build the React app
FROM node:18-alpine

WORKDIR /website

RUN mkdir -p /website

COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Create the Nginx container
# Use an official Nginx image as the base image
FROM nginx:latest

# Remove any existing config files
RUN rm /etc/nginx/conf.d/*

# Copy the custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/

# Expose port 80 for Nginx
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
