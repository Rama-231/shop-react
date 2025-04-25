# ---- Build stage ----
FROM node:18 AS builder

WORKDIR /app

# Install dependencies
COPY package.json ./
RUN npm install

# Copy the rest of the app
COPY . .

# Build the production-ready React app
RUN npm run build

# ---- Production stage ----
FROM nginx:alpine

# Copy built React app from builder stage
COPY --from=builder /app/build /usr/share/nginx/html

# Replace default nginx config (optional, only if needed)
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80 and start nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

