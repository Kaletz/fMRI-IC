function [xxxx]= rotina_mco2D(data,mask,G)

%%%% checar os d

[Ny,Nx,Nz] = size(data);
ALL= zeros (Nz,59);
maximo=max(max(max(data)));
dividido = data ./ maximo;
imagem_normalizada = dividido .* (G-1);
img = round (imagem_normalizada);
area= zeros (1,Nz);
m2= rot90 (permute (mask, [2 3 1]));

for g=1:Nz
    area(g) = length (find(m2(:,:,g)));
end
%save ('area.txt', 'area', '-ascii','-double');
%open area.txt
for r=1:Nz
    for d=0:4
        if area(r) > 0
            cmco=coocorencia_2DU (img(:,:,r), m2(:,:,r),d,G);
            p=probabilidade_mco (cmco,G);
            ASM= asm_mco(p,G);
            CO=con2_mco(p,G);
            COR=cor_mco(p,G);
            SO=var_mco(p,G);
            IDM=idm_mco(p,G);
            E=entro_mco(p,G);
            SA=summed_mco(p,G);
            SV=sumvar_mco(p,G);
            SE=sumentro_mco(p,G);
            DV=vardif_mco(p,G);
            DE=entrodif_mco(p,G);
            e=d+d*11;
            ALL(r,e+1)= ASM;
            ALL(r,e+2)= CO;
            ALL(r,e+3)= COR;
            ALL(r,e+4)= SO;
            ALL(r,e+5)= IDM;
            ALL(r,e+6)= SA;
            ALL(r,e+7)= SV; 
            ALL(r,e+8)= SE;
            ALL(r,e+9)= E;
            ALL(r,e+10)= DV;
            ALL(r,e+11)= DE;
        end
    end
end
prop= zeros (Nz,59);
for b=1:Nz
    for h=1:59 
        if ( isfinite (ALL(b,h)))
            prop(b,h)=ALL(b,h)*area(b);
        end
    end
end
soma= zeros (1,59);
soma= sum (prop,1);
fin= soma ./ (length (find(mask)));
save ('fin2D.txt', 'fin', '-ascii','-double');
open fin2D.txt

end
