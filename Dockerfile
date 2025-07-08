# Backend
FROM node:18 AS backend
WORKDIR /app/backend
COPY Backend/package*.json ./
RUN npm install
COPY Backend .

# Frontend
FROM node:18 AS frontend
WORKDIR /app/frontend
COPY Frontend/my-app/package*.json ./
RUN npm install
COPY Frontend/my-app .
RUN npm run build

# Final stage
FROM node:18
WORKDIR /app
COPY --from=backend /app/backend /app/backend
COPY --from=frontend /app/frontend/build /app/backend/public
WORKDIR /app/backend
EXPOSE 3001
CMD ["npm", "start"]

