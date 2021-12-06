#!/bin/bash


# Version Markers
VER_MAJ=0
VER_MIN=2
VER_PATCH=12

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
login()
{
  aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/b9s2q8s8
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
  echo
  echo "AUXILIARY FLAGS:"
  echo "  -h | --help             Displays this usage message for this tool."
  echo "  -v | --version          Displays the tool's version in MAJ.MIN.PATCH format."
  echo "  -l | --login            Gets ECR credentials for pushing to ECR (req. AWS-CLI)."
  echo
}


# Admin microservice build and push utility
admin_build_and_push()
{
  if [ "$1" == "" ]; then
    docker build --progress=plain \
      -t utopia_frontend_admin_microservice:latest \
      -t seanhorner/utopia_frontend_admin_microservice:latest \
      -t public.ecr.aws/b9s2q8s8/utopia_frontend_admin_microservice:latest \
      -f $PROJ_DIR/frontend/dockerfiles/admin_dockerfile \
      $PROJ_DIR/frontend/microservice_admin

    docker push seanhorner/utopia_frontend_admin_microservice:latest
    spacer
    docker push public.ecr.aws/b9s2q8s8/utopia_frontend_admin_microservice:latest
  else
    docker build --progress=plain \
      -t utopia_frontend_admin_microservice:$1 \
      -t seanhorner/utopia_frontend_admin_microservice:$1 \
      -t public.ecr.aws/b9s2q8s8/utopia_frontend_admin_microservice:$1 \
      -t utopia_frontend_admin_microservice:latest \
      -t seanhorner/utopia_frontend_admin_microservice:latest \
      -t public.ecr.aws/b9s2q8s8/utopia_frontend_admin_microservice:latest \
      -f $PROJ_DIR/frontend/dockerfiles/admin_dockerfile \
      $PROJ_DIR/frontend/microservice_admin

    docker push seanhorner/utopia_frontend_admin_microservice:$1
    spacer
    docker push public.ecr.aws/b9s2q8s8/utopia_frontend_admin_microservice:$1
    spacer
    docker push seanhorner/utopia_frontend_admin_microservice:latest
    spacer
    docker push public.ecr.aws/b9s2q8s8/utopia_frontend_admin_microservice:latest
  fi
}


# Bookings microservice build and push utility
booking_build_and_push()
{
  if [ "$1" == "" ]; then
    docker build --progress=plain \
      -t utopia_backend_bookings_microservice:latest \
      -t seanhorner/utopia_backend_bookings_microservice:latest \
      -t public.ecr.aws/b9s2q8s8/utopia_backend_bookings_microservice:latest \
      -f $PROJ_DIR/backend/dockerfiles/bookings_dockerfile \
      $PROJ_DIR/backend/microservice_bookings

    docker push seanhorner/utopia_backend_bookings_microservice:latest
    spacer
    docker push public.ecr.aws/b9s2q8s8/utopia_backend_bookings_microservice:latest
  else
    docker build --progress=plain \
      -t utopia_backend_bookings_microservice:$1 \
      -t seanhorner/utopia_backend_bookings_microservice:$1 \
      -t public.ecr.aws/b9s2q8s8/utopia_backend_bookings_microservice:$1 \
      -t utopia_backend_bookings_microservice:latest \
      -t seanhorner/utopia_backend_bookings_microservice:latest \
      -t public.ecr.aws/b9s2q8s8/utopia_backend_bookings_microservice:latest \
      -f $PROJ_DIR/backend/dockerfiles/bookings_dockerfile \
      $PROJ_DIR/backend/microservice_bookings

    docker push seanhorner/utopia_backend_bookings_microservice:$1
    spacer
    docker push public.ecr.aws/b9s2q8s8/utopia_backend_bookings_microservice:$1
    spacer
    docker push seanhorner/utopia_backend_bookings_microservice:latest
    spacer
    docker push public.ecr.aws/b9s2q8s8/utopia_backend_bookings_microservice:latest
  fi
}


