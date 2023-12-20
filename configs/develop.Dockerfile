FROM nvidia/opengl:1.0-glvnd-devel-ubuntu20.04

# Conda install
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"
RUN apt-get update

RUN apt-get install -y wget && rm -rf /var/lib/apt/lists/*

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 
RUN conda --version


########### Stubborn Deps ###########
RUN /bin/bash -c "conda init"

RUN /bin/bash -c "conda create -n habitat -y"

RUN /bin/bash -c ". activate habitat"

RUN /bin/bash -c ". activate habitat; conda install python=3.8"

# Install project specific packages
RUN /bin/bash -c "apt-get update; apt-get install -y libsm6 libxext6 libxrender-dev; pip install opencv-python"
RUN /bin/bash -c ". activate habitat; pip install --upgrade cython numpy"

# Need downgrade setuptools due to scikit not updating build to new format
RUN /bin/bash -c ". activate habitat; pip install --upgrade 'setuptools<60'" 
RUN /bin/bash -c ". activate habitat; pip install matplotlib seaborn scikit-fmm scikit-image imageio scikit-learn ifcfg"

# Install pytorch and torch_scatter
# RUN conda install pytorch=1.6.0 torchvision=0.7.0 cudatoolkit=10.2 -c pytorch

# Install detectron2
RUN /bin/bash -c ". activate habitat; pip install 'git+https://github.com/facebookresearch/detectron2.git'"

RUN /bin/bash -c ". activate habitat; pip uninstall numba -y; pip install -U numba "

RUN /bin/bash -c ". activate habitat; pip install torch==1.12.1+cu113 torchvision==0.13.1+cu113 torchaudio==0.12.1 --extra-index-url https://download.pytorch.org/whl/cu113 "

########### Stubborn Deps ###########

ENV CHALLENGE_CONFIG_FILE "/RichMaps/configs/challenge_objectnav2021.local.rgbd.yaml" 

ENV TRACK_CONFIG_FILE "track_config_file_is_unknown"

# CMD [ \
#     "/bin/bash", \
#     "-c", \
#     "source activate habitat && \
#     export PYTHONPATH=/evalai-remote-evaluation:$PYTHONPATH && \
#     export CHALLENGE_CONFIG_FILE=$TRACK_CONFIG_FILE && \
#     python /RichMaps/agent/eval.py \
#     --evaluation local \
#     " \
# ]

