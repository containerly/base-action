# TODO: replace with the base image that ships the CLI you're wrapping
FROM <org>/<cli-image>:<version>

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
