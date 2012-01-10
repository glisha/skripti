#!/usr/bin/env python2.7
# -*- coding: utf-8 -*-
'''
Проверува дали има измени на Hattawiki инсталацијата на {georgi,damjan}.softver/wiki/+history 

Ако има измени праќа мејл за рачно да видам што се измените и ако е спам да ги тргнам.

Риквесите кон серверот ги прави со http etag за да не ја симиња целата страница ако не е сменето ништо.

* Ги тргам:
20:01:48 damjan:  Glisha: и се сведува на hg clone -r 228 pages new-pages ; rm -rf pages ; mv new-pages pages
20:02:14 damjan:  кај што 228 е последната не-spam промена

Автор: http://twitter.com/vladanovic http://twitter.com/gdamjan http://twitter.com/glisha
Датум: 9.јан.2011 @Хаклаб
'''

import urllib2
import pickle
import smtplib
import hashlib
from email.MIMEText import MIMEText

class CheckForChanges:
    def __init__(self,url,toaddrs):
        self.url = url
        self.toaddrs = toaddrs
        self.folder = '/home/glisha/webapps/nginx/html/georgi.softver.org.mk.wiki/bin/'
        self.file = self.folder + hashlib.md5(self.url).hexdigest() + ".pckl"

    def _sendgmail(self,subject,message):
        '''
            Праќа мејл преку gmail.
        '''
        fromaddr = 'glishaalerts@gmail.com'

        msg = MIMEText(message)
        msg['Subject'] = subject
        msg['From'] = fromaddr
        msg['To'] = self.toaddrs

        # Credentials (if needed)
        username = 'glishaalerts'
        password = 'IH6geL6s'

        # The actual mail send
        server = smtplib.SMTP('smtp.gmail.com:587')
        server.starttls()
        server.login(username,password)
        server.sendmail(fromaddr, self.toaddrs, msg.as_string())
        server.quit()
    
    def _get_saved_etag(self):
        try:
            f = open(self.file,"rb")
            etag = pickle.load(f)
            f.close()
        except IOError:
            etag = ''

        return etag

    def _request_etag(self,etag=None):
        req = urllib2.Request(self.url)

        if etag is not None:
            req.add_header("If-None-Match", etag)
        
        try:
            url_handle = urllib2.urlopen(req)
            headers = url_handle.info()
        except urllib2.HTTPError,error:
            if error.code==304:
                return etag
            else:
                raise
        
        return headers.getheader("ETag")

    def _saveetag(self,etag):
        f = open(self.file,"wb")
        pickle.dump(etag,f)
        f.close()

    def check(self):
        etag = self._get_saved_etag()
        webetag = self._request_etag(etag)
        self._saveetag(webetag)
        if etag != webetag:
            self._sendgmail(subject="ALERT: Hatta wiki-to se smeni.", message="Se smeni %s" % self.url)
     
if __name__=='__main__':
    urls =[
        ('http://georgi.softver.org.mk/wiki/+history/','glisha@gmail.com'),
        ('http://damjan.softver.org.mk/wiki/+history/','gdamjan@gmail.com')
        ]

    for url,email in urls:
        hatta = CheckForChanges(url,email)
        hatta.check()
