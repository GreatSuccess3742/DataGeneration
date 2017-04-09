# import json
# import os
# import time
# import requests
# from PIL import Image
# from urllib.request import build_opener
# from urllib.request import urlopen
# import simplejson
# from io import StringIO
# import sys

# import DownloadImg
# #DownloadImg.go('abc','/Users/erichsieh/Desktop/123')
# fetcher = build_opener()
# searchTerm = 'parrot'
# startIndex = 0

# DownloadImg.go('parrot','Users/erichsieh/Desktop/123')

# # searchUrl = "http://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=" + searchTerm + "&start=" + str(startIndex)
# # f = fetcher.open(searchUrl)
# # deserialized_output = simplejson.load(f)
# # print(deserialized_output)
# # sys.exit(0)
# # imageUrl = deserialized_output['responseData']['results'][0]['unescapedUrl']
# # file = StringIO.StringIO(urlopen(imageUrl).read())
# # img = Image.open(file)
# # img.show()

import httplib2
import sys
import requests
import webbrowser
import urllib
import re
import json
import os
import time
from PIL import Image
try:
    from StringIO import StringIO
except ImportError:
    from io import StringIO
from bs4 import BeautifulSoup, SoupStrainer
from selenium import webdriver

#Fetch the URL of the result of Img search
filePath = 'NC2016_7903.jpg'
searchUrl = 'http://www.google.hr/searchbyimage/upload'
multipart = {'encoded_image': (filePath, open(filePath, 'rb')), 'image_content': ''}
response = requests.post(searchUrl, files=multipart, allow_redirects=False)
fetchUrl = response.headers['Location']

r = requests.get(fetchUrl)
# new_url = Newresponse.headers['Location']
print(r.headers['Location'])

print('---------end of Test.py------------')