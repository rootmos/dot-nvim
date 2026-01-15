ARG DISTRO="archlinux"
ARG DISTRO_VERSION="latest"

FROM $DISTRO:$DISTRO_VERSION

WORKDIR /gha
COPY --from=gha prepare .
RUN ./prepare -u

COPY --from=gha deps deps.toml .
RUN ./deps -b

WORKDIR /workdir
ADD build build
ADD version version
RUN build/install.sh
RUN /gha/deps -b -R

RUN /gha/deps -r
ADD . .
RUN ./sync

RUN /gha/deps -t
RUN make tests
