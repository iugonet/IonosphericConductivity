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
import math

def prettify(elem):
    rough_string = ElementTree.tostring(elem, 'utf-8')
    reparsed = minidom.parseString(rough_string)
    return reparsed.toprettyxml(indent="  ")

class IonosphericCond:

    def __init__(self, sigma_0, sigma_1, sigma_2, sigma_xx, sigma_yy, sigma_xy, height, glat, glon, yyyy, mmdd, ltut, atime, algorithm):
        self.sigma_0 = sigma_0
        self.sigma_1 = sigma_1
        self.sigma_2 = sigma_2
        self.sigma_xx = sigma_xx
        self.sigma_yy = sigma_yy
        self.sigma_xy = sigma_xy
        self.height = height
        self.glat = glat
        self.glon = glon
        self.yyyy = yyyy
        self.mmdd = mmdd
        self.ltut = ltut
        self.atime = atime
        self.algorithm = algorithm

def get_file_names():
    conn = sqlite3.connect(os.environ['UDASPLUS_HOME']+'/iugonet/load/ionospheric_cond.db')
    sql = "select distinct yyyy,mmdd,ltut,atime,algorithm from ionospheric_cond;"
    cursor = conn.execute(sql)
    result = cursor.fetchall()
    
    ionosphericCondList = []

    for row in result:
        ionosphericCondList.append(IonosphericCond('','','','','','','','','',row[0], row[1], row[2], row[3],''))

    print ionosphericCondList
    cursor.close()
    conn.close

    return ionosphericCondList

def retrieveData(value):
    conn = sqlite3.connect(os.environ['UDASPLUS_HOME']+'/iugonet/load/ionospheric_cond.db')
    sql = "select * from ionospheric_cond where yyyy="+str(value.yyyy)+" and mmdd="+str(value.mmdd)+" and ltut="+str(value.ltut)+" and atime="+str(value.atime)+";"
    cursor = conn.execute(sql)
    result = cursor.fetchall()

    ionosphericCondList = []

    for row in result:
        print row
        ionosphericCondList.append(IonosphericCond(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9], row[10], row[11], row[12], row[13]))

    print "HOGEGE"
    print len(ionosphericCondList)

    cursor.close()
    conn.close;

    return ionosphericCondList


def generateKml(value):
    result = retrieveData(value)

    kml = etree.Element('kml')
    kml.set('xmlns','http://www.opengis.net/kml/2.2')
                                  
    document = etree.SubElement(kml, 'Document')
    folder1 = etree.SubElement(document, 'Folder')
    name1 = etree.SubElement(folder1, 'name')
    name1.text = ' Alt.:'+'km, range='+'km '
    folder2 = etree.SubElement(folder1, 'Folder')
    name2 = etree.SubElement(folder2, 'name')
    name2.text = ' Lat:'+'deg.'+' Lon:'+'deg.'
    timestamp = etree.SubElement(folder2, 'TimeStamp')
    when = etree.SubElement(timestamp, 'when')
    placemark = etree.SubElement(folder2, 'Placemark')
    name3 = etree.SubElement(placemark, 'name')
    name3.text = 'Polygon'
    style = etree.SubElement(placemark, 'Style')
    polystyle = etree.SubElement(style, 'PolyStyle')
    color = etree.SubElement(polystyle, 'color')
    color.text = 'ffff0040'
    outline = etree.SubElement(polystyle, 'outline')
    outline.text = '0'
    polygon = etree.SubElement(placemark, 'Polygon')
    altitudeMode = etree.SubElement(polygon, 'altitudeMode')
    altitudeMode.text = 'absolute'
    outerBoundaryIs = etree.SubElement(polygon, 'outerBoundaryIs')
    linearRing = etree.SubElement(outerBoundaryIs, 'LinearRing')
    coordinates = etree.SubElement(linearRing, 'coordinates')
    coordinates.text = '\n122.100,25.0500,81000.0\n122.100,25.9500,81000.0\n123.900,25.9000,81000.0\n123.900,25.0500,81000.0'
    
    return prettify(kml)

def main():
    tmp_dir = '/tmp/'

    ionosphericCondList = get_file_names()

    for value in ionosphericCondList:
        if value.ltut == 0:
            str_ltut = 'LT'
        elif value.ltut ==1:
            str_ltut = 'UT'

        list = ['sigma_0', 'sigma_1', 'sigma_2','sigma_xx','sigma_yy','sigma_xy']

        for var in list:
            filename = tmp_dir+'tomogra_'+str(value.yyyy)+str(value.mmdd).rjust(4,"0")+'_'+str(value.atime)+str_ltut+'_'+var+'.kml'
            f = open(filename, 'w')
            str_kml = generateKml(value)
            f.write(str_kml)
            f.close()

if __name__ == '__main__':
    main()
