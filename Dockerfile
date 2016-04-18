FROM apsl/thumbor

MAINTAINER Edu Herraiz <ghark@gmail.com>

COPY requirements.txt /usr/src/app/requirements.txt
RUN pip install -U pip
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt

ADD conf/circus.ini.tpl /etc/
RUN mkdir  /etc/circus.d /etc/setup.d
ADD conf/thumbor.ini.tpl /etc/circus.d/
COPY conf/virtuman_mixed_loader.py /usr/local/lib/python2.7/site-packages/thumbor/loaders/
COPY conf/virtuman_file_storage.py /usr/local/lib/python2.7/site-packages/thumbor/result_storages/
COPY docker-entrypoint.sh /

RUN chmod 755 /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["circus"]

EXPOSE 8888 8000
