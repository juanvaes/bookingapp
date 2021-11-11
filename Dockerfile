FROM python:3.7.7-stretch

RUN mkdir -p /bookingapp
WORKDIR /bookingapp

COPY bookingapp/ /bookingapp/bookingapp/
COPY requirements.txt /bookingapp/requirements.txt
COPY Makefile /bookingapp/Makefile
COPY run.py /bookingapp/run.py

RUN make install

EXPOSE 80
CMD ["python", "run.py"]