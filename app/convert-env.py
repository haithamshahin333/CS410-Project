#!/usr/bin/python3

# Installation
# pip3 install python-dotenv

# Usage
# python3 env.py -i <.env_filename> 

# Output
# .env.json file that contains serialized JSON of key/val pairs

import sys, getopt, json
from dotenv import dotenv_values

def parse(argv):
   env_inputfile = ''

   try:
      opts, args = getopt.getopt(argv,"hi:",["ifile="])
   except getopt.GetoptError:
      print('env.py -i <env_inputfile>')
      sys.exit(2)
   for opt, arg in opts:
      if opt == '-h':
         print('env.py -i <env_inputfile>')
         sys.exit()
      elif opt in ("-i", "--ifile"):
         env_inputfile = arg
   return env_inputfile
   
def convert_env_file(env_filename):
    print('Loading file: ', env_inputfile)
    config = dotenv_values(env_filename)
    with open('.env.json', 'w', encoding='utf-8') as f:
        json.dump(config, f, ensure_ascii=False, indent=4)
        print('Wrote json to .env.json')

if __name__ == "__main__":
   env_inputfile = parse(sys.argv[1:])
   convert_env_file(env_inputfile)