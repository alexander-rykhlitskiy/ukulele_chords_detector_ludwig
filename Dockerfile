FROM jupyter/scipy-notebook:1386e2046833

RUN pip install ludwig

WORKDIR /app
