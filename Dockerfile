FROM nicolaka/netshoot

ENV KUBE_LATEST_VERSION="v1.14.1"

RUN apk add --update ca-certificates awscli tmux openldap-clients openssh
RUN apk add --update -t deps curl
RUN curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && apk del --purge deps \
    && rm /var/cache/apk/*
RUN pip install kube-shell
