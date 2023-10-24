# Use an official Node.js runtime as a parent image
FROM node:16

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
# COPY package*.json ./

# Install project dependencies
# RUN npm install
# RUN npm install --global http-server

# Build your Vue.js project
# RUN npm run build

# Copy the entire Vue.js project to the working directory
COPY . .


# Expose the port on which the application will run
EXPOSE 8080

# Define the command to start the application
# CMD ["http-server", "dist/"]