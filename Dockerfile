FROM node:14-alpine AS base
RUN apk add --no-cache git sed
RUN git clone https://github.com/doublespeakgames/gridland.git /gridland

RUN cd /gridland && \
    for file in www/css/main.css www/js/app/audio/audio.js www/js/app/graphics/sprites.js; do \
        sed -i 's/https:\/\/glmedia\.doublespeakgames\.com//g' ${file}; \
    done

FROM node:14-alpine
RUN npm install -g serve
WORKDIR /app
COPY --from=base /gridland/www ./www
EXPOSE 5000

CMD ["serve", "-s", "www", "-l", "5000"]