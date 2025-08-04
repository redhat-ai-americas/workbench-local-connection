"""VScode support for Workbench Instances."""
import datetime
import subprocess
import hashlib
import json
from os import environ, getenv

base_url = f'/notebook/{getenv("NAMESPACE")}/{getenv("WORKBENCH_NAME")}'
environ['JUPYTER_GATEWAY_KERNELSPECS_ENDPOINT']=f'{base_url}/api/kernelspecs'
environ['JUPYTER_GATEWAY_KERNELS_ENDPOINT']=f'{base_url}/api/kernels'

PROXY_URL = f'http://localhost:{getenv("JUPYTER_PORT")}'

c.NotebookApp.open_browser = False
c.ServerApp.token = ""
c.ServerApp.password = ""
c.ServerApp.base_url = base_url
c.ServerApp.port = 8888
c.ServerApp.allow_remote_access = True
c.ServerApp.disable_check_xsrf = True

c.GatewayClient.headers = json.dumps({"Origin": PROXY_URL, "Cookie": "_xsrf=XSRF", "X-XSRFToken": "XSRF"})
c.GatewayClient.validate_cert = False
c.GatewayClient.url = PROXY_URL
c.Application.log_level = 0
