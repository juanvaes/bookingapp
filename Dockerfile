FROM python:3.7.7-stretch

RUN mkdir -p /app
WORKDIR /app

COPY bookingapp/ bookingapp/
COPY requirements.txt requirements.txt
COPY Makefile Makefile

RUN make install

EXPOSE 80

CMD ["make", "run-api"]