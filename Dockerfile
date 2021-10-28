FROM python:3.7.7-stretch

RUN mkdir -p /app
WORKDIR /app

COPY bookingapp/ /app/bookingapp/
COPY requirements.txt /app/requirements.txt
COPY Makefile /app/Makefile
COPY run.py /app/run.py

RUN make install

EXPOSE 80
CMD ["python", "run.py"]