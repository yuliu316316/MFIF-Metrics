%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

This package contains the resources that are associated with the following paper:

Yu Liu, Zhengzheng Qi, Juan Cheng, Xun Chen, "Rethinking the Effectiveness of Objective Evaluation Metrics in Multi-focus Image Fusion: A Statistic-based Approach," IEEE Transactions on Pattern Analysis and Machine Intelligence, early access, 2024.

Edited by Yu Liu and Zhengzheng Qi.

Usage of the above resources is free for research purposes only.

Thank you.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Requirements:

-Matlab R2017b
-python 3.7
-tqdm 4.66.1
-numpy 1.21.5
-torch 1.13.1
-torchvision 0.4.2
-openpyxl 3.1.2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Correlation_test.m: Calculate correlation measurements (SRCC and KRCC are mainly adopted) between fusion metrics and a FR-IQA index based on the results saved in the "Metric-results" folder and the "FR-IQA-results" folder.

Wilcoxon_test.m: Perform the Wilcoxon signed-rank test for signivicance comparision between two fusion metrics.

Metric_calculation.m: Calculate the scores of fusion metrics (provided in the "fusion-metrics" folder).

FRIQA_calculation.m: Calculate the score of FRIQA models (provided in the "FR-IQA" folder).

The "QCNN-metric" folder: The Pytorch implementation of the CNN-based fusion metric proposed in this paper. 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Contact:


Don't hesitate to contact me if you meet any problems when using this code.

Yu Liu
Department of Biomedical Engineering
Hefei University of Technology                                                            
Email: yuliu@hfut.edu.cn; lyuxxz@163.com
Homepage: https://sites.google.com/site/yuliu316316; https://github.com/yuliu316316


Last update: 23-March-2024