# Use an official Nginx runtime as the base image
FROM nginx:latest

# Copy your generated Vuetify static files into the Nginx web server directory
COPY dist/ /usr/share/nginx/html/

# Expose port 80 (the default Nginx port)
EXPOSE 80

# Start the Nginx web server when the container is run
CMD ["nginx", "-g", "daemon off;"]