#!/bin/sh

# run from root dir 
# eg: ./images/majicmixRealistic_v6/build.sh 

./images/majicmixRealistic_v6/download.sh

docker build \
        -f images/majicmixRealistic_v6/Dockerfile \
        -t abiyasa2410/sd-worker:majicmix-realistic-v6 \
        .

docker push abiyasa2410/sd-worker:majicmix-realistic-v6