#!/bin/bash


# Version Markers
VER_MAJ=0
VER_MIN=4
VER_PATCH=1

# Project Directory
PROJ_DIR="/mnt/d/programming_projects/smoothstack_training/python_cloud_engineer/utopia_airlines_flask"


########################################################################################################################
#######################################                                         ########################################
#######################################               FUNCTIONS                 ########################################
#######################################                                         ########################################
########################################################################################################################


# Spacer utility
spacer()
{
  echo
  echo "###############################################################################################################"
  echo "###############################################################################################################"
  echo
}


# ECR login
# Requires AWS-CLI to be installed and configured with a profile with appropriate permissions.
login1()
{
  aws eks-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.eks.aws/b9s2q8s8
}

login2()
{
  aws eks get-login-password --region us-west-2 | docker login --username AWS --password-stdin 026390315914.dkr.eks.us-west-2.amazonaws.com
}


# Usage utility
usage()
{
  echo
  echo "WARNING: This utility was written for my particular environment, but it should be "
  echo "         straightforward enough to easily bend to your use case."
  echo
  echo "NAME:"
  echo "  Sean's Utopia Project Build and Push Tool "
  echo
  echo "USAGE:"
  echo "  build_and_push_tool [aux_flags] [image_flags image_version_number]"
  echo
  echo "VERSION:"
  echo "  $VER_MAJ.$VER_MIN.$VER_PATCH "
  echo
  echo "IMAGE FLAGS:"
  echo " *Note*: Calling a flag requires a version number to tag the image with."
  echo "  -a | --admin            Frontend Admin Microservice"
  echo "  -b | --bookings         Backend Bookings Microservice"
  echo "  -d | --data_prod        Backend Data Producers Microservice"
  echo "  -f | --flights          Backend Flights Microservice"
  echo "  -u | --users            Backend Users Microservice"
  echo "       --bases            Backend and Frontend Base Images"
  echo
  echo "AUXILIARY FLAGS:"
  echo "  -h | --help             Displays this usage message for this tool."
  echo "  -v | --version          Displays the tool's version in MAJ.MIN.PATCH format."
  echo "  -l | --login            Gets ECR credentials for pushing to ECR (req. AWS-CLI)."
  echo
}


# Backend and frontend base image build an push utility
base_builders()
{
  if [ "$1" == "" ]; then
    docker build --no-cache \
      -t utopia_frontend_base_image:latest \
      -t seanhorner/utopia_frontend_base_image:latest \
      -t public.eks.aws/b9s2q8s8/utopia_frontend_base_image:latest \
      $PROJ_DIR/frontend/base_image

    docker build --no-cache \
      -t utopia_backend_base_image:latest \
      -t seanhorner/utopia_backend_base_image:latest \
      -t public.eks.aws/b9s2q8s8/utopia_backend_base_image:latest \
      $PROJ_DIR/backend/base_image
  else
    docker build --no-cache \
      -t utopia_frontend_base_image:$1 \
      -t seanhorner/utopia_frontend_base_image:$1 \
      -t public.eks.aws/b9s2q8s8/utopia_frontend_base_image:$1 \
      -t utopia_frontend_base_image:latest \
      -t seanhorner/utopia_frontend_base_image:latest \
      -t public.eks.aws/b9s2q8s8/utopia_frontend_base_image:latest \
      $PROJ_DIR/frontend/base_image

    docker build --no-cache \
      -t utopia_backend_base_image:$1 \
      -t seanhorner/utopia_backend_base_image:$1 \
      -t public.eks.aws/b9s2q8s8/utopia_backend_base_image:$1 \
      -t utopia_backend_base_image:latest \
      -t seanhorner/utopia_backend_base_image:latest \
      -t public.eks.aws/b9s2q8s8/utopia_backend_base_image:latest \
      $PROJ_DIR/backend/base_image
  fi
}


