FROM fairembodied/habitat-challenge:habitat_navigation_2023_base_docker

# ADD agent/habitat_baselines_agent.py agent.py
# # ADD agents/config.py config.py
# ADD configs/ /configs/
# ADD scripts/submission.sh /submission.sh
# ADD objectnav_baseline_habitat_navigation_challenge_2023.pth demo.ckpt.pth

########### Stubborn Deps ###########
RUN /bin/bash -c ". activate habitat"

# Install project specific packages
RUN /bin/bash -c "apt-get update; apt-get install -y libsm6 libxext6 libxrender-dev; . activate habitat; pip install opencv-python"
RUN /bin/bash -c ". activate habitat; pip install --upgrade cython numpy"

# Need downgrade setuptools due to scikit not updating build to new format
RUN /bin/bash -c ". activate habitat; pip install --upgrade 'setuptools<60'" 
RUN /bin/bash -c ". activate habitat; pip install matplotlib seaborn scikit-fmm scikit-image imageio scikit-learn ifcfg"

# Install pytorch and torch_scatter
# RUN conda install pytorch=1.6.0 torchvision=0.7.0 cudatoolkit=10.2 -c pytorch

# Install detectron2
RUN /bin/bash -c ". activate habitat; python -m pip install 'git+https://github.com/facebookresearch/detectron2.git'"

RUN /bin/bash -c ". activate habitat; pip uninstall numba -y; pip install -U numba "

RUN /bin/bash -c ". activate habitat; pip install torch==1.12.1+cu113 torchvision==0.13.1+cu113 torchaudio==0.12.1 --extra-index-url https://download.pytorch.org/whl/cu113 "

########### Stubborn Deps ###########


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

