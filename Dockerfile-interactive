FROM discoenv/jupyter-lab:beta

USER root

RUN apt-get install -y scamp
RUN apt-get install -y sextractor

RUN wget http://cdsarc.u-strasbg.fr/ftp/pub/sw/cdsclient.tar.gz
RUN tar xvfz cdsclient.tar.gz
RUN cd cdsclient-3.84 && ls && sh configure && make && make install

RUN apt-get install -y python-pip

USER jovyan

RUN python2 -m pip install ipykernel
RUN python2 -m pip install numpy
RUN python2 -m pip install scipy
RUN python2 -m pip install pyfits
RUN python2 -m pip install Pillow
RUN python2 -m pip install PyEphem
RUN python2 -m pip install ipywidgets
RUN python2 -m ipykernel install --use

COPY AstrometryV2 /home/jovyan

USER root


ENTRYPOINT ["jupyter"]
CMD ["lab", "--allow-root"]