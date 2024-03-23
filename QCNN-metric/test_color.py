import os
import time

from tqdm import tqdm
import numpy as np
import torch
from model import resnet34
from PIL import Image
from torchvision import transforms
import openpyxl


os.environ['CUDA_VISIBLE_DEVICES'] = '0'
device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")

model = resnet34(num_classes=1000)
model_path = "./resnet34.pth"

use_gpu = True

if use_gpu:
    print('GPU Mode Acitavted')
    model = model.cuda()
    model.cuda()
    print('Loading model...')
    model.load_state_dict(torch.load(model_path))

else:
    print('CPU Mode Acitavted')
    state_dict = torch.load(model_path, map_location='cpu')
    print('Loading model...')
    model.load_state_dict(state_dict)


def cosine_similarity(x, y):
    num = torch.dot(x, y.T)
    de_nom = torch.linalg.norm(x, ord=2) * torch.linalg.norm(y, ord=2)
    return (num / de_nom).detach().cpu().numpy()


def lamda(x, y):
    con_x = (torch.sum((x - torch.mean(x)) * (x - torch.mean(x)))) / (len(x) - 1)
    con_y = (torch.sum((y - torch.mean(y)) * (y - torch.mean(y)))) / (len(y) - 1)
    l = con_x / (con_x + con_y)
    return l.detach().cpu().numpy(), con_x.detach().cpu().numpy(), con_y.detach().cpu().numpy()


def norm(x):
    x_avg = np.average(x)
    x_std = np.std(x)
    return (x - x_avg) / x_std


def t_norm(x):
    x_avg = torch.mean(x)
    x_std = torch.std(x)
    return (x - x_avg) / x_std


def min_max_norm(x):
    d = (x - min(x)) / (max(x) - min(x))
    return d


