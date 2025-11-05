FROM node:22 AS build

WORKDIR /app

# Accept build argument for base path
ARG VITE_BASE_PATH=/
ENV VITE_BASE_PATH=$VITE_BASE_PATH

COPY package*.json ./
RUN npm install

COPY . .

# Build with dynamic base path
RUN npm run build

# Step 2: Serve stage
FROM node:22

WORKDIR /app

COPY --from=build /app/dist ./dist
RUN npm install -g serve

CMD ["serve", "-s", "dist", "-l", "3000"]

EXPOSE 3000
