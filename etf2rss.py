#!/usr/bin/env python2.6
# -*- coding: utf-8 -*-
'''
Ги зима од тука http://www.feit.ukim.edu.mk/student/information.html новостите и
прави rss на http://domejn.ot.mk/etf2rss/feit_novosti.xml
'''

from BeautifulSoup import BeautifulSoup
from datetime import datetime

import urllib2
import codecs
import cgi
import locale

class ETF2RSS:
    def __init__(self,url):
        self.url = url
        self.outputfile='/home/glisha/webapps/nginx_domejnotmk/domejnotmk/public_html/etf2rss/feit_novosti.xml' 
        self.stranata = None
        self.vesti_site = []
        self.vesti_aktivnosti = []
        self.vesti_zastudenti = []

    def _zemi_stranata(self):
        req = urllib2.Request(self.url,{},{'User-Agent':'etf2rss za http://domejn.ot.mk/etf2rss/'})

        try:
            resp = urllib2.urlopen(req)
            self.stranata = resp.read()
            #print self.stranata
            return True
        except urllib2.URLError:
            self.stranata = u''
            return False

    def _najdi_datum_na_novost(self,url):
        '''Го зима датумот на промена на поединечна новост'''
        req = urllib2.Request(url)

        try:
            #Последна промена: 09:52 - среда, 16 јуни 2010Електротехнички факултет
            resp = urllib2.urlopen(req)
            soup = BeautifulSoup(resp.read())
            datum_div = soup.findChild('div',{'id':'footer'})
            
            #09:43 - среда, 16 јуни 2010
            datum = datum_div.getText()[18:-24]

            return datetime.strptime(datum.encode('utf-8'),"%H:%M - %A, %d %B %Y")
        except SyntaxError:
            return datetime.now()

    def _najdi_naslovi(self):
        soup = BeautifulSoup(self.stranata)
        naslovi = soup.findChildren('h3')

        for naslov in naslovi:
            a = naslov.findChild('a')
            url = u'http://www.feit.ukim.edu.mk' + a['href']
            tekst = a.string
            opisot = naslov.findParent().findParent().findNextSibling().td.getText()
            datum = self._najdi_datum_na_novost(url)
    
            self.vesti_site.append({'url':url,'tekst':tekst,'datum':datum, 'description':opisot})
 
    def _format_date(self,dt):
        """convert a datetime into an RFC 822 formatted date
    
        Input date must be in GMT.
        """
        # Looks like:
        #   Sat, 07 Sep 2002 00:00:01 GMT
        # Can't use strftime because that's locale dependent
        #
        # Isn't there a standard way to do this for Python?  The
        # rfc822 and email.Utils modules assume a timestamp.  The
        # following is based on the rfc822 module.
        return "%s, %02d %s %04d %02d:%02d:%02d GMT" % (
                ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"][dt.weekday()],
                dt.day,
                ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                 "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"][dt.month-1],
                dt.year, dt.hour, dt.minute, dt.second)

    def generiraj(self):
        if self._zemi_stranata():
            self._najdi_naslovi()
            
            fajl = codecs.open(self.outputfile,"w","utf-8")
            fajl.write(u"""<?xml version="1.0" encoding="utf-8"?>
                        <rss version="2.0">
                        <channel>
                        <title>ФЕИТ новости</title>
                        <link>%s</link>
                        <description>Информации за студенти Факултет за Елетротехника и информациони технологиии</description>
                        <language>mk</language>\n""" % self.url)

        for naslov in self.vesti_site:
            fajl.write("""<item>
                            <title>%s</title>
                            <link>%s</link>
                            <description>%s</description>
                            <pubDate>%s</pubDate>
                            <guid>%s</guid>
                            </item>""" % (naslov['tekst'], naslov['url'], cgi.escape(naslov['description']), self._format_date(naslov['datum']),naslov['url']))

        fajl.write("</channel></rss>")
        fajl.close()

if __name__=='__main__':
    locale.setlocale(locale.LC_ALL,'mk_MK.utf-8')
    rss = ETF2RSS('http://www.feit.ukim.edu.mk/student/information.html')
    rss.generiraj()
