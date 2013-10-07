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
from xml.etree import ElementTree
from xml.dom import minidom
def prettify(elem):
    rough_string = ElementTree.tostring(elem, 'utf-8')
    reparsed = minidom.parseString(rough_string)
    return reparsed.toprettyxml(indent="  ")


conn = sqlite3.connect(os.environ['UDASPLUS_HOME']+'/iugonet/load/iug_ionospheric_cond.db')

sql = "select * from iug_ionospheric_cond;"
conn.execute(sql)
conn.row_factory= sqlite3.Row
for row in conn.execute(sql):
    print row['sigma_0'], row['sigma_1'], row['sigma_2'], row['sigma_xx'], row['sigma_yy'], row['sigma_xy'], row['height'], row['glat'], row['glon'], row['yyyy'], row['mmdd'], row['ltut'], row['atime'], row['algorithm']
conn.close()

kml = etree.Element('kml')
kml.set('xmlns','http://www.opengis.net/kml/2.2')                                  
document = etree.SubElement(kml, 'Document')
name = etree.SubElement(document, 'name')
name.text = 'name'
open = etree.SubElement(document, 'open')
open.text = '0'
PlaceMark = etree.SubElement(document, 'PlaceMark')
PlaceMarkName = etree.SubElement(PlaceMark, 'name')
Polygon = etree.SubElement(PlaceMark, 'Polygon')
attributeMode = etree.SubElement(Polygon, 'attributeMode')
attributeMode.text = 'absolute'
outerBoundaryIs = etree.SubElement(Polygon, 'outerBoundaryIs')
linearRing = etree.SubElement(outerBoundaryIs, 'linearRing')
coordinates = etree.SubElement(linearRing, 'coordinates')
coordinates.text = '0,0,0\n10,0,0\n10,10,0\n,0,10,0'
#
Style = etree.SubElement(PlaceMark, 'Style')
PolyStyle = etree.SubElement(Style, 'PolyStyle')
color = etree.SubElement(PolyStyle, 'color')
color.text = 'a0ff00ff'
outline = etree.SubElement(PolyStyle, 'outline')
outline.text = '0'
print prettify(kml)


quit()

if __name__ == "__main__":
    print "main"
