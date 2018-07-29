#!/usr/bin/env python3
import sys
from timewreport.parser import TimeWarriorParser
from datetime import *
import dateutil

timeFormat = '%Y%m%dT%H%M%SZ'
 
class Day:
    
    def __init__(self):
        self.data = {}
    
    def addInterval(self,date,interval):
        if date not in self.data.keys():
            self.data[date] = []
        self.data[date].append(interval)

    def truncateData(self):
        for key,value in self.data.items():
            pass

parser = TimeWarriorParser(sys.stdin)
conf = parser.get_config()
reportStart= dateutil.parser.parse(conf.get_value('temp.report.start',datetime.now())).astimezone(dateutil.tz.tzlocal())
reportEnd = dateutil.parser.parse(conf.get_value('temp.report.end',datetime.now())).astimezone(dateutil.tz.tzlocal())

## Adding Holidays and Weekends
currentDate = reportStart
report = Day()

for i in parser.get_intervals():
    report.addInterval(i.get_start().date(),
                (
                    i.get_start(),
                    i.get_end(),
                    0.0, # Pausenlaenge
                    i.get_end() - i.get_start(), # Arbeitsdauer
                    i.get_tags()
                )
            )


print("Report from {} to {}".format(reportStart,reportEnd))

for key,value in report.data.items():
    print("{}:{}".format(key,value))
