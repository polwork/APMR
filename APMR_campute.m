function APMR = APMR_campute(I0,I45,I90,I135,bitdepth,row,col)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code is an implementation of APMR for the quality assessment of the 
% polarization images proposed in our following TIP paper:
% 
% N. Li, B. Le Teurnier, M. Boffety, F. Goudail, Y. Zhao and Q. Pan, "No-Reference 
% Physics-Based Quality Assessment of Polarization Images and its Application to Demosaicking," 
% in IEEE Transactions on Image Processing, doi: 10.1109/TIP.2021.3122085.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% INPUT:
% 
%     I0,I45,I90,I135: Intensity measurements with polarizer oriented at 0, 45, 90, and 135 degree.
%     bitdepth: The bitdepth of the input images.
%     row,col: The boundary rows and columns that will be excluded in computing APMR.
%     
% OUTPUT:
% 
%     APMR: Quality score of the input polarization images.
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
R_temp = I0 + I90 - I45 - I135; % Eq. (8)
[m,n] = size(I0);
R = R_temp(row+1:m-row,col+1:n-col);
[m,n] = size(R);
R = R.^2;
MAR = (sum(R(:)))/(m*n); % Eq. (15)
% Note: if the input images are normalized to [0,1], one should replace
% ((2^bitdepth-1)^2) with 1.
APMR = 10*log10(((2^bitdepth-1)^2)/MAR); % Eq. (16)
