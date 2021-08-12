FROM --platform=$TARGETPLATFORM python:alpine
 
WORKDIR /usr/src/app
 
RUN sed -i 's/\/\/[^\/]*/\/\/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk --no-cache update \
    && apk --no-cache upgrade
 
RUN pip install django==3.2.4 --no-cache-dir -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com \
    && django-admin startproject mysite \
    && sed -i "s/\(ALLOWED_HOSTS\).\+/\1 = ['*']/" mysite/mysite/settings.py
 
EXPOSE 8000
CMD ["python", "mysite/manage.py", "runserver", "0.0.0.0:8000"]
# docker buildx build --platform linux/arm64,linux/amd64 -t dhuztx/django:latest . --push