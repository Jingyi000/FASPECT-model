function rt=faspect_rt(N,Cab,Cc,Cant,Cs,Cw,Cdm,ang)
% Jingyi Jiang ,12/2019
% [r,t]=faspect_rt(N,Cab,Cc,Cant,Cs,Cw,Cdm,ang): Computes leaf reflectance and transmittance 
% of a leaf characterized: 
% The inputs are:
% N	            Leaf mesophyll structure index                          
% Cab	        Chlorophyll content (mug/cm2) 	                   
% Cc            Carotenoids content (mug/cm2)
%Cant           Anthocyanins content (mug/cm2)
% Cs            Brown pigment content (relative unit)               
% Cw	        Water content (g/cm2) 			               
% Cdm	        Dry matter content (g/cm2)	                        
% Ang 	        determines the first interface transmittivity (degrees) 

global coefabs
K=Cab.*coefabs(:,1)+Cw.*coefabs(:,2)+Cdm.*coefabs(:,3)+Cs*coefabs(:,4)+Cc.*coefabs(:,5)+Cant.*coefabs(:,6); 
rt=noyau(coefabs(:,7),N,K./N,tav(ang*pi/180,coefabs(:,7)));
