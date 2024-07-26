FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-runtime
RUN pip install opencv-python
RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y
RUN pip install Cython matplotlib Pillow psutil PyYAML requests scipy tqdm tensorboard seaborn pandas thop pycocotools