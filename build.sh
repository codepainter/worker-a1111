#!/bin/sh

# run from root dir 
# eg: ./build.sh majicmix-realistic-v6

BRANCH_NAME=$1

echo "Checking out and pulling branch..."
git checkout $BRANCH_NAME && git pull

FOLDERNAME=$1

echo "Downloading files..."
./images/$FOLDERNAME/download.sh

REPO_NAME=abiyasa2410/worker-a1111
TAG=$1
FULL_IMAGE_NAME=$REPO_NAME:$TAG

echo "Building $FULL_IMAGE_NAME..."
docker build \
        -f images/$1/Dockerfile \
        -t $FULL_IMAGE_NAME \
        .

echo "Pushing $FULL_IMAGE_NAME..."
docker push $FULL_IMAGE_NAME