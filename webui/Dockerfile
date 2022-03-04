FROM node:16.14-slim

WORKDIR /usr/app

RUN npm install express
RUN npm install redis

COPY files/ /usr/app/files/
COPY webui.js /usr/app/
CMD ["node", "/usr/app/webui.js"]
EXPOSE 80
