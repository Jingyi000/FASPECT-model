function [r1,t1, r2,t2 ] = FASPECT_layer( N, Cab, Cc, Cs, Cant, Cw, Cm, PN, PCab,  r1_up,a1, r4_up, a4)
%Jingyi Jiang 10/2020
%based on an un published article of FASPECT model:
%FASPECT: a model of leaf optical properties accounting for the differences between upper and lower faces
%input:
% N	            Leaf mesophyll structure index                          
% Cab	        Chlorophyll content (mug/cm2) 	                   
% Cc            Carotenoids content (mug/cm2)
% Cs            Brown pigment content (relative unit)               
% Cant          Anthocyanins content (mug/cm2)
% Cw	        Water content (g/cm2) 			               
% Cm	        Dry matter content (g/cm2)	                        
% PN            the ratio between N  of the palisade mesophyll and the total N 
% PCab          the ratio between Cab (Cc) in palisade mesophyll and total Cab (Cc)
% r1_up          upper epidermis reflectance
% r4_up          Lower epidermis reflectance
% a1             r1_down/r1_up
% a4             r4_up/r4_down
% output:
% r1 and t1 are reflectance and transmittance emerges from the upper face of the leaf
% r2 and t2 are reflectance and transmittance emerges from the lower face of the leaf
%% The parametrisation
% first layer: upper epidermis
t1_up = 1 - r1_up;
r1_down=a1*r1_up;
t1_down = 1 - r1_down;

% second layer: palisade parenchym
Cab2 = Cab.*PCab;
Cc2 = Cc.*PCab;
Cs2 = Cs.*PN;
Cant2 = Cant.*PN;
Cw2 = Cw*PN;
Cm2 = Cm*PN ;
N2 = N*PN;

rt2_down = faspect_rt( N2, Cab2, Cc2, Cant2, Cs2,Cw2, Cm2,59);
r2_down=rt2_down(:,1); t2_down=rt2_down(:,2);

rt2_up = faspect_rt( N2, Cab2, Cc2, Cant2, Cs2,Cw2, Cm2,90);
r2_up=rt2_up(:,1); t2_up=rt2_up(:,2);

% third layer: spongy mesophyll
Cab3 = Cab* (1-PCab);
Cc3 = Cc* (1-PCab);
Cs3 = Cs* (1-PN);
Cant3 = Cant.*(1-PN);
Cw3 = Cw*(1-PN); 
Cm3 = Cm*(1-PN); 
N3 = N*(1-PN);  

rt3_down = faspect_rt( N3, Cab3, Cc3, Cant3, Cs3,Cw3, Cm3,90);
r3_down=rt3_down(:,1); t3_down=rt3_down(:,2);

rt3_up = faspect_rt( N3, Cab3,Cc3, Cant3, Cs3, Cw3, Cm3,59);
r3_up=rt3_up(:,1); t3_up=rt3_up(:,2);

% four layer: lower epidermis
t4_up = 1 - r4_up;
r4_down=r4_up/a4;
t4_down = 1 - r4_down;

%% Two layers interaction
r12down = r1_down + (r2_down.* t1_up .*t1_down)./ ( 1 - r1_up.*r2_down);
t12down = (t1_down .* t2_down) ./ ( 1 - r1_up.*r2_down);
r12up = r2_up + (r1_up .* t2_up .* t2_down) ./ ( 1 - r1_up.*r2_down);
t12up = (t1_up .* t2_up) ./ ( 1 - r1_up.*r2_down);

%% Three layer interaction
r123down = r12down + (t12down .* r3_down .* t12up)./ (1- r3_down .* r12up);
t123down = (t12down .* t3_down) ./ (1- r3_down .* r12up);
r123up = r3_up + (t3_up .* r12up .* t3_down) ./(1- r3_down .* r12up);
t123up = (t3_up .* t12up) ./ (1- r3_down .* r12up);

%% Final computation
r1 = r123down + (t123down .* r4_down .* t123up) ./ (1 - r4_down.*r123up);
t1 = (t4_up .* t123up) ./ (1 - r4_down .* r123up);
t2 = (t123down.*t4_down) ./ (1 - r4_down .* r123up);
r2 = r4_up + (t4_up.*r123up.*t4_down) ./ (1 - r4_down.* r123up);
end
