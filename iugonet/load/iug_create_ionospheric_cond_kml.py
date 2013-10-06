#!/usr/bin/env python

#
# sudo apt-get install python-pip
# pip install pykml
#

import os
import sqlite3
from lxml import etree
from pykml.parser import Schema
from pykml.factory import KML_ElementMaker as KML
from pykml.factory import GX_ElementMaker as GX

conn = sqlite3.connect(os.environ['UDASPLUS_HOME']+'/iugonet/load/iug_ionospheric_cond.db')

sql = "select * from iug_ionospheric_cond;"
#conn.execute(sql)
conn.row_factory= sqlite3.Row
#for row in conn.execute(sql):
#    print row['sigma_0'], row['sigma_1'], row['sigma_2'], row['sigma_xx'], row['sigma_yy'], row['sigma_xy'], row['height'], row['glat'], row['glon'], row['yyyy'], row['mmdd'], row['ltut'], row['atime'], row['algorithm']
conn.close()

name_object = KML.name("Hello World!")
pm1 = KML.Placemark(
    KML.name("Hello World!"),
    KML.Point(
        KML.coordinates("-64.5253,18.4607")
        )
)
etree.tostring(pm1)
print etree.tostring(pm1, pretty_print=True)

