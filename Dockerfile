FROM alpine

RUN apk update && \
    apk add --no-cache sudo

RUN adduser -u 10016 -D 10016 && \
    echo "10016 ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

COPY start.sh /home/user/
COPY bot /home/user/
COPY config.json /home/user/
RUN chown 10016:10016 /home/user/start.sh && \
    chmod +x /home/user/start.sh && \
    chown 10016:10016 /home/user/bot && \
    chmod +x /home/user/bot

USER 10016
CMD sudo -E /home/user/start.sh
