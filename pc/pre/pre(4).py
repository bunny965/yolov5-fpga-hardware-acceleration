import os
import serial
import torch
import argparse
import time
from pathlib import Path

import cv2
import numpy as np
import matplotlib
import struct

import torch.backends.cudnn as cudnn
from numpy import random

from models.experimental import attempt_load
from utils.datasets import LoadStreams, LoadImages
from utils.general import check_img_size, check_requirements, check_imshow, non_max_suppression, apply_classifier, \
    scale_coords, xyxy2xywh, strip_optimizer, set_logging, increment_path
from utils.plots import plot_one_box
from utils.torch_utils import select_device, load_classifier, time_synchronized

# 串口配置
port = 'COM1'  # 串口号
baudrate = 9600  # 波特率

# 数据尺寸
height = 640
width = 640
channels = 3

# 计算接收数据的总长度
data_size = height * width * channels

# 打开串口
ser = serial.Serial(port, baudrate)

# 接收数据
img = ser.read(data_size)
img = np.frombuffer(img, dtype=np.uint8).reshape(channels, height, width)


img = torch.from_numpy(img)


matplotlib.image.imsave('name.png', img)
img = img.half()  # uint8 to fp16
img /= 255.0  # 0 - 255 to 0.0 - 1.0
# 十进制单精度浮点转16位16进制
params = np.array(img).flatten()

np.set_printoptions(threshold=np.inf)

for param in params:
    hexa = struct.unpack('H', struct.pack('e', param))[0]
    hexa = hex(hexa)
    hexa = hexa[2:]

    ser.write(hexa)
# 关闭串口
ser.close()




