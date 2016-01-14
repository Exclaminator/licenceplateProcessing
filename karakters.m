zero=readim('testData/0.png');
zero=dip_array(zero);
zero= im2bw(zero);

one=readim('testData/1.png');
one=dip_array(one);
one= im2bw(one);

two=readim('testData/2.png');
two=dip_array(two);
two= im2bw(two);

three=readim('testData/3.png');
three=dip_array(three);
three= im2bw(three);

four=readim('testData/4.png');
four=dip_array(four);
four= im2bw(four);

five=readim('testData/5.png');
five=dip_array(five);
five= im2bw(five);

six=readim('testData/6.png');
six=dip_array(six);
six= im2bw(six);

seven=readim('testData/7.png');
seven=dip_array(seven);
seven= im2bw(seven);

eight=readim('testData/8.png');
eight=dip_array(eight);
eight= im2bw(eight);

nine=readim('testData/9.png');
nine=dip_array(nine);
nine= im2bw(nine);

array=cat(3, zero, one, two, three, four, five, six, seven, eight, nine);
array=imcomplement(array);
%Dit werkt op deze manier -> gecheckt door te kijken naar de pixelwaarden dmv sum(sum(array)) 
%te vergelijken met de som van de pixels van de losse karakters. 
%Het enige wat vreemd is, is dat als je dip_image doet van array dat je dan
%alleen maar het eerste object te zien krijgt terwijl de rest er wel inzit.

B=readim('testData/B.png');
B=dip_array(B);
B= im2bw(B);

D=readim('testData/D.png');
D=dip_array(D);
D= im2bw(D);

F=readim('testData/F.png');
F=dip_array(F);
F= im2bw(F);

G=readim('testData/G.png');
G=dip_array(G);
G= im2bw(G);

H=readim('testData/H.png');
H=dip_array(H);
H= im2bw(H);

J=readim('testData/J.png');
J=dip_array(J);
J= im2bw(J);

K=readim('testData/K.png');
K=dip_array(K);
K= im2bw(K);

L=readim('testData/L.png');
L=dip_array(L);
L= im2bw(L);

M=readim('testData/M.png');
M=dip_array(M);
M= im2bw(M);

N=readim('testData/N.png');
N=dip_array(N);
N= im2bw(N);

P=readim('testData/P.png');
P=dip_array(P);
P= im2bw(P);

R=readim('testData/R.png');
R=dip_array(R);
R= im2bw(R);

S=readim('testData/S.png');
S=dip_array(S);
S= im2bw(S);

T=readim('testData/T.png');
T=dip_array(T);
T= im2bw(T);

V=readim('testData/V.png');
V=dip_array(V);
V= im2bw(V);

X=readim('testData/X.png');
X=dip_array(X);
X= im2bw(X);

Z=readim('testData/Z.png');
Z=dip_array(Z);
Z= im2bw(Z);

array2=cat(3, B,D,F,G,H,J,K,L,M,N,P,R,S,T,V,X,Z);
array2=imcomplement(array2);