
# All ran from RichMaps as working dir

# Build the docker container, mounting the scene data directory and model paths
docker build . -f configs/ObjectNav_ddppo_baseline.Dockerfile -t objectnav_submission

# Run the docker container, which sets the .yaml config and invokes submission.sh in the container
# submission.sh runs agent.py --evaluation {local, remote}
./scripts/test_local_objectnav_benchmark.sh

# What gets run in the container
export PYTHONPATH=/evalai-remote-evaluation:$PYTHONPATH 

export CHALLENGE_CONFIG_FILE="./configs/challenge_objectnav2021.local.rgbd.yaml" 

export CUDA_VISIBLE_DEVICES=1 

python /RichMaps/eval.py \
    --evaluation local \
    --checkpt ./rednet_semmap_mp3d_tuned.pth \