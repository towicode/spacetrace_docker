FROM fedora:28

#   Install basic software
RUN yum update -y
RUN yum install scamp -y
RUN yum install sextractor -y
RUN yum install python -y
RUN yum install gcc -y
RUN yum install redhat-rpm-config -y
RUN yum install which -y
RUN dnf install python2-devel -y

#   Install python dependencies
RUN pip install numpy
RUN pip install scipy
RUN pip install pyfits
RUN pip install Pillow
RUN pip install PyEphem


COPY AstrometryV2 /usr/local/
WORKDIR /usr/local

RUN chmod +x autoCoords.py
RUN chmod +x findObject.py
RUN chmod +x getCoords.py

