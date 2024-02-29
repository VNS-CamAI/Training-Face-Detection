## <p align="center">Custom datasets for training</p>
<p align="center">
  <img src="../docs/vinorsoft_logo.png" width="150">
  <br />
  <br />
  <a href="http://www.vinorsoft.com/"><img alt="Auth Vinorsoft" src="https://img.shields.io/badge/Auth-Vinorsoft-FFD500?style=flat&labelColor=005BBB" /></a>
  <a href="https://github.com/pytorch/fairseq/blob/main/LICENSE"><img alt="Team" src="https://img.shields.io/badge/Team-Camera AI-FFD500?style=flat&labelColor=005BBB" /></a>
  <a href="https://github.com/optimuskonboi"><img alt="Instructor DanPV" src="https://img.shields.io/badge/Instructor-DanPV-FFD500?style=flat&labelColor=005BBB" /></a>
  <a href="https://github.com/giangnv125"><img alt="Deployer GiangNV" src="https://img.shields.io/badge/Deployer-GiangNV-FFD500?style=flat&labelColor=005BBB" /></a>
</p>

### Mô tả về cấu trúc tập dữ liệu đã thu thập
- Dữ liệu đã thu thập được đặt trong [link drive này](https://drive.google.com/drive/folders/1AI6POtUxlreMxOMfq9S8Nky7Y0VIxdhS?usp=drive_link). Bộ dữ liệu trong folder `maskedFace` gồm 920 ảnh chụp người châu Á chia thành: train (700 ảnh), valid (100 ảnh) và test (120 ảnh).
- Dữ liệu đầu vào được đặt ở folder `datasets` chia thành 3 folder: `train`, `valid` và `test` có cấu trúc như dưới:
```
📦 maskedFace
 ┣ 📂 train
 ┃ ┣ 📜 image1.jpg
 ┃ ┣ 📜 image2.jpeg
 ┃ ┣ 📜 ...
 ┃ ┣ 📜 image1.txt
 ┃ ┣ 📜 image2.txt
 ┃ ┗ 📜 ...
 ┣ 📂 valid
 ┃ ┣ 📜 image4.png
 ┃ ┣ 📜 image5.jpg
 ┃ ┣ 📜 ...
 ┃ ┣ 📜 image4.txt
 ┃ ┣ 📜 image5.txt
 ┃ ┗ 📜 ...
 ┣ 📂 test
 ┃ ┣ 📜 img1.png
 ┃ ┣ 📜 img2.jpg
 ┃ ┗ 📜 ...
```
- Mỗi ảnh trong `train`, `valid` có 1 file annotation `.txt` tương ứng lưu thông tin của các face trong ảnh. Trong file annotation `.txt` lưu thông tin theo các dòng, mỗi dòng chứa thông tin như sau:
  ```commandline
  obj_label x_center y_center width height x1 y1 x2 y2 x3 y3 x4 y4 x5 y5
  ```
  - obj_label: label của đối tượng trong danh sách
  - (x_center, y_center) ∈ [0,1]: tọa độ tâm bounding box
  - (width, height) ∈ [0,1]: kích thước của bounding box
  - (xi, yi) ∈ [0,1]: tọa độ các điểm landmarks hoặc xi=yi=-1 nếu không có thông tin về tọa độ landmarks
- Tạo file cấu hình `data/dataset.yaml`:
  ```commandline
  # Train/val/test sets as
  ## 1) dir: path/to/imgs, 2) file: path/to/imgs.txt, or 3) list: [path/to/imgs1, path/to/imgs2, ..]
  
  
  #path: ./datasets/maskedFace  # dataset root dir
  train: ./datasets/maskedFace/train  # train images (relative to 'path') 128 images
  val: ./datasets/maskedFace/valid # val images (relative to 'path') 128 images
  test: ./datasets/maskedFace/test/images
  
  # Classes
  nc: 1  # number of classes
  names: ['face']  # class names
  ```
  
### Cách thêm custom datasets khác:
- Có thể thêm custom datasets theo [hướng dẫn này](https://docs.ultralytics.com/yolov5/tutorials/train_custom_data/#21-create-datasetyaml)