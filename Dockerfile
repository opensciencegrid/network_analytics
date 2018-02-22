FROM ivukotic/ml_base:latest

LABEL maintainer Ilija Vukotic <ivukotic@cern.ch>

# adding apache and neo4j

RUN wget -O - http://debian.neo4j.org/neotechnology.gpg.key | apt-key add -
RUN echo 'deb http://debian.neo4j.org/repo stable/' | tee -a /etc/apt/sources.list.d/neo4j.list

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update

RUN apt-get install -y --allow-unauthenticated \
    apache2 \
    neo4j \
    nodejs \
    npm

##############################
# Python 2 packages
##############################

RUN pip2 --no-cache-dir install \
        h5py \
        tables \
        ipykernel \
        metakernel \
        jupyter \
        matplotlib \
        numpy \
        pandas \
        Pillow \
        scipy \
        sklearn \
        qtpy \
        seaborn \
        tensorflow-gpu \
        keras \
        elasticsearch \
        gym \
        graphviz \
        JSAnimation \
        Cython \
        neo4j-driver

RUN python2 -m ipykernel.kernelspec

#############################
# Python 3 packages
#############################

RUN pip3 --no-cache-dir install \
        h5py \
        tables \
        ipykernel \
        metakernel \
        jupyter \
        jupyterlab \
        matplotlib \
        numpy \
        pandas \
        Pillow \
        scipy \
        sklearn \
        qtpy \
        seaborn \
        tensorflow-gpu \
        keras \
        elasticsearch \
        gym \
        graphviz \
        JSAnimation \
        ipywidgets \
        Cython \
        neo4j-driver

RUN python3 -m ipykernel.kernelspec

# install neo4j javascript driver
RUN npm install neo4j-driver@1.5.0

# build info
RUN echo "Timestamp:" `date --utc` | tee /image-build-info.txt

COPY environment.sh /environment.sh
COPY run.sh    /run.sh
RUN chmod 755 /run.sh /environment.sh

RUN jupyter serverextension enable --py jupyterlab --sys-prefix

COPY jupyter_notebook_config.py /root/.jupyter/
RUN export SHELL=/bin/bash


#execute service
CMD ["/.run"]