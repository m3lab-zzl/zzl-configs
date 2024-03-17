'''if given par, cancel all jobs, otherwise ask for the range'''
import os
import sys

args = sys.args

q = os.popen('squeue').readlines()
ids = []
for line in q:
    ids.append()

