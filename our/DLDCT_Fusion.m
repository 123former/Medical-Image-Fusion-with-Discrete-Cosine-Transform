function F = DLDCT_Fusion(img1, img2)
A=double(img1)/255;
B=double(img2)/255;
tic;
npd = 16;
fltlmbd = 0.01;
[s1_l, s1_h] = lowpass1(A, fltlmbd, npd);
[s2_l, s2_h] = lowpass1(B, fltlmbd, npd);

r=3;
ker=ones(2*r+1,2*r+1)/((2*r+1)*(2*r+1));
AA1=imfilter(s1_l,ker);
AA2=imfilter(s2_l,ker);
map=AA1>AA2;
I_l=s1_l.*map+s2_l.*(~map);
% fusion will start here
I_h = DCTIFlp(s1_h,s2_h);
F=uint8((I_l+I_h)*255);
end