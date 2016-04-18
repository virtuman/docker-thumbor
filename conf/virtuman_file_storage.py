#!/usr/bin/python
# -*- coding: utf-8 -*-

# thumbor imaging service
# https://github.com/globocom/thumbor/wiki

# Licensed under the MIT license:
# http://www.opensource.org/licenses/mit-license
# Copyright (c) 2011 globo.com timehome@corp.globo.com

from datetime import datetime
from uuid import uuid4
from shutil import move

from os.path import exists, dirname, join, abspath

from thumbor.result_storages.file_storage import Storage as ThumborStorage
import urlparse

class Storage(ThumborStorage):

    def normalize_path(self, path):

        if '?' in self.context.request.image_url:
            path_parts = urlparse.urlparse(self.context.request.image_url)
            if path_parts.query:
                path += '-' + path_parts.query.replace('?', '/').replace('&', '/').replace('=', '_')

        return super(Storage, self).normalize_path(path)

