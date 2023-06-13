import numpy as np
import serial
import torch

from float16_i import rece


def after():
    port = 'COM1'  # 串口号
    baudrate = 9600  # 波特率

    # 数据尺寸
    height1 = 80
    width1 = 80
    channels1 = 255
    # 数据尺寸
    height2 = 40
    width2 = 40
    channels2 = 255
    # 数据尺寸
    height3 = 20
    width3 = 20
    channels3 = 255
    data_size1 = height1 * width1 * channels1
    data_size2 = height2 * width2 * channels2
    data_size3 = height3 * width3 * channels3

    ser = serial.Serial(port, baudrate)

    ser.read(1)
    count1 = 0
    data1 = []
    while count1 < data_size1:
        st = ''
        for i in range(16):
            img = ser.read(1)
            st += str(img)
        data1.append(rece(st))
        count1 = count1 + 1
    ser.read(1)
    count1 = 0

    x1 = np.array(data1).reshape(channels1, height1, width1)

    ser.read(1)
    count2 = 0
    data2 = []
    while (count2 < data_size2):
        st = ''
        for i in range(16):
            img = ser.read(1)
            st += str(img)
        data2.append(rece(st))
        count2 = count2 + 1
    ser.read(1)
    count2 = 0
    x2 = np.array(data2).reshape(channels2, height2, width2)

    ser.read(1)
    count3 = 0
    data3 = []
    while count3 < data_size3:
        st = ''
        for i in range(16):
            img = ser.read(1)
            st += str(img)
        data3.append(rece(st))
        count3 = count3 + 1
    ser.read(1)
    count3 = 0

    x3 = np.array(data3).reshape(channels3, height3, width3)
    ser.close()

    res = [x1, x2, x3]
    return res
