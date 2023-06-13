import struct

import numpy as np


def halfpre2spre(s):
    # s代表16位二进数，

    sign = int(s[0])
    res0 = pow(-1, sign)  # 符号位
    exp = int('0b' + s[1:6], 2)  # 指数位
    endpre = s[6:]  # 尾部10位精度位
    res2 = 0.0
    for j in range(10):
        res2 += int(endpre[j]) * pow(2, -(j + 1))
    res = res0 * pow(2, exp - 15) * (1 + res2)
    return res


def rece(dec_bin):
    # 十进制单精度浮点转16位16进制
    receive = []
    params = np.array(dec_bin).flatten()

    np.set_printoptions(threshold=np.inf)

    for param in params:
        receive.append(halfpre2spre(param))

    # print(receive)

    return receive


x = ["0011110000000000", "0000000000000000", "0011110000111000"]
rece(x)