def evaluate_Qcnn(file_path, type, samples):
    Q_data = openpyxl.load_workbook('c_Q_cnn.xlsx')
    sheet_score = Q_data['Sheet1']
    q = []
    for num in tqdm(range(1, samples+1)):
        tic = time.time()
        path1 = file_path + '/c{:02}_1.'.format(num) + type
        path2 = file_path + '/c{:02}_2.'.format(num) + type
        path3 = file_path + '/c{:02}_F.'.format(num) + type

        img1 = Image.open(path1).convert('RGB')
        img2 = Image.open(path2).convert('RGB')
        img3 = Image.open(path3).convert('RGB')
        img1_org = img1
        img2_org = img2
        img3_org = img3
        tran = transforms.Compose([transforms.ToTensor()])
        img1_org = tran(img1_org)
        img2_org = tran(img2_org)
        img3_org = tran(img3_org)
        input_img1 = img1_org.unsqueeze(0)
        input_img2 = img2_org.unsqueeze(0)
        input_img3 = img3_org.unsqueeze(0)
        if use_gpu:
            input_img1 = input_img1.cuda()
            input_img2 = input_img2.cuda()
            input_img3 = input_img3.cuda()
        else:
            input_img1 = input_img1
            input_img2 = input_img2
            input_img3 = input_img3
        model.eval()
        _, out_x1_1, out_x1_2, out_x1_3, out_x1_4 = model(input_img1)
        _, out_x2_1, out_x2_2, out_x2_3, out_x2_4 = model(input_img2)
        _, out_x3_1, out_x3_2, out_x3_3, out_x3_4 = model(input_img3)

        _, _, h1, w1 = out_x1_1.size()
        _, _, h2, w2 = out_x1_2.size()
        _, _, h3, w3 = out_x1_3.size()
        _, _, h4, w4 = out_x1_4.size()

        if h1 >= 13 and w1 >= 13:
            unfold = torch.nn.Unfold(kernel_size=13)
            out_x1_1 = torch.squeeze(unfold(out_x1_1)).T
            out_x2_1 = torch.squeeze(unfold(out_x2_1)).T
            out_x3_1 = torch.squeeze(unfold(out_x3_1)).T
        else:
            p = (13 - min(h1, w1)) // 2 + 1
            unfold = torch.nn.Unfold(kernel_size=13, padding=p)
            out_x1_1 = torch.squeeze(unfold(out_x1_1)).T
            out_x2_1 = torch.squeeze(unfold(out_x2_1)).T
            out_x3_1 = torch.squeeze(unfold(out_x3_1)).T

        if h2 >= 13 and w2 >= 13:
            unfold = torch.nn.Unfold(kernel_size=13)
            out_x1_2 = torch.squeeze(unfold(out_x1_2)).T
            out_x2_2 = torch.squeeze(unfold(out_x2_2)).T
            out_x3_2 = torch.squeeze(unfold(out_x3_2)).T
        else:
            p = (13 - min(h2, w2)) // 2 + 1
            unfold = torch.nn.Unfold(kernel_size=13, padding=p)
            out_x1_2 = torch.squeeze(unfold(out_x1_2)).T
            out_x2_2 = torch.squeeze(unfold(out_x2_2)).T
            out_x3_2 = torch.squeeze(unfold(out_x3_2)).T

        if h3 >= 13 and w3 >= 13:
            unfold = torch.nn.Unfold(kernel_size=13)
            out_x1_3 = torch.squeeze(unfold(out_x1_3)).T
            out_x2_3 = torch.squeeze(unfold(out_x2_3)).T
            out_x3_3 = torch.squeeze(unfold(out_x3_3)).T
        else:
            p = (13 - min(h3, w3)) // 2 + 1
            unfold = torch.nn.Unfold(kernel_size=13, padding=p)
            out_x1_3 = torch.squeeze(unfold(out_x1_3)).T
            out_x2_3 = torch.squeeze(unfold(out_x2_3)).T
            out_x3_3 = torch.squeeze(unfold(out_x3_3)).T

        if h4 >= 13 and w4 >= 13:
            unfold = torch.nn.Unfold(kernel_size=13)
            out_x1_4 = torch.squeeze(unfold(out_x1_4)).T
            out_x2_4 = torch.squeeze(unfold(out_x2_4)).T
            out_x3_4 = torch.squeeze(unfold(out_x3_4)).T
        else:
            p = (13 - min(h4, w4)) // 2 + 1
            unfold = torch.nn.Unfold(kernel_size=13, padding=p)
            out_x1_4 = torch.squeeze(unfold(out_x1_4)).T
            out_x2_4 = torch.squeeze(unfold(out_x2_4)).T
            out_x3_4 = torch.squeeze(unfold(out_x3_4)).T

        out_x1_1 = t_norm(out_x1_1)
        out_x1_2 = t_norm(out_x1_2)
        out_x1_3 = t_norm(out_x1_3)
        out_x1_4 = t_norm(out_x1_4)
        out_x2_1 = t_norm(out_x2_1)
        out_x2_2 = t_norm(out_x2_2)
        out_x2_3 = t_norm(out_x2_3)
        out_x2_4 = t_norm(out_x2_4)
        out_x3_1 = t_norm(out_x3_1)
        out_x3_2 = t_norm(out_x3_2)
        out_x3_3 = t_norm(out_x3_3)
        out_x3_4 = t_norm(out_x3_4)

        q1 = []
        q2 = []
        q3 = []
        q4 = []
        lamda1 = []
        lamda2 = []
        lamda3 = []
        lamda4 = []

        for k1 in range(out_x1_1.shape[0]):
            t1, a1, b1 = lamda(out_x1_1[k1], out_x2_1[k1])
            c1 = max(a1, b1)
            q1_cnn_1 = (t1*cosine_similarity(out_x1_1[k1], out_x3_1[k1]) + (1-t1)*cosine_similarity(out_x2_1[k1], out_x3_1[k1]))
            lamda1.append(c1)
            q1.append(q1_cnn_1)
        for k2 in range(out_x1_2.shape[0]):
            t2, a2, b2 = lamda(out_x1_2[k2], out_x2_2[k2])
            c2 = max(a2, b2)
            q2_cnn_1 = (t2*cosine_similarity(out_x1_2[k2], out_x3_2[k2]) + (1-t2)*cosine_similarity(out_x2_2[k2], out_x3_2[k2]))
            lamda2.append(c2)
            q2.append(q2_cnn_1)
        for k3 in range(out_x1_3.shape[0]):
            t3, a3, b3 = lamda(out_x1_3[k3], out_x2_3[k3])
            c3 = max(a3, b3)
            q3_cnn_1 = (t3*cosine_similarity(out_x1_3[k3], out_x3_3[k3]) + (1-t3)*cosine_similarity(out_x2_3[k3], out_x3_3[k3]))
            lamda3.append(c3)
            q3.append(q3_cnn_1)
        for k4 in range(out_x1_4.shape[0]):
            t4, a4, b4 = lamda(out_x1_4[k4], out_x2_4[k4])
            c4 = max(a4, b4)
            q4_cnn_1 = (t4*cosine_similarity(out_x1_4[k4], out_x3_4[k4]) + (1-t4)*cosine_similarity(out_x2_4[k4], out_x3_4[k4]))
            lamda4.append(c4)
            q4.append(q4_cnn_1)

        la1 = lamda1 / np.sum(lamda1)
        la2 = lamda2 / np.sum(lamda2)
        la3 = lamda3 / np.sum(lamda3)
        la4 = lamda4 / np.sum(lamda4)
        q_cnn = (np.sum(la1*q1) + np.sum(la2*q2) + np.sum(la3*q3) + np.sum(la4*q4))/4
        q.append(q_cnn)
        toc = time.time()
        print("end-{:}:".format(num), toc-tic, "s")
        sheet_score.append(q)
        Q_data.save("c_Q_cnn.xlsx")



if __name__ == '__main__':
    evaluate_Qcnn('images/color', 'tif', 1)