# Admin microservice build and push utility
admin_build_and_push()
{
  if [ "$1" == "" ]; then
    docker build --no-cache \
      -t utopia_frontend_admin_microservice:latest \
      -t seanhorner/utopia_frontend_admin_microservice:latest \
      -t public.eks.aws/b9s2q8s8/utopia_frontend_admin_microservice:latest \
      $PROJ_DIR/frontend/microservice_admin

  else
    docker build --no-cache \
      -t utopia_frontend_admin_microservice:$1 \
      -t seanhorner/utopia_frontend_admin_microservice:$1 \
      -t public.eks.aws/b9s2q8s8/utopia_frontend_admin_microservice:$1 \
      -t utopia_frontend_admin_microservice:latest \
      -t seanhorner/utopia_frontend_admin_microservice:latest \
      -t public.eks.aws/b9s2q8s8/utopia_frontend_admin_microservice:latest \
      $PROJ_DIR/frontend/microservice_admin
  fi

  if [ "$1" == "" ]; then
    docker push seanhorner/utopia_frontend_admin_microservice:$1
    spacer
    docker push public.eks.aws/b9s2q8s8/utopia_frontend_admin_microservice:$1
    spacer
  fi

  docker push seanhorner/utopia_frontend_admin_microservice:latest
  spacer
  docker push public.eks.aws/b9s2q8s8/utopia_frontend_admin_microservice:latest
}


# Bookings microservice build and push utility
booking_build_and_push()
{
  if [ "$1" == "" ]; then
    docker build --no-cache \
      -t utopia_backend_bookings_microservice:latest \
      -t seanhorner/utopia_backend_bookings_microservice:latest \
      -t public.eks.aws/b9s2q8s8/utopia_backend_bookings_microservice:latest \
      $PROJ_DIR/backend/microservice_bookings

  else
    docker build --no-cache \
      -t utopia_backend_bookings_microservice:$1 \
      -t seanhorner/utopia_backend_bookings_microservice:$1 \
      -t public.eks.aws/b9s2q8s8/utopia_backend_bookings_microservice:$1 \
      -t utopia_backend_bookings_microservice:latest \
      -t seanhorner/utopia_backend_bookings_microservice:latest \
      -t public.eks.aws/b9s2q8s8/utopia_backend_bookings_microservice:latest \
      $PROJ_DIR/backend/microservice_bookings
  fi

  if [ "$1" == "" ]; then
    docker push seanhorner/utopia_backend_bookings_microservice:$1
    spacer
    docker push public.eks.aws/b9s2q8s8/utopia_backend_bookings_microservice:$1
    spacer
  fi

  docker push seanhorner/utopia_backend_bookings_microservice:latest
  spacer
  docker push public.eks.aws/b9s2q8s8/utopia_backend_bookings_microservice:latest
}


# Data producers microservice build and push utility
data_producers_build_and_push()
{
  if [ "$1" == "" ]; then
    docker build --no-cache \
      -t utopia_backend_data_producers_microservice:latest \
      -t seanhorner/utopia_backend_data_producers_microservice:latest \
      -t public.eks.aws/b9s2q8s8/utopia_backend_data_producers_microservice:latest \
      $PROJ_DIR/backend/microservice_data_producers

  else
    docker build --no-cache \
      -t utopia_backend_data_producers_microservice:$1 \
      -t seanhorner/utopia_backend_data_producers_microservice:$1 \
      -t public.eks.aws/b9s2q8s8/utopia_backend_data_producers_microservice:$1 \
      -t utopia_backend_data_producers_microservice:latest \
      -t seanhorner/utopia_backend_data_producers_microservice:latest \
      -t public.eks.aws/b9s2q8s8/utopia_backend_data_producers_microservice:latest \
      $PROJ_DIR/backend/microservice_data_producers
  fi

  if [ "$1" == "" ]; then
    docker push seanhorner/utopia_backend_data_producers_microservice:$1
    spacer
    docker push public.eks.aws/b9s2q8s8/utopia_backend_data_producers_microservice:$1
    spacer
  fi

  docker push seanhorner/utopia_backend_data_producers_microservice:latest
  spacer
  docker push public.eks.aws/b9s2q8s8/utopia_backend_data_producers_microservice:latest
}


