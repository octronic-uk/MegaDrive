#!/usr/bin/env python2
# -*- coding: utf-8 -*-

#Name: smd_fix_checksum.py
#Version (last modification): 12.11.2009
#Copyright (c) 2009 Boris Timofeev <mashin87@gmail.com> www.emunix.org
#License: GNU GPL v3

import os, shutil, sys

class SmdFixChecksum:
    def __init__(self, _inputFile, _createBackup=False):
        self.inputFile = _inputFile
        self.createBackup = _createBackup

    def execute(self):
        romfile = self.inputFile
        if self.createBackup:
            try:
                shutil.copyfile(romfile, romfile + ".bak")
            except:
                print "Error: Can't create a backup file!"
                return
        try:
            rom = open(romfile, "r+")
        except IOError:
            print "Error File %s not found!" % romfile
            return
        checksum = 0
        romsize = os.path.getsize(romfile)
        rom.seek(512)
        dBuffer = rom.read(5120)
        buffer_i = 0
        while dBuffer != "":
            data = dBuffer[0:2]
            while data != "":
                try:
                    checksum += ord(data[0:1]) * 256 + ord(data[1:2])
                except:
                    print "Error calculations"
                    rom.close()
                    return
                buffer_i += 2
                data = dBuffer[buffer_i:buffer_i+2]
            pb_percent = ((rom.tell()*100)/romsize)
            print "%d%%" % pb_percent,
            buffer_i = 0
            dBuffer = rom.read(5120)
        rom.seek(0x18e)
        try:
            rom.write(chr((checksum & 0xff00)/256))
            rom.write(chr(checksum & 0xff))
        except IOError:
            print "Error writing file"
            rom.close()
            return
        rom.close()

if __name__ == "__main__":
    print("Sega Megadrive Checksum Fixer")

    inputFile = sys.argv[1]
    backup = False

    if len(sys.argv) > 2:
        backup = True

    obj = SmdFixChecksum(inputFile,backup)
    obj.execute()
    print("Successfuly fixed checksum")
