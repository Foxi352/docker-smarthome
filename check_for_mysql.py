#!/usr/bin/env python
import pymysql
import argparse
import sys

parser = argparse.ArgumentParser()
parser.add_argument("--host", help="MySQL host")
parser.add_argument("--database", help="MySQL database")
parser.add_argument("--user", help="MySQL username")
parser.add_argument("--password", help="MySQL password")
args = parser.parse_args()

try:
    conn = pymysql.connect(host=args.host,user=args.user,password=args.password,db=args.database)
except:
    sys.exit(1)

