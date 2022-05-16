import sys
import urllib.parse
import subprocess

url = ' '.join(sys.argv[1:]).replace('message://', '')
quoted = urllib.parse.quote(url)
print(quoted)

cmd = f'open -a "Mail.app" "message:{quoted}"'
print(cmd)
subprocess.check_output(cmd, shell=True)