# Data producers microservice build and push utility
data_producers_build_and_push()
{
  if [ "$1" == "" ]; then
    docker build --progress=plain \
      -t utopia_backend_data_producers_microservice:latest \
      -t seanhorner/utopia_backend_data_producers_microservice:latest \
      -t public.ecr.aws/b9s2q8s8/utopia_backend_data_producers_microservice:latest \
      -f $PROJ_DIR/backend/dockerfiles/data_producers_dockerfile \
      $PROJ_DIR/backend/microservice_data_producers

    docker push seanhorner/utopia_backend_data_producers_microservice:latest
    spacer
    docker push public.ecr.aws/b9s2q8s8/utopia_backend_data_producers_microservice:latest
  else
    docker build --progress=plain \
      -t utopia_backend_data_producers_microservice:$1 \
      -t seanhorner/utopia_backend_data_producers_microservice:$1 \
      -t public.ecr.aws/b9s2q8s8/utopia_backend_data_producers_microservice:$1 \
      -t utopia_backend_data_producers_microservice:latest \
      -t seanhorner/utopia_backend_data_producers_microservice:latest \
      -t public.ecr.aws/b9s2q8s8/utopia_backend_data_producers_microservice:latest \
      -f $PROJ_DIR/backend/dockerfiles/data_producers_dockerfile \
      $PROJ_DIR/backend/microservice_data_producers

    docker push seanhorner/utopia_backend_data_producers_microservice:$1
    spacer
    docker push public.ecr.aws/b9s2q8s8/utopia_backend_data_producers_microservice:$1
    spacer
    docker push seanhorner/utopia_backend_data_producers_microservice:latest
    spacer
    docker push public.ecr.aws/b9s2q8s8/utopia_backend_data_producers_microservice:latest
  fi
}


# Flights microservice build and push utility
flights_build_and_push()
{
  if [ "$1" == "" ]; then
    docker build --progress=plain \
      -t utopia_backend_flights_microservice:latest \
      -t seanhorner/utopia_backend_flights_microservice:latest \
      -t public.ecr.aws/b9s2q8s8/utopia_backend_flights_microservice:latest \
      -f $PROJ_DIR/backend/dockerfiles/flights_dockerfile \
      $PROJ_DIR/backend/microservice_flights

    docker push seanhorner/utopia_backend_flights_microservice:latest
    spacer
    docker push public.ecr.aws/b9s2q8s8/utopia_backend_flights_microservice:latest
  else
    docker build --progress=plain \
      -t utopia_backend_flights_microservice:$1 \
      -t seanhorner/utopia_backend_flights_microservice:$1 \
      -t public.ecr.aws/b9s2q8s8/utopia_backend_flights_microservice:$1 \
      -t utopia_backend_flights_microservice:latest \
      -t seanhorner/utopia_backend_flights_microservice:latest \
      -t public.ecr.aws/b9s2q8s8/utopia_backend_flights_microservice:latest \
      -f $PROJ_DIR/backend/dockerfiles/flights_dockerfile \
      $PROJ_DIR/backend/microservice_flights

    docker push seanhorner/utopia_backend_flights_microservice:$1
    spacer
    docker push public.ecr.aws/b9s2q8s8/utopia_backend_flights_microservice:$1
    spacer
    docker push seanhorner/utopia_backend_flights_microservice:latest
    spacer
    docker push public.ecr.aws/b9s2q8s8/utopia_backend_flights_microservice:latest
  fi
}


# Users microservice build and push utility
users_build_and_push()
{
  if [ "$1" == "" ]; then
    docker build --progress=plain \
      -t utopia_backend_users_microservice:latest \
      -t seanhorner/utopia_backend_users_microservice:latest \
      -t public.ecr.aws/b9s2q8s8/utopia_backend_users_microservice:latest \
      -f $PROJ_DIR/backend/dockerfiles/users_dockerfile \
      $PROJ_DIR/backend/microservice_users

    docker push seanhorner/utopia_backend_users_microservice:latest
    spacer
    docker push public.ecr.aws/b9s2q8s8/utopia_backend_users_microservice:latest
  else
    docker build --progress=plain \
      -t utopia_backend_users_microservice:$1 \
      -t seanhorner/utopia_backend_users_microservice:$1 \
      -t public.ecr.aws/b9s2q8s8/utopia_backend_users_microservice:$1 \
      -t utopia_backend_users_microservice:latest \
      -t seanhorner/utopia_backend_users_microservice:latest \
      -t public.ecr.aws/b9s2q8s8/utopia_backend_users_microservice:latest \
      -f $PROJ_DIR/backend/dockerfiles/users_dockerfile \
      $PROJ_DIR/backend/microservice_users

    docker push seanhorner/utopia_backend_users_microservice:$1
    spacer
    docker push public.ecr.aws/b9s2q8s8/utopia_backend_users_microservice:$1
    spacer
    docker push seanhorner/utopia_backend_users_microservice:latest
    spacer
    docker push public.ecr.aws/b9s2q8s8/utopia_backend_users_microservice:latest
  fi
}


#tester_func()
#{
#  echo "Ran the tester with param $1"
#}


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
    -l | --login )        login
                          ;;
#    -t )                  if [ "$next" == "" ] || [ "${next:0:1}" == "-" ]; then
#                            tester_func
#                          else
#                            tester_func "$next"
#                            shift
#                          fi
#                          ;;
    * )                   usage
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