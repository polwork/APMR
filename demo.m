%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is a demo code for the quality assessment of the polarization images
% proposed in our following TIP paper:
% 
% N. Li, B. Le Teurnier, M. Boffety, F. Goudail, Y. Zhao and Q. Pan, "No-Reference 
% Physics-Based Quality Assessment of Polarization Images and its Application to Demosaicking," 
% in IEEE Transactions on Image Processing, doi: 10.1109/TIP.2021.3122085.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% Copyright (c) Northwestern Polytechnical University.                    %
%                                                                         %
% All rights reserved.                                                    %
% This work should only be used for nonprofit purposes.                   %
%                                                                         %
% AUTHORS:                                                                %
%     Ning Li , Benjamin Le Teurnier, Matthieu Boffety, Fran?ois Goudail, %
%     Yongqiang Zhao, and Quan Pan                                        %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear all
close all

load('example.mat');
[m,n] = size(Im0);
% Add Gaussian noise
sigma = 10;
In0 = Im0 + sigma*randn(m,n);
In45 = Im45 + sigma*randn(m,n);
In90 = Im90 + sigma*randn(m,n);
In135 = Im135 + sigma*randn(m,n);
% Compute APMR criterion for quality assessment of polarization images with
% Eq. (15) and (16) in the paper
APMR = APMR_campute(In0,In45,In90,In135,8,0,0);
fprintf('APMR: %.2f dB \n', APMR);
% Compute and display the measurement error component R with Eq. (8) in the paper
R_ideal = Im0 + Im90 - Im45 - Im135;
R_noisy = In0 + In90 - In45 - In135;
figure
subplot(121)
imshow(R_ideal,[])
colormap jet;
colorbar
title('R (ideal input)')
subplot(122)
imshow(R_noisy,[])
colormap jet;
colorbar
title('R (noisy input)')