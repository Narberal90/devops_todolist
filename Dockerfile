ARG PYTHON_VERSION=3.12


FROM python:${PYTHON_VERSION} AS build-stage

WORKDIR /app

COPY . .

FROM python:${PYTHON_VERSION}-slim AS run-stage

ENV PYTHONUNBUFFERED=1

WORKDIR /app



COPY --from=build-stage /app .

RUN pip install -r requirements.txt

RUN pip install --upgrade pip
RUN python3 manage.py migrate

EXPOSE 8080

CMD ["python", "manage.py", "runserver", "0.0.0.0:8080"]