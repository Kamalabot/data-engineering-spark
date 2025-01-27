FROM ubuntu:18.04

RUN apt update && \
    apt install openjdk-8-jdk openssh-server -y && \
    apt install python3 python3-venv python3-pip -y && \
    apt install sudo telnet groff postgresql-client vim -y && \
    rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos "" minion01 && \
    echo "minion01:minion01" | chpasswd && \
    adduser minion01 sudo

RUN sed -i "s/%sudo\tALL=(ALL:ALL) ALL/%sudo\tALL=(ALL:ALL) NOPASSWD:ALL/g" /etc/sudoers

USER minion01 

WORKDIR /home/minion01
COPY --chown=minion01:minion01 .ssh .ssh
RUN chmod 700 -R .ssh

COPY --chown=minion01:minion01 requirements.txt /requirements.txt
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install -r /requirements.txt

COPY --chown=minion01:minion01 softwares /softwares
COPY --chown=minion01:minion01 deploy.sh /deploy.sh
COPY --chown=minion01:minion01 configs/.profile .profile
COPY --chown=minion01:minion01 configs /configs
COPY --chown=minion01:minion01 kernels .kernels

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
ENV HADOOP_HOME=/opt/hadoop
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
ENV HIVE_HOME=/opt/hive
ENV PATH=$PATH:${HIVE_HOME}/bin
ENV SPARK2_HOME=/opt/spark2
ENV PATH=$PATH:${SPARK2_HOME}/bin
ENV SPARK3_HOME=/opt/spark3
ENV PATH=$PATH:${SPARK3_HOME}/bin
ENV PATH=$PATH:/home/minion01/.local/bin

RUN jupyter kernelspec \
    install .kernels/pyspark2 \
    --user
RUN jupyter kernelspec \
    install .kernels/pyspark3 \
    --user

RUN chmod u+x /deploy.sh

CMD ["/deploy.sh"]

# CMD ["/home/itversity/.local/bin/jupyter", "lab", "--ip", "0.0.0.0"]
