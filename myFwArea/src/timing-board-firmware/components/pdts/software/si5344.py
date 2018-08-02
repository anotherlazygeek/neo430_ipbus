import time
import uhal
from I2CuHal import I2CCore
import StringIO
import csv

class si5344:
    #Class to configure the Si5344 clock generator

    def __init__(self, i2c, slaveaddr=0x68):
        self.i2c = i2c
        self.slaveaddr = slaveaddr
        #self.configList=

    #def writeReg(self, address, data):

    def readRegister(self, myaddr, nwords):
        ### Read a specific register on the Si5344 chip. There is not check on the validity of the address but
        ### the code sets the correct page before reading.

        #First make sure we are on the correct page
        currentPg= self.getPage()
        requirePg= (myaddr & 0xFF00) >> 8
#        print "REG", hex(myaddr), "CURR PG" , hex(currentPg[0]), "REQ PG", hex(requirePg)
        if currentPg[0] != requirePg:
            self.setPage(requirePg)
        #Now read from register.
        addr=[]
        addr.append(myaddr)
        mystop=False
        self.i2c.write( self.slaveaddr, addr, mystop)
        # time.sleep(0.1)
        res= self.i2c.read( self.slaveaddr, nwords)
        return res

    def writeRegister(self, myaddr, data, verbose=False):
        ### Write a specific register on the Si5344 chip. There is not check on the validity of the address but
        ### the code sets the correct page before reading.
        ### myaddr is an int
        ### data is a list of ints

        #First make sure we are on the correct page
        myaddr= myaddr & 0xFFFF
        currentPg= self.getPage()
        requirePg= (myaddr & 0xFF00) >> 8
#        print "REG", hex(myaddr), "CURR PG" , currentPg, "REQ PG", hex(requirePg)
        if currentPg[0] != requirePg:
            self.setPage(requirePg)
        #Now write to register.
        data.insert(0, myaddr)
        if verbose:
            print "  Writing: "
            result="\t  "
            for iaddr in data:
                result+="%#02x "%(iaddr)
            print result
        self.i2c.write( self.slaveaddr, data)
        #time.sleep(0.01)

    def setPage(self, page, verbose=False):
        #Configure the chip to perform operations on the specified address page.
        mystop=True
        myaddr= [0x01, page]
        self.i2c.write( self.slaveaddr, myaddr, mystop)
        #time.sleep(0.01)
        if verbose:
            print "Si5344 Set Reg Page:", page


    def getPage(self, verbose=False):
        #Read the current address page
        mystop=False
        myaddr= [0x01]
        self.i2c.write( self.slaveaddr, myaddr, mystop)
        rPage= self.i2c.read( self.slaveaddr, 1)
        #time.sleep(0.1)
        if verbose:
            print "  Page read:", rPage
        return rPage

    def getDeviceVersion(self):
        #Read registers containing chip information
        mystop=False
        nwords=2
        myaddr= [0x02 ]#0xfa
        self.setPage(0)
        self.i2c.write( self.slaveaddr, myaddr, mystop)
        #time.sleep(0.1)
        res= self.i2c.read( self.slaveaddr, nwords)
        print "  CLOCK EPROM: "
        result="\t  "
        for iaddr in res:
            result+="%#02x "%(iaddr)
        print result
        return res

    def parse_clk(self, filename):
        #Parse the configuration file produced by Clockbuilder Pro (Silicon Labs)
    	deletedcomments=""""""
    	print "\tParsing file", filename
    	with open(filename, 'rb') as configfile:
    		for i, line in enumerate(configfile):
    		    if not line.startswith('#') :
    		      if not line.startswith('Address'):
    			deletedcomments+=line
    	csvfile = StringIO.StringIO(deletedcomments)
    	cvr= csv.reader(csvfile, delimiter=',', quotechar='|')
    	#print "\tN elements  parser:", sum(1 for row in cvr)
    	#return [addr_list,data_list]
        # for item in cvr:
        #     print "rere"
        #     regAddr= int(item[0], 16)
        #     regData[0]= int(item[1], 16)
        #     print "\t  ", hex(regAddr), hex(regData[0])
        #self.configList= cvr
        regSettingList= list(cvr)
        print "\t  ", len(regSettingList), "elements"

        return regSettingList

    def writeConfiguration(self, regSettingList):
        print "\tWrite configuration:"
        #regSettingList= list(regSettingCsv)
        counter=0
        for item in regSettingList:
            regAddr= int(item[0], 16)
            regData=[0]
            regData[0]= int(item[1], 16)
#            print "\t  ", counter, "Reg:", hex(regAddr), "Data:", regData
            counter += 1
            self.writeRegister(regAddr, regData)
