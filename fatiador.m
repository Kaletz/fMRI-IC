function [vol]= fatiador (img, A,B)

[Ny,Nx,Nz] = size(img);

vol = zeros (Ny,Nx, B-A+1);

k=1;

for i=A:B

    vol (:,:,k)= img(:,:,i);
    k=k+1;


end

save ('volume.mat', 'volume', '-mat');

end

%volume= mat2gray(volume);

%t= volume(:,:,i);

%imwrite (t,'fatiax.bmp');