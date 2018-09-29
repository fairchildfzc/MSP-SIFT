% 
%   Copyright (C) 2016  Starsky Wong <sununs11@gmail.com>
% 
%   Note: The SIFT algorithm is patented in the United States and cannot be
%   used in commercial products without a license from the University of
%   British Columbia.  For more information, refer to the file LICENSE
%   that accompanied this distribution.

clear all
clc
folder_vec = ["bark","bikes","boat","graf","leuven","trees","ubc","wall"];
for i = 2:2
%for i = 1:length(folder_vec)
    folder_string = "./dataset/"+folder_vec(i)+"/";
    folder_char = char(folder_string);
    if (i==3)
        files = dir([folder_char,'*.pgm']);
    else
        files = dir([folder_char,'*.ppm']);
    end
    global Hp2p;
    global thefirstcountnum;
    %H1to2p_dir = char(folder_string+"H1to2p");
    load(char(folder_string+"H1to2p"));
    load(char(folder_string+"H1to3p"));
    load(char(folder_string+"H1to4p"));
    load(char(folder_string+"H1to5p"));
    load(char(folder_string+"H1to6p"));
    Hp2p(:,:,1) = H1to2p;
    Hp2p(:,:,2) = H1to3p;
    Hp2p(:,:,3) = H1to4p;
    Hp2p(:,:,4) = H1to5p;
    Hp2p(:,:,5) = H1to6p;
    % img1 = imread('scene.pgm');
    % img2 = imread('box.pgm');
    fp1 = fopen('matchnumber.txt','a+');
    fp2 = fopen('correctmatchnumber.txt','a+');
    fp3 = fopen('correctrate.txt','a+');
    fprintf(fp1,'%s\r\n',folder_vec(i));
    fprintf(fp2,'%s\r\n',folder_vec(i));
    fprintf(fp3,'%s\r\n',folder_vec(i));
    fclose(fp1);
    fclose(fp2);
    fclose(fp3);
    for thefirstcountnum = 2:2
        img1 = imread([folder_char,files(1).name]);
        img2 = imread([folder_char,files(thefirstcountnum+1).name]);
        [des1,loc1] = getFeatures(img1);
        [des2,loc2] = getFeatures(img2);
        matched = match(des1,des2);
        %    drawFeatures(img1,loc1);
        %   drawFeatures(img2,loc2);
        drawMatched(matched,img1,img2,loc1,loc2);
    end
end



