FROM jupyter/scipy-notebook:1386e2046833

RUN pip install ludwig[audio]==0.2.1

WORKDIR /app
