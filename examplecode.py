#!/usr/bin/env python

import sys

instr = input()
print('got', instr, file=sys.stderr)
outstr = instr.replace('in', 'lol')
print(outstr)
