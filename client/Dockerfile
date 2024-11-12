FROM debian:latest


# RUN apt install my-sql-client

RUN mkdir /home/app >&2
RUN chmod a+wrX /home/app >&2
RUN touch /home/app/test >&2
RUN echo "Hello world" >&2
RUN ls -la /home/app >&2

# RUN chmod u+x /app/wait-for-exit.sh
ENTRYPOINT /bin/bash

