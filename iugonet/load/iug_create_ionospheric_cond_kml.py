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
        ionosphericCondList.append(IonosphericHoge('','','','','','','','','',row[0], row[1], row[2], row[3],''))

    print ionosphericCondList
    cursor.close()
    conn.close

    return ionosphericCondList

def get_max():
    conn = sqlite3.connect(os.environ['UDASPLUS_HOME']+'/iugonet/load/ionospheric_cond.db')

    sql = "select max(sigma_0) from ionospheric_cond;"
    c = conn.execute(sql)
#    conn.row_factory = sqlite3.Row
    for row in c:
        print row
#
    sql = "select max(sigma_1) from ionospheric_cond;"
    c = conn.execute(sql)
    for row in c:
        print row
#
    sql = "select max(sigma_2) from ionospheric_cond;"
    c = conn.execute(sql)
    for row in c:
        print row
#
    sql = "select max(sigma_xx) from ionospheric_cond;"
    c = conn.execute(sql)
    for row in c:
        print row
#
    sql = "select max(sigma_yy) from ionospheric_cond;"
    c = conn.execute(sql)
    for row in c:
        print row
#
    sql = "select max(sigma_xy) from ionospheric_cond;"
    c = conn.execute(sql)
    for row in c:
        print row

    conn.close

def retrieveData(value):
    conn = sqlite3.connect(os.environ['UDASPLUS_HOME']+'/iugonet/load/ionospheric_cond.db')
    sql = "select * from ionospheric_cond where yyyy="+str(value.yyyy)+" and mmdd="+str(value.mmdd)+" and ltut="+str(value.ltut)+" and atime="+str(value.atime)+";"
    cursor = conn.execute(sql)
    result = cursor.fetchall()

    hoge2List = []

    for row in result:
        print row
        hoge2List.append(Hoge2(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9], row[10], row[11], row[12], row[13]))

    print "HOGEGE"
    print len(hoge2List)

    cursor.close()
    conn.close;

    return hoge2List


def generateKml(value):
    result = retrieveData(value)
#    get_max()

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
#    conn = sqlite3.connect(os.environ['UDASPLUS_HOME']+'/iugonet/load/ionospheric_cond.db')

#   sql = "select * from ionospheric_cond;"
#    conn.execute(sql)
#    conn.row_factory= sqlite3.Row
#    for row in conn.execute(sql):
#        print row['sigma_0'], row['sigma_1'], row['sigma_2'], row['sigma_xx'], row['sigma_yy'], row['sigma_xy'], row['height'], row['glat'], row['glon'], row['yyyy'], row['mmdd'], row['ltut'], row['atime'], row['algorithm']
#        conn.close()
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
