# FASPECT-model
FASPECT model is proposed to explicitly account for the inhomogeneity in the leaf structure and simulate the corresponding differences in leaf optical properties between faces.

Description of FASPECT model is found in : Jiang J, Comar A, Weiss M, et al. FASPECT: A model of leaf optical properties accounting for the differences between upper and lower faces. Remote Sensing of Environment, 2021, 253: 112205. https://doi.org/10.1016/j.rse.2020.112205

...
Inputs:
N:	            Leaf mesophyll structure index                          
Cab	:        Chlorophyll content (mug/cm2) 	                   
Cc  :          Carotenoids content (mug/cm2)
Cs   :         Brown pigment content (relative unit)               
Cant  :        Anthocyanins content (mug/cm2)
Cw	   :     Water content (g/cm2) 			               
Cm	    :    Dry matter content (g/cm2)	                        
PN       :     the ratio between N  of the palisade mesophyll and the total N 
PCab      :    the ratio between Cab (Cc) in palisade mesophyll and total Cab (Cc)
r1_up      :    upper epidermis reflectance
r4_up       :   Lower epidermis reflectance
a1           :  r1_down/r1_up
a4            : r4_up/r4_down

Output:
r1 and t1 are reflectance and transmittance emerges from the upper face of the leaf
r2 and t2 are reflectance and transmittance emerges from the lower face of the leaf
...
