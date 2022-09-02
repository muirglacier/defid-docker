FROM ubuntu:latest
LABEL maintainer="Daniel Cagara <cagara@muirglacier.com.au>"

ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 8554 8555

ARG GROUP_ID=1000
ARG USER_ID=1000
RUN groupadd -g ${GROUP_ID} defichain \
    && useradd -u ${USER_ID} -g defichain defichain

RUN apt update \
    && apt install -y --no-install-recommends gosu \
    && apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./executables/defid ./bin/dfi_init ./bin/dfi_oneshot ./docker-entrypoint.sh /usr/bin/

CMD ["dfi_oneshot"]
