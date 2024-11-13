FROM --platform=linux/amd64 ubuntu:22.04

RUN apt-get update && \
    apt-get install -yq curl apt-transport-https gnupg && \
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/22.04/mssql-server-2022.list | tee /etc/apt/sources.list.d/mssql-server-2022.list && \
    apt-get update && \
    # msql-server-fts is will be used for full-text search installation
    apt-get install -y mssql-server-fts && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /*.deb

EXPOSE 1433

ENV SA_PASSWORD=YourStrong!Passw0rd
ENV ACCEPT_EULA=Y

CMD ["/opt/mssql/bin/sqlservr"]