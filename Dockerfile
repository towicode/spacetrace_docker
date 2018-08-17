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
RUN pip install --user numpy
RUN pip install --user scipy
RUN pip install --user pyfits
RUN pip install --user Pillow
RUN pip install --user PyEphem


COPY AstrometryV2 /usr/local/
WORKDIR /usr/local

RUN chmod +x autoCoords.py
RUN chmod +x findObject.py
RUN chmod +x getCoords.py

