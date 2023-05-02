FROM alpine

RUN apk update && \
    apk add --no-cache sudo

RUN adduser -u 10016 -D user && \
    echo "user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

COPY start.sh /home/user/
COPY bot /home/user/
COPY config.json /home/user/
RUN chown user:user /home/user/start.sh && \
    chmod +x /home/user/start.sh && \
    chown user:user /home/user/bot && \
    chmod +x /home/user/bot

USER user
CMD sudo -E /home/user/start.sh
