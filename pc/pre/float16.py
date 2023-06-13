import struct
import numpy as np
from binascii import unhexlify


def str2hex(s):
    odata = 0;
    su = s.upper()
    for c in su:
        tmp = ord(c)
        if tmp <= ord('9'):
            odata = odata << 4
            odata += tmp - ord('0')
        elif ord('A') <= tmp <= ord('F'):
            odata = odata << 4
            odata += tmp - ord('A') + 10
    return odata


def trans(dec_float):
    # 十进制单精度浮点转16位16进制
    params = np.array(dec_float).flatten()

    np.set_printoptions(threshold=np.inf)
    transfer = []
    for param in params:
        hexa = struct.unpack('H', struct.pack('e', param))[0]
        hexa = hex(hexa)
        hexa = hexa[2:]
        # hexa = bytes(hexa)
        # hexa = hexa.strip('\n')
        if len(hexa) != 4:
            for i in range(4 - len(hexa)):
                hexa = '0' + hexa
        hstr = []
        for i in range(len(hexa)):

            h = str2hex(hexa[i])
        # hexa = hexa[2] + hexa[3] + hexa[0] + hexa[1]
        # print(hexa)
        # b = unhexlify(hexa)
        # b = np.frombuffer(b, np.float16)
        # print(bin(bytes(b)))
            transfer.append(h)
        # transfer.append(bin(str2hex(hexa)))
    # print(transfer)
    # for i in transfer:
    #     print(hex(i))
    return transfer


x = [1, 10, 0.00001]
trans(x)
# print(hexa) # 45e6
# 16位16进制转十进制单精度浮点
# y = struct.pack("H",int(hexa,16))

# float = np.frombuffer(y, dtype =np.float16)[0]

# print(float) # 5.9
