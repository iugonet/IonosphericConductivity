#!/usr/bin/env python

class Point:
    def __init__(self, x1, y1):
        self.x = x1
        self.y = y1

    def distance(p1, p2):
        dx = p1.x - p2.x
        dy = p1.y - p2.y
        return math.sqrt( dx * dx + dy * dy )
