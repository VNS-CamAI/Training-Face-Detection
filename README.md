# <p align="center">Yolov5 Face Detection</p>
<p align="center">
  <img src="docs/vinorsoft_logo.png" width="150">
  <br />
  <br />
  <a href="http://www.vinorsoft.com/"><img alt="Auth Vinorsoft" src="https://img.shields.io/badge/Auth-Vinorsoft-FFD500?style=flat&labelColor=005BBB" /></a>
  <a href="https://github.com/pytorch/fairseq/blob/main/LICENSE"><img alt="Team" src="https://img.shields.io/badge/Team-Camera AI-FFD500?style=flat&labelColor=005BBB" /></a>
  <a href="https://github.com/optimuskonboi"><img alt="Instructor DanPV" src="https://img.shields.io/badge/Instructor-DanPV-FFD500?style=flat&labelColor=005BBB" /></a>
  <a href="https://github.com/giangnv125"><img alt="Deployer GiangNV" src="https://img.shields.io/badge/Deployer-GiangNV-FFD500?style=flat&labelColor=005BBB" /></a>
</p>



## Overview

- Yolov5-face is a real-time,high accuracy face detection.
- Face detection using Yolov5 model based on this link https://github.com/phamvandan/yolov5-face

## Pretrained model

| Name        | Link                                                         |
|-------------| ------------------------------------------------------------ |
| yolov5n-0.5 | Link: https://drive.google.com/uc?export=download&id=1op6bGKsfmBaX3qmI1HWNHY5U49hPuROy |
| yolov5n     | Link: https://drive.google.com/uc?export=download&id=1Kn5uwTPzC_uM3K0VUuMUM2KB8ebbRcXG |
| yolov5s*    | Link: https://drive.google.com/uc?export=download&id=1YGvdlxKo5JNh5tihdxCDKcORlhDDoWbb |
| yolov5m     | Link: https://drive.google.com/uc?export=download&id=1aZz7QQITqpDd_7tUukOngiAGPIAZF2z- |
_(* model in use)_
## Installation
1. Clone repo
```shell
git clone https://github.com/VNS-CamAI/Training-Face-Detection.git
```
2. Build docker environment
```shell
cd Training-Face-Detection
docker build -t fd_env .
docker run --network host --gpus all -it -v $(pwd):/home -w /home --name fd_env_container fd_env:latest /bin/bash
```
## Data preparation
### Custom Masked Face datasets
1. Download dataset at this [google drive link](https://drive.google.com/drive/folders/1AI6POtUxlreMxOMfq9S8Nky7Y0VIxdhS?usp=sharing)
2. Each image has an annotation txt file which saves object labels (YOLO format). The .txt file specifications are:
- One row per object.
- Each row is _class_id x<sub>center</sub> y<sub>center</sub> width height x<sub>1</sub> y<sub>1</sub> x<sub>2</sub> y<sub>2</sub> x<sub>3</sub> y<sub>3</sub> x<sub>4</sub> y<sub>4</sub> x<sub>5</sub> y<sub>5</sub>_ 5-point-lanmarks coordinates format.
- Box coordinates must be in normalized xywh format (from 0 to 1). If your boxes are in pixels, divide x_center and width by image width, and y_center and height by image height.
- Class numbers are zero-indexed (start from 0).

    More detailed description in [readme_dataset.md](./datasets/readme_datasets.md)
3. Organize Directories:
```shell
./datasets/maskedFace/train/im0.jpg  # image
./datasets/maskedFace/train/im0.txt  # label
```

For other custom datasets, follow [this guide](https://docs.ultralytics.com/yolov5/tutorials/train_custom_data/)

## Transfer learning
1. Download masked face datasets and place to `datasets` folder
2. Create .yaml config file (`./data/maskedFace.yaml`)
3. Download pretrained weights model and place to `weights` folder
4. Tranfer learning and training:
```shell
python3 train.py --img 640 --epochs 50 --patience 10 --data data/maskedFace.yaml --cfg models/yolov5s.yaml --weights weights/yolov5s-face.pt
```
5. To show training results:
```shell
tensorboard --logdir runs/train
```
## Testing
1. Download and place pretrained weights to `weights` folder
2. Run
```shell
python3 detect_face.py --weights weights/yolov5-face.pt --source 0 --save-img                               # webcam
                                                                 img.jpg                         # image
                                                                 vid.mp4                         # video
                                                                 screen                          # screenshot
                                                                 path/                           # directory
                                                                 list.txt                        # list of images
                                                                 list.streams                    # list of streams
                                                                 'path/*.jpg'                    # glob
                                                                 'https://youtu.be/LNwODJXcvt4'  # YouTube
                                                                 'rtsp://example.com/media.mp4'  # RTSP, RTMP, HTTP stream
```



