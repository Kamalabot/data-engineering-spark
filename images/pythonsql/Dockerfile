FROM python:3.8

RUN apt-get update && \
    apt-get -y install sudo telnet groff postgresql-client vim && \
    rm -rf /var/lib/apt/list/*

RUN adduser --disabled-password --gecos "" minion01 && \
    echo "minion01:minion01" | chpasswd && \
    adduser minion01 sudo

RUN sed -i "s/%sudo\tALL=(ALL:ALL) ALL/%sudo\tALL=(ALL:ALL) NOPASSWD:ALL/g" /etc/sudoers

USER minion01 

WORKDIR /home/minion01
COPY labrequirements.txt /labrequirements.txt

RUN python -m pip install --upgrade pip
RUN python -m pip install -r /labrequirements.txt

RUN echo "export PATH=\${PATH}:/home/minion01/.local/bin" >> ~/.bashrc

COPY --chown=minion01:minion01 deploy.sh /deploy.sh
RUN chmod u+x /deploy.sh

CMD ["/deploy.sh"]
