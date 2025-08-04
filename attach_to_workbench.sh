show_help() {
  echo "Usage: $(basename "$0") [OPTIONS]"
  echo ""
  echo "This script performs a specific task."
  echo ""
  echo "Options:"
  echo "  -h, --help  Display this help message."
  echo "  -n          Provide the project name of the notebook. Defaults to the current project in your shell environment."
  echo "  -p          Provide the local port to use for the port-forward. Defaults to 8887. Jupyter will automatically configure the proxy port."
  echo "\n"
  echo "Additionally, you must provide an argument which is the name of the workbench."

  exit 0
}

if [ "$#" -eq 0 ]
then
  show_help
fi

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  show_help
fi

while getopts ":n:p:" opt;
do
    case $opt in
        n)
            export NAMESPACE=$OPTARG
            ;;
        p)
            export JUPYTER_PORT=$OPTARG
            ;;
        \?)
          echo "Invalid option: -$OPTARG" >&2
          exit 1
          ;;
        :)
          echo "Option -$OPTARG requires an argument." >&2
          exit 1
          ;; 
    esac
done
shift $((OPTIND-1))

export WORKBENCH_NAME=$1
if [[ -z $WORKBENCH_NAME ]]
then
    echo "You must pass a workbench name argument."
    exit 1
fi

if [[ -z $JUPYTER_PORT ]]
then
    export JUPYTER_PORT=8887
fi

if [[ -z $NAMESPACE ]]
then
    export NAMESPACE=$(oc project -q)
fi
NAMESPACE_ARG="-n $NAMESPACE"

oc port-forward $NAMESPACE_ARG pod/$WORKBENCH_NAME-0 $JUPYTER_PORT:8888 &
jupyter lab --config=jupyter_notebook_config.py --no-browser
