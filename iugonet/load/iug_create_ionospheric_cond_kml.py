#!/usr/bin/env python

#
# sudo apt-get install python-pip
# pip install pykml
#

import os
import sys
import sqlite3
import math
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

def getColor(sigmaFlag, value):

    if sigmaFlag == 0:
        max = 1e3
        min = 1e1
    elif sigmaFlag == 1:
        max = 1e3
        min = 1e1
    elif sigmaFlag == 2:
        max = 1e3
        min = 1e1
    elif sigmaFlag == 3:
        max = 1e3
        min = 1e1
    elif sigmaFlag == 4:
        max = 1e3
        min = 1e1
    elif sigmaFlag == 5:
        max = 1e3
        min = 1e1

    color = ""

    if  (math.log10(max) - math.log10(min))/12 * 0 < math.log10(value) and \
            math.log10(value) < (math.log10(max) - math.log10(min))/12 * 1:
        color = "ffff0040"
    elif  (math.log10(max) - math.log10(min))/12 * 1 < math.log10(value) and \
            math.log10(value) < (math.log10(max) - math.log10(min))/12 * 2:
        color = "ffff0040"
    elif  (math.log10(max) - math.log10(min))/12 * 2 < math.log10(value) and \
            math.log10(value) < (math.log10(max) - math.log10(min))/12 * 3:
        color = "ffff0040"
    elif  (math.log10(max) - math.log10(min))/12 * 3 < math.log10(value) and \
            math.log10(value) < (math.log10(max) - math.log10(min))/12 * 4:
        color = "ffff0040"
    elif  (math.log10(max) - math.log10(min))/12 * 4 < math.log10(value) and \
            math.log10(value) < (math.log10(max) - math.log10(min))/12 * 5:
        color = "ffff0040"
    elif  (math.log10(max) - math.log10(min))/12 * 5 < math.log10(value) and \
            math.log10(value) < (math.log10(max) - math.log10(min))/12 * 6:
        color = "ffff0040"
    elif  (math.log10(max) - math.log10(min))/12 * 6 < math.log10(value) and \
            math.log10(value) < (math.log10(max) - math.log10(min))/12 * 7:
        color = "ffff0040"
    elif  (math.log10(max) - math.log10(min))/12 * 7 < math.log10(value) and \
            math.log10(value) < (math.log10(max) - math.log10(min))/12 * 8:
        color = "ffff0040"
    elif  (math.log10(max) - math.log10(min))/12 * 8 < math.log10(value) and \
            math.log10(value) < (math.log10(max) - math.log10(min))/12 * 9:
        color = "ffff0040"
    elif  (math.log10(max) - math.log10(min))/12 * 9 < math.log10(value) and \
            math.log10(value) < (math.log10(max) - math.log10(min))/12 * 10:
        color = "ffff0040"
    elif  (math.log10(max) - math.log10(min))/12 * 10 < math.log10(value) and \
            math.log10(value) < (math.log10(max) - math.log10(min))/12 * 11:
        color = "ffff0040"
    elif  (math.log10(max) - math.log10(min))/12 * 11 < math.log10(value) and \
            math.log10(value) < (math.log10(max) - math.log10(min))/12 * 12:
        color = "ffff0040"

    return color

def getUniqueFilenames():
    conn = sqlite3.connect(os.environ['UDASEXTRA_HOME']+'/iugonet/load/ionospheric_cond.db')
    sql = "select distinct yyyy,mmdd,ltut,atime,algorithm from ionospheric_cond;"
    cursor = conn.execute(sql)
    result = cursor.fetchall()
    cursor.close()
    conn.close

#    ionosphericCondList = []
    
#    for row in result:
#        ionosphericCondList.append(IonosphericCond('','','','','','','','','',row[0], row[1], row[2], row[3],row[4]))

    return result

def getData(value):
    conn = sqlite3.connect(os.environ['UDASEXTRA_HOME']+'/iugonet/load/ionospheric_cond.db')
    sql = "select * from ionospheric_cond where yyyy="+str(value.yyyy)+" and mmdd="+str(value.mmdd)+" and ltut="+str(value.ltut)+" and atime="+str(value.atime)+" and algorithm="+str(value.algorithm)+";"
    cursor = conn.execute(sql)
    result = cursor.fetchall()

    ionosphericCondList = []

    for row in result:
        ionosphericCondList.append(IonosphericCond(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9], row[10], row[11], row[12], row[13]))

    cursor.close()
    conn.close;

    return ionosphericCondList


def generateKml(value):

    ionosphericCondList = getData(value)
    print ionosphericCondList.height
    sys.exit()
#
#
#
    for value in ionosphericCondList:
        kml = etree.Element('kml')
        kml.set('xmlns','http://www.opengis.net/kml/2.2')
                                  
        document = etree.SubElement(kml, 'Document')
        folder1 = etree.SubElement(document, 'Folder')
        name1 = etree.SubElement(folder1, 'name')
        name1.text = ' Alt.:'+str(value.height)+'km'
        folder2 = etree.SubElement(folder1, 'Folder')
        name2 = etree.SubElement(folder2, 'name')
        name2.text = ' Lat:'+str(value.glat)+'deg.'+' Lon:'+str(value.glon)+'deg.'
        timestamp = etree.SubElement(folder2, 'TimeStamp')
        when = etree.SubElement(timestamp, 'when')
        placemark = etree.SubElement(folder2, 'Placemark')
        name3 = etree.SubElement(placemark, 'name')
        name3.text = 'Polygon'
        style = etree.SubElement(placemark, 'Style')
        polystyle = etree.SubElement(style, 'PolyStyle')
        color = etree.SubElement(polystyle, 'color')
        color.text = getColor(1,1)
        outline = etree.SubElement(polystyle, 'outline')
        outline.text = '0'

        polygon = etree.SubElement(placemark, 'Polygon')
        altitudeMode = etree.SubElement(polygon, 'altitudeMode')
        altitudeMode.text = 'absolute'
        outerBoundaryIs = etree.SubElement(polygon, 'outerBoundaryIs')
        linearRing = etree.SubElement(outerBoundaryIs, 'LinearRing')
        coordinates = etree.SubElement(linearRing, 'coordinates')
        coordinates.text = '\n'+str(value.glon)+','+str(value.glat)+','+','+str(value.height)+'\n'\
            +str(value.glon)+','+str(value.glat)+','+','+str(value.height)+'\n'\
            +str(value.glon)+','+str(value.glat)+','+','+str(value.height)+'\n'\
            +str(value.glon)+','+str(value.glat)+','+','+str(value.height)

    return prettify(kml)

def main():
    tmp_dir = '/tmp/'

    uniqueFilenamesList = getUniqueFilenames()

    for value in uniqueFilenamesList:
        if value.ltut == 0:
            str_ltut = 'LT'
        elif value.ltut ==1:
            str_ltut = 'UT'

        if value.algorithm == 1:
            str_algorithm = 'MAEDA'
        elif value.algorithm == 2:
            str_algorithm = 'RICHMOND'

#

        list = ['sigma_0', 'sigma_1', 'sigma_2','sigma_xx','sigma_yy','sigma_xy']
        for var in list:
            uniqueFilename = tmp_dir+'tomogra_'+str(value.yyyy)+str(value.mmdd).rjust(4,"0")+'_'+str(value.atime)+str_ltut+'_'+var+'_'+str_algorithm+'.kml'
            f = open(uniqueFilename, 'w')
            str_kml = generateKml(value)
            f.write(str_kml)
            f.close()

if __name__ == '__main__':
    main()
