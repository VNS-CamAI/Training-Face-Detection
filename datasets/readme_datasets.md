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
- Dữ liệu đã thu thập được đặt trong [link drive này](https://drive.google.com/drive/folders/1AI6POtUxlreMxOMfq9S8Nky7Y0VIxdhS?usp=drive_link). Bộ dữ liệu trong folder `maskedFace` gồm 920 ảnh chụp mặt (đa số là người châu Á) chia thành: train (700 ảnh), valid (100 ảnh) và test (120 ảnh).
- Ảnh đầu vào model có kích thước 640x640
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
  _class_id x<sub>center</sub> y<sub>center</sub> width height x<sub>1</sub> y<sub>1</sub> x<sub>2</sub> y<sub>2</sub> x<sub>3</sub> y<sub>3</sub> x<sub>4</sub> y<sub>4</sub> x<sub>5</sub> y<sub>5</sub>_
  Trong đó:
  - _class_id_: label của đối tượng trong danh sách
  - _(x<sub>center</sub> y<sub>center</sub>)_ ∈ [0,1]: tọa độ tâm bounding box
  - _(width height)_ ∈ [0,1]: kích thước của bounding box
  - _(x<sub>i</sub> y<sub>i</sub>)_ ∈ [0,1]: tọa độ các điểm landmarks nếu có thông tin tọa độ các điểm landmarks hoặc xi=yi=-1 nếu không có thông tin về tọa độ landmarks
  Nếu các toạ độ, kích thước dưới dạng pixel thì các giá trị _x<sub>center</sub> width x<sub>i</sub>_ được tính bằng giá trị tương ứng dạng pixel chia cho bề rộng của frame/ảnh. Tương tự, các các giá trị _y<sub>center</sub> height y<sub>i</sub>_ được tính bằng giá trị tương ứng dạng pixel chia cho độ cao của frame/ảnh
- Tạo file cấu hình `data/dataset.yaml`:
  ```commandline
  # Train/val/test sets as
  ## 1) dir: path/to/imgs, 2) file: path/to/imgs.txt, or 3) list: [path/to/imgs1, path/to/imgs2, ..]

  train: ./datasets/maskedFace/train  # train images
  val: ./datasets/maskedFace/valid # val images
  test: ./datasets/maskedFace/test/images
  
  # Classes
  nc: 1  # number of classes
  names: ['face']  # class names
  ```
  
### Cách thêm custom datasets khác:
- Có thể thêm custom datasets theo [hướng dẫn này](https://docs.ultralytics.com/yolov5/tutorials/train_custom_data/#21-create-datasetyaml)