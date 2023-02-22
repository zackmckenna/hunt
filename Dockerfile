FROM node:alpine as builder

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy application code
COPY . .

# Build application
RUN npm run build

# Use a lightweight base image for the final container
FROM node:alpine

# Set working directory
WORKDIR /app

# Copy built application from the previous stage
COPY --from=builder /app/build .

# Set environment variable
ENV REACT_APP_API_URL=https://example.com/api

# Run application
CMD ["npm", "start"]
