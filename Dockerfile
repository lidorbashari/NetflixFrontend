FROM node:14.0.0-buster
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build
CMD ["npm", "start"]