function [mco] = coocorencia_2Dv2 (img, mask,d)
%d=0  %distancia extra a ser dada , será 0 iniclamnete para começarmos com a adjacencia mais proxima
mco(:,:)= zeros(256,256);%matriz de coocorencia inicia-se zerada
[Ny,Nx,Nz] = size(img); %encontra as dimensões da matriz 
GLmax = 255; % maximo valor de graylevel
roi = find(mask);
A = length(roi);     
for f=1:A
    k = roi(f);
    inds = [k+1, k-1, k+Ny, k-Ny, ...
        k + 1 + Ny,k + 1 - Ny,...
        k - 1 + Ny,k - 1 - Ny];     
        inds = inds +d;
    for f2=1:length(inds)
        k2 = inds(f2);
        if (k2 > 0 && k2 < Nx*Ny)
            if mask(k2) ~= 0
                for i=0:GLmax
                    for j=0:GLmax
                        if ( img(k)==i && img (k2)==j )
                          mco(i+1,j+1)= mco(i+1,j+1) + 1;
                        end
                    end
                end
            end
       end
    end
end              
end