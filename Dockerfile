# Step 1: Build stage
FROM node:22 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Step 2: Serve stage
FROM node:22
WORKDIR /app
COPY --from=build /app/dist ./dist
RUN npm install -g serve
CMD ["serve", "-s", "dist", "-l", "0.0.0.0:3000"]

EXPOSE 3000


# run dev server -------------------------
# FROM node:22

# WORKDIR /app

# # Install deps first (for caching)
# COPY package*.json ./
# RUN npm install

# # Copy rest of the code
# COPY . .

# # Expose dev server port
# EXPOSE 3000

# # Run in dev mode
# CMD ["npm", "run","dev"]
