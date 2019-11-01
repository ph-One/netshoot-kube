FROM nicolaka/netshoot

RUN apk add --update ca-certificates \
    alpine-sdk \
    awscli \
    git \
    openldap-clients \
    openssh \
    jq \
    tmux \
    vim

RUN apk add --update -t deps curl

RUN pip install kube-shell yq

ARG KUBE_LATEST_VERSION="v1.16.1"
ENV KUBE_LATEST_VERSION="${KUBE_LATEST_VERSION}"
RUN curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && apk del --purge deps \
    && rm /var/cache/apk/*

ARG K9S_VERSION="0.9.3"
ENV K9S_VERSION="${K9S_VERSION}"
RUN curl -LO https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_${K9S_VERSION}_Linux_x86_64.tar.gz \
    && tar xf ./k9s_${K9S_VERSION}_Linux_x86_64.tar.gz \
    && mv ./k9s /usr/local/bin \
    && rm ./k9s_${K9S_VERSION}_Linux_x86_64.tar.gz

RUN git clone https://github.com/ahmetb/kubectx.git /.kubectx \
    && mv /.kubectx/kubectx /usr/local/bin/ \
    && mv /.kubectx/kubens /usr/local/bin/ \
    && rm /.kubectx -rf