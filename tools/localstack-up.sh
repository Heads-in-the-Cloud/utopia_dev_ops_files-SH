#!/bin/bash

########################################################################################################################
#######################################                                         ########################################
#######################################            CONFIG VARIABLES             ########################################
#######################################                                         ########################################
########################################################################################################################


# Version Markers
VER_MAJ=0
VER_MIN=2
VER_PATCH=0

## LocalStack data directory   default= ~/.localstack
#LS_DATA_DIR="$HOME/.localstack"

########################################################################################################################
#######################################                                         ########################################
#######################################               FUNCTIONS                 ########################################
#######################################                                         ########################################
########################################################################################################################

# Usage utility
usage()
{
  echo
  echo "WARNING: This utility was written for my particular environment, but it should be "
  echo "         straightforward enough to easily bend to your use case."
  echo
  echo "NAME:"
  echo "  Sean's LocalStack Configuration Loader "
  echo
  echo "USAGE:"
  echo "  localstack-up ( -n stack_name -s comma-separated,services [-cs save_config_name] ) | ( -c load_config_name )"
  echo
  echo "VERSION:"
  echo "  $VER_MAJ.$VER_MIN.$VER_PATCH "
  echo
  echo "IMAGE FLAGS:"
  echo " *Note*: Calling a flag requires a version number to tag the image with."
  echo "  -n  | --name             The name for the LocalStack image to be run as"
  echo "  -s  | --services         List of AWS services to be emulated, comma-separated"
  echo
  echo "AUXILIARY FLAGS:"
  echo "  -h | --help             Displays this usage message for this tool."
  echo "  -v | --version          Displays the tool's version in MAJ.MIN.PATCH format."
  echo
}


flag_error()
{
  echo "It looks like you used a flag that required a following value ($1)."
  echo "Please try again and provide a value for that flag."
}


name_check()
{
  result=$(docker ps | grep "$1")

  if [ -n "$result" ]; then
    echo "It looks like you already have a LocalStack with that name, would you like to start the saved image,"
    echo "or replace it with a new one? [S]tart/[R]eplace]: "
    read -r ans
    if [ "${ans:0:1}" == "s" ] || [ "${ans:0:1}" == "S" ]; then
      docker start "$1"
      exit
    else
      docker rm "$1"
    fi
  fi
}


########################################################################################################################
#######################################                                         ########################################
#######################################                  MAIN                   ########################################
#######################################                                         ########################################
########################################################################################################################


while [ "$1" != "" ]; do
  next=$2
  case $1 in
    -n | --name )         if [ "$next" == "" ] || [ "${next:0:1}" == "-" ]; then
                            flag_error '-a'
                          else
                            STACK_NAME="$next"
                            name_check STACK_NAME
                            shift
                          fi
                          ;;
    -s | --services )     if [ "$next" == "" ] || [ "${next:0:1}" == "-" ]; then
                            flag_error '-s'
                          else
                            SERVICES="$next"
                            shift
                          fi
                          ;;
    -h | --help )         usage
                          exit
                          ;;
    -v | --version )      echo "LocalStack Deployment Loader $VER_MAJ.$VER_MIN.$VER_PATCH "
                          exit
                          ;;
    * )                   echo "ERROR: Unavailable flag or mangled syntax: $next."
                          echo "       See 'localstack-up --help' for usage."
                          exit 1
                          ;;
  esac
  shift
done

# check if the name already exists with "docker images | grep $STACK_NAME" and give a warning. If the user wants
# to change the name, create a new stack with the same name (remove and start new), or start the old container.

docker run -d --name "$STACK_NAME" -e SERVICES="$SERVICES" -p 4566:4566 -p 4571:4571 localstack/localstack