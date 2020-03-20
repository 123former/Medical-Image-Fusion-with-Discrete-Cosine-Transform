function[imf] = DCTIFlp(IM1,IM2)

IM = reduce2d(IM1);
Id1 = IM1 - IM;
IM1 = IM;
IM = reduce2d(IM2);
Id2 = IM2 -IM;
IM2 = IM;
r=9;
ker=ones(2*r+1,2*r+1)/((2*r+1)*(2*r+1));
AA1=imfilter(abs(Id1),ker);
AA2=imfilter(abs(Id2),ker);
dl=AA1>AA2;
%     dl = abs(Id1)-abs(Id2)>=0;
Idf = dl.*Id1+(~dl).*Id2;
    
imf = 0.5*(IM1+IM2);
imf = Idf + imf;
    
function[Id] = reduce2d(I)
mn = size(I);
temp=zeros(mn(1),mn(2));
for i=1:mn(1)
    for j=1:mn(2)
        if((i+j)<(mn(1)/4))
           temp(i,j)=1;
        end
    end
end
IDCT = dct2(I);
Id =idct2(IDCT.*temp,[mn(1) mn(2)]);
% Id = round(idct2(IDCT(1:mn(1),1:mn(2))));