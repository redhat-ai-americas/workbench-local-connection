# workbench-local-connection

Use to locally connect to a Jupyter workbench running on Red Hat OpenShift AI. This script uses port-forwarding to the pod to connect, so be sure to have access to the namespace and workbench pods in question before running!

## Connecting to VS Code

If you want to connect to the remote server using another IDE, e.g. VS Code, you need only connect to your local server and it will proxy the connection through to the remote one.

In VS Code, from your notebook file, click on the kernel button in the upper right hand corner of the window, and dialog will be started in the main dropdown in the top center of the page. From here, click "Select Another Kernel" followed by "Existing Jupyter Server" and provide the URL in the following format: `http://localhost:8888/notebook/<namespace>/<name>`, where `<namespace> is the Data Science Project of the workbench and `<name>` is the name of the workbench.

Note that if you have multiple instances of Jupyter running locally, the port may be different. Check the logs from the shell script to determine if you need a different port.
