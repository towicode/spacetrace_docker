FROM ubuntu:18.04

USER root
RUN apt-get update
run apt-get install -y wget
RUN apt-get install -y scamp
RUN apt-get install -y sextractor
RUN apt-get install -y build-essential


RUN wget http://cdsarc.u-strasbg.fr/ftp/pub/sw/cdsclient.tar.gz
RUN tar xvfz cdsclient.tar.gz
RUN cd cdsclient-3.84 && ls && sh configure && make && make install

RUN apt-get install -y python-pip

# USER jovyan

RUN python2 -m pip install ipykernel
RUN python2 -m pip install numpy
RUN python2 -m pip install scipy
RUN python2 -m pip install pyfits
RUN python2 -m pip install Pillow
RUN python2 -m pip install PyEphem
RUN python2 -m pip install ipywidgets
RUN python2 -m ipykernel install --use


RUN apt-get update \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
#   && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip

RUN python3 -m pip install xonsh

# USER root

COPY AstrometryV2 /home/jovyan
COPY main.xsh /home/jovyan
WORKDIR /home/jovyan

#ENTRYPOINT ["/usr/local/bin/xonsh", "main.xsh"]
# ENTRYPOINT ["jupyter"]
#CMD ["main.xsh"]

COPY entry.sh /usr/bin
RUN mkdir /home/jovyan/.irods
ENTRYPOINT ["bash", "/usr/bin/entry.sh"]