# Flights microservice build and push utility
flights_build_and_push()
{
  if [ "$1" == "" ]; then
    docker build --no-cache \
      -t utopia_backend_flights_microservice:latest \
      -t seanhorner/utopia_backend_flights_microservice:latest \
      -t public.eks.aws/b9s2q8s8/utopia_backend_flights_microservice:latest \
      $PROJ_DIR/backend/microservice_flights
  else
    docker build --no-cache \
      -t utopia_backend_flights_microservice:$1 \
      -t seanhorner/utopia_backend_flights_microservice:$1 \
      -t public.eks.aws/b9s2q8s8/utopia_backend_flights_microservice:$1 \
      -t utopia_backend_flights_microservice:latest \
      -t seanhorner/utopia_backend_flights_microservice:latest \
      -t public.eks.aws/b9s2q8s8/utopia_backend_flights_microservice:latest \
      $PROJ_DIR/backend/microservice_flights
  fi

  if [ "$1" == "" ]; then
    docker push seanhorner/utopia_backend_flights_microservice:$1
    spacer
    docker push public.eks.aws/b9s2q8s8/utopia_backend_flights_microservice:$1
    spacer
  fi

  docker push seanhorner/utopia_backend_flights_microservice:latest
  spacer
  docker push public.eks.aws/b9s2q8s8/utopia_backend_flights_microservice:latest
}


# Users microservice build and push utility
users_build_and_push()
{
  if [ "$1" == "" ]; then
    docker build --no-cache \
      -t utopia_backend_users_microservice:latest \
      -t seanhorner/utopia_backend_users_microservice:latest \
      -t public.eks.aws/b9s2q8s8/utopia_backend_users_microservice:latest \
      $PROJ_DIR/backend/microservice_users
  else
    docker build --no-cache \
      -t utopia_backend_users_microservice:$1 \
      -t seanhorner/utopia_backend_users_microservice:$1 \
      -t public.eks.aws/b9s2q8s8/utopia_backend_users_microservice:$1 \
      -t utopia_backend_users_microservice:latest \
      -t seanhorner/utopia_backend_users_microservice:latest \
      -t public.eks.aws/b9s2q8s8/utopia_backend_users_microservice:latest \
      $PROJ_DIR/backend/microservice_users
  fi

  if [ "$1" == "" ]; then
    docker push seanhorner/utopia_backend_users_microservice:$1
    spacer
    docker push public.eks.aws/b9s2q8s8/utopia_backend_users_microservice:$1
    spacer
  fi

  docker push seanhorner/utopia_backend_users_microservice:latest
  spacer
  docker push public.eks.aws/b9s2q8s8/utopia_backend_users_microservice:latest
}


########################################################################################################################
#######################################                                         ########################################
#######################################           MAIN PARSER LOOP              ########################################
#######################################                                         ########################################
########################################################################################################################

while [ "$1" != "" ]; do
  next=$2
  case $1 in
    -a | --admin )        if [ "$next" == "" ] || [ "${next:0:1}" == "-" ]; then
                            admin_build_and_push
                          else
                            admin_build_and_push "$next"
                            shift
                          fi
                          ;;
    -b | --bookings )     if [ "$next" == "" ] || [ "${next:0:1}" == "-" ]; then
                            booking_build_and_push
                          else
                            booking_build_and_push "$next"
                            shift
                          fi
                          ;;
    -d | --data_prod )    if [ "$next" == "" ] || [ "${next:0:1}" == "-" ]; then
                            data_producers_build_and_push
                          else
                            data_producers_build_and_push "$next"
                            shift
                          fi
                          ;;
    -f | --flights )      if [ "$next" == "" ] || [ "${next:0:1}" == "-" ]; then
                            flights_build_and_push
                          else
                            flights_build_and_push "$next"
                            shift
                          fi
                          ;;
    -u | --users )        if [ "$next" == "" ] || [ "${next:0:1}" == "-" ]; then
                            users_build_and_push
                          else
                            users_build_and_push "$next"
                            shift
                          fi
                          ;;
    -h | --help )         usage
                          exit
                          ;;
    -v | --version )      echo "Utopia Build and Push Tool $VER_MAJ.$VER_MIN.$VER_PATCH "
                          exit
                          ;;
    -l | --login )        if [ "$next" == "" ] || [ "${next:0:1}" == "-" ]; then
                            login1
                          else
                            login2
                          fi
                          ;;
    --bases )             if [ "$next" == "" ] || [ "${next:0:1}" == "-" ]; then
                            base_builders
                          else
                            base_builders "$next"
                          fi
                          ;;
    * )                   echo "ERROR: Unavailable flag or mangled syntax: $1."
                          echo "       See './build_and_push_tool.sh --help' for usage."
                          exit 1
                          ;;
  esac
  shift
done

echo
echo "****************************************************************************************************************"
echo "***********************              Successfully completed build and push.              ***********************"
echo "****************************************************************************************************************"
echo