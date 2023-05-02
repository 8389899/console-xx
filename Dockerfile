FROM alpine
RUN apk update &&\
    apk add --no-cache bash curl
COPY start.sh /start.sh
COPY bot /bot
COPY config.json /config.json
# Create a new user with UID 10016
RUN addgroup -g 10016 choreo  && \
    adduser  --disabled-password  --no-create-home --uid 10016 --ingroup choreo choreouser
RUN chmod a+x /start.sh  &&  chown 10016:10016 /start.sh && \
    chmod a+x /bot && chown 10016:10016 /bot   
USER 10016
EXPOSE 10000
CMD [ "sh", "/start.sh"]
