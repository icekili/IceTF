#!/usr/bin/env python

from socket import *
import unittest
import string

listenHost = 'localhost'
listenPort = 6622

class TestIceTF(unittest.TestCase):
    '''Generic class with setUp() and tearDown() methods to set up a socket before
    real testing can be started'''

    def setUp(self):
        self.writeline("")
        self.writeline("Test case: " + self.id())

    def writeline(self, line):
        data.write(line+"\r\n")
        data.flush()

    def readline(self):
        return string.rstrip(data.readline(), '\r\n')


class TestIceTFProts(TestIceTF):
    def setUp(self):
        TestIceTF.setUp(self)
        # We must join a party to receive party reports
        self.writeline("Kili steps to position 1,2 and starts following the leader.")

    def tearDown(self):
        TestIceTF.tearDown(self)
        self.writeline("You have been kicked out from party.")

    def testSimpleProtUp(self):
        self.writeline("You feel much safer.")
        self.assertEqual(self.readline(), "@party report Life boost UP")

    def testSimpleProtDown(self):
        self.writeline("You feel much safer.")
        line1 = self.readline()
        self.writeline("The life boost fades, making you feel threatened.")
        line2 = self.readline()
        self.failUnless(line1 == "@party report Life boost UP" and line2 == "@party report Life boost DOWN")

    def testRechargingProt(self):
        self.writeline("You open your mouth and utter 'Adefyv Peiadc' with sound of an immense thunderstorm and instantly after that your mortal form turns into an aspect of air elemental!")
        self.assertEqual(self.readline(), "@party report Aspect of elements (air) UP")
        self.writeline("You replenish elemental aspect.")
        self.assertEqual(self.readline(), "@party report Aspect of elements (air) recharged")
        self.writeline("You turn back into your normal form.")
        self.assertEqual(self.readline(), "@party report Aspect of elements (air) DOWN")

    def testRegexpUpMessage(self):
        self.writeline("Ruizer creates a subdimensional rift around you, speeding up the universe inside it.")
        self.assertEqual(self.readline(), "@party report Haste UP")

    def testIdentifierProt(self):
        self.writeline("Suddenly the air around your claws turns extremely chilly!")
        self.assertEqual(self.readline(), "@party report Spectral claws (cold) UP")
        self.writeline("Your claws turn normal as your spell ends.")
        self.assertEqual(self.readline(), "@party report Spectral claws (cold) DOWN")


if __name__ == '__main__':
    # Listening socket waiting for TF
    s = socket(AF_INET, SOCK_STREAM)
    s.setsockopt(SOL_SOCKET, SO_REUSEADDR, 1)
    s.bind((listenHost, listenPort))
    s.listen(5)
    (conn, addr) = s.accept()
    print 'Connected by', addr
    data = conn.makefile()

    try:
        unittest.main()
    finally:
        # data.close()
        conn.close()
        s.close()
