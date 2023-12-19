FROM fairembodied/habitat-challenge:habitat_navigation_2023_base_docker

# RUN /bin/bash -c ". activate habitat; pip install ifcfg torchvision tensorboard"

ADD agent/habitat_baselines_agent.py agent.py
# ADD agents/config.py config.py
ADD configs/ /configs/
ADD scripts/submission.sh /submission.sh
ADD objectnav_baseline_habitat_navigation_challenge_2023.pth demo.ckpt.pth

ENV AGENT_EVALUATION_TYPE local
ENV TRACK_CONFIG_FILE "track_config_file_is_unknown"

CMD [ \
    "/bin/bash", \
    "-c", \
    "source activate habitat && \
    export PYTHONPATH=/evalai-remote-evaluation:$PYTHONPATH && \
    export CHALLENGE_CONFIG_FILE=$TRACK_CONFIG_FILE && \
    bash submission.sh \
    --model-path demo.ckpt.pth \
    --input-type rgbd \
    --task objectnav \
    --action_space discrete_waypoint_controller \
    --task-config configs/ddppo_objectnav_v2_hm3d_stretch.yaml \
    habitat_baselines.rl.policy.action_distribution_type=categorical \
    habitat_baselines.load_resume_state_config=True" \
]