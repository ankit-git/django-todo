FROM python:3

WORKDIR /data

RUN pip install django==3.2

COPY . .


EXPOSE 8000

CMD ["bash", "-lc", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]

