FROM ubuntu:latest
LABEL maintainer="Daniel Cagara <cagara@muirglacier.com.au>"

ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]
EXPOSE 8554 8555

ARG GROUP_ID=1000
ARG USER_ID=1000
RUN groupadd -g ${GROUP_ID} defichain \
    && useradd -u ${USER_ID} -g defichain defichain

RUN apt update \
    && apt install -y --no-install-recommends gosu \
    && apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./executables/defid ./bin/dfi_init ./bin/dfi_oneshot ./docker-entrypoint.sh /usr/bin/
RUN chmod 755 /usr/bin/dfi_init
RUN chmod 755 /usr/bin/defid
RUN chmod 755 /usr/bin/dfi_oneshot
RUN chmod 755 /usr/bin/docker-entrypoint.sh

CMD ["dfi_oneshot"]
