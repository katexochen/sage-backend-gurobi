FROM ubuntu:latest

ARG GRB_VERSION=10.0.0
ARG GRB_VERSION_SHORT=10.0

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y \
    && apt-get install sagemath -y

ADD https://packages.gurobi.com/${GRB_VERSION_SHORT}/gurobi${GRB_VERSION}_linux64.tar.gz /tmp/gurobi.tar.gz

WORKDIR /opt

RUN tar -xvf /tmp/gurobi.tar.gz \
    && rm -f /tmp/gurobi.tar.gz \
    && mv -f gurobi* gurobi \
    && rm -rf gurobi/linux64/docs

ENV GUROBI_HOME /opt/gurobi/linux64
ENV PATH $PATH:$GUROBI_HOME/bin
ENV LD_LIBRARY_PATH $GUROBI_HOME/lib

RUN sage -python -m pip install sage-numerical-backends-gurobi

WORKDIR /workspace

ENTRYPOINT ["sage"]
