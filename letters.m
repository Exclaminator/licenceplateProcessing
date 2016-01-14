zero=readim('testData/0.png');
zero=dip_array(zero);
zero= im2bw(zero, 0.5);
zero= imcomplement(zero);


one=readim('testData/1.png');
one=dip_array(one);
one= im2bw(one, 0.5);
one= imcomplement(one);

array=cat(3, zero, one);
%Dit werkt op deze manier -> gecheckt door te kijken naar de pixelwaarden. 
%Het enige wat vreemd is, is dat als je dip_image doet van array dat je dan
%alleen maar het eerste object te zien krijgt terwijl de rest er wel inzit.

