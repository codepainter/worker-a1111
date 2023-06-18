#!/bin/sh

# run from root dir 
# eg: ./build.sh majicmix-realistic-v6

BRANCH_NAME=$1

git checkout $BRANCH_NAME && git pull

FOLDERNAME=$1

./images/$FOLDERNAME/download.sh

REPO_NAME=abiyasa2410/sd-worker
TAG=$FOLDERNAME
FULL_IMAGE_NAME=$REPO_NAME:$TAG

docker build \
        -f images/$1/Dockerfile \
        -t $FULL_IMAGE_NAME \
        .

docker push $FULL_IMAGE_NAME