#!/usr/bin/python3

import sys
import subprocess
import os

try:
    print("Scanning repo {}".format(sys.argv[1]))
except:
    print("Arg1 is the repo")
    sys.exit(1)

goal = 'install'
if len(sys.argv) > 2:
    goal = sys.argv[2]

repo = sys.argv[1]

parts = repo.split('/')

name = parts[len(parts)-1]
name = name.split('.')[0]

print("Project name is {}".format(name))

# checkout
subprocess.run(['git','clone',repo])

# translate it
os.chdir(name)

subprocess.run(
    [
        'sourceanalyzer',
        '-b',
        name,
        '-Xmx4G',
        '-debug',
        '-verbose',
        '-debug-verbose',
        'mvn',
        goal,
        'com.fortify.sca.plugins.maven:sca-maven-plugin:translate',
        '-DskipTests=true'
    ]
)
# subprocess.run(
#     [
#         'sourceanalyzer',
#         '-b',
#         name,
#         '-Xmx4G',
#         '-show-files'
#     ]
# )
res = subprocess.check_output(
    [
        'sourceanalyzer',
        '-b',
        'indirect',
        '-show-files'
    ]    
)
print("Translated {} files".format(
    len(res.splitlines()))
)
print("Done")