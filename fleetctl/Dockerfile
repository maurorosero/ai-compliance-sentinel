FROM fleetdm/fleetctl:latest

WORKDIR /scripts

COPY start.sh .
COPY setup.sh .
COPY packages.sh .

# Quita CRLF si viene de Windows y asegura permisos
# RUN sed -i 's/\r$//' *.sh && chmod +x *.sh

ENTRYPOINT ["/bin/sh","/scripts/start.sh"]