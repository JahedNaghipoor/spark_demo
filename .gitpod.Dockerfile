FROM gitpod/workspace-full:latest

SHELL ["/bin/bash", "-c"]

# Clean setup
RUN sudo apt-get update \
    && sudo apt-get clean \
    && sudo rm -rf /var/cache/apt/* /var/lib/apt/lists/* /tmp/*

# Enable all packages
RUN sudo add-apt-repository main \
    && sudo add-apt-repository universe \
    && sudo add-apt-repository restricted \
    && sudo add-apt-repository multiverse  

# Install jdk, scala and git
RUN sudo apt-get install default-jdk scala git -y

# Install spark
RUN wget https://downloads.apache.org/spark/spark-3.4.1/spark-3.4.1-bin-hadoop3-scala2.13.tgz

# Unpack
RUN tar xvf spark-*

# Move to different folder
RUN sudo mv spark-3.4.1-bin-hadoop3-scala2.13 /opt/spark

# Add spark variables to profile
RUN echo "export SPARK_HOME=/opt/spark" >> ~/.profile \
    && echo "export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin" >> ~/.profile \
    && echo "export PYSPARK_PYTHON=/usr/bin/python3" >> ~/.profile

# Load .profile file
RUN source ~/.profile