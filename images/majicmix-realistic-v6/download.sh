#!/bin/sh

mkdir_git_download_unzip(){
    mkdir -p $1
    wget -qO- $2 | tar xvz -C $1
}

# EXTENSIONS
# mkdir_git_clone extensions https://github.com/mcmonkeyprojects/sd-dynamic-thresholding.git

mkdir_git_download_unzip extensions https://github.com/mcmonkeyprojects/sd-dynamic-thresholding/archive/refs/heads/master.zip

mkdir_wget(){
    mkdir -p $1
    wget -nc -P $1 --content-disposition $2
}

# EMBEDDINGS / TEXTUAL INVERSION
# easynegative.safetensors
mkdir_wget embeddings https://civitai.com/api/download/models/9208
# ng_deepnegative_v1_75t.pt
mkdir_wget embeddings https://civitai.com/api/download/models/5637
# verybadimagenegative_v1.3.pt
mkdir_wget embeddings https://civitai.com/api/download/models/25820

# LORA
# add_detail.safetensors
mkdir_wget models/Lora https://civitai.com/api/download/models/62833
# more_details.safetensors
mkdir_wget models/Lora https://civitai.com/api/download/models/87153
# skirtlift-v1.safetensors
mkdir_wget models/Lora https://civitai.com/api/download/models/10187
# betterCuteAsian03.safetensors
mkdir_wget models/Lora https://civitai.com/api/download/models/44501

# MODELS
mkdir -p models/Stable-diffusion 
# majicmixRealistic_v6.safetensors
mkdir_wget models/Stable-diffusion https://civitai.com/api/download/models/94640
