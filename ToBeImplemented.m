[y,x] = find(rotatedBM);
[~,loc] = min(y+x);
C = [x(loc),y(loc)];
[~,loc] = min(y-x);
C(2,:) = [x(loc),y(loc)];
[~,loc] = max(y+x);
C(3,:) = [x(loc),y(loc)];
[~,loc] = max(y-x);
C(4,:) = [x(loc),y(loc)];
%% 3. Plot the corners
imshow(rotatedBM); hold all
plot(C([1:4 1],1),C([1:4 1],2),'r','linewidth',3);
%% 4. Find the locations of the new  corners
L = mean(C([1 4],1));
R = mean(C([2 3],1));
U = mean(C([1 2],2));
D = mean(C([3 4],2));
C2 = [L U; R U; R D; L D];
%% 5. Do the image transform
figure
T = cp2tform(C ,C2,'projective');
IT = imtransform(rotatedBM,T); %IM2BW is not necessary
imshow(IT); hold all