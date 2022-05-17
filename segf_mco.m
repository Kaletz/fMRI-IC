function [segmentf] = segf_mco (p)


disp('Qual imagem deseja segmentar?');
disp('1 – Figura1');
disp('2 – Figura2');
disp('3 – Figura3');
disp('4 – Figura4');
disp('5 - Fim');
val1=input('Digite a opção desejada:');
if val1==1
a=mmreadgray('Figura1.tif');
figure(1);mmshow(a);
elseif val1==2
a=mmreadgray('Figura2.tif');
figure(1);mmshow(a);
elseif val1==3
a=mmreadgray('Figura3.tif');
figure(1);mmshow(a);
elseif val1==4
a=mmreadgray('Figura4.tif');
figure(1);mmshow(a);
else
disp('Programa finalizado!');
return;
end
h=mmhistogram(a);
figure(2);plot(h);
x=double(min(a(:))):double(max(a(:)));
y=smooth(x',double(h),80);
figure(3);
hold on;
plot(x,h,'g')
plot(x,y,'.m')
xlabel('Valor do pixel (nível de cinza)')
ylabel('Freqüência')
title('Histograma + Suavização')
legend('Histograma','Suavização do Histograma',1)
axis([0 4000 -15 200])
hold off;
p1=polyfit(x',y,10);
p2=polyder(p1);
r_p2=roots(p2);
for i=1:1:9,
if isreal(r_p2(i))
r_r_p2(i)=r_p2(i);
end
end
for i=8:-1:1
if (r_r_p2(i)>r_r_p2(i+1) && r_r_p2(i)>r_r_p2(i-1))
raiz1 = r_r_p2(i);
j = i;
break
end
end
for i=j-1:-1:1
if r_r_p2(i)>0
raiz2 = r_r_p2(i);
break
end
end
figure(4);
hold on;
plot(x,y,'.m');
plot(x,polyval(p1,x),'.g');
xlabel('Valor do pixel (nível de cinza')
ylabel('Freqüência')
title('Suavização do Histograma')
legend('Suavização do Histograma','Ajuste polinomial',1)
axis([100 2500 -20 100])
hold off;
b=mmthreshad(a,round(t));
figure(5);mmshow(b);
c=mmareaopen(b,7000);
figure(6);mmshow(c);
d=mmgradm(mmclohole(c),mmsedisk(0),mmsedisk(2));
e=mmthin(d);
figure(7);mmshow(e);
figure(8);mmshow(a,e);
b1=mmcmp(round(t),'<',a,'<',round(t2));
c1=mmareaopen(b1,5000);
figure(9);mmshow(c1);
d1=mmsubm(b1,c1);
figure(10);mmshow(d1);
e1=mmareaopen(d1,1200);
figure(11);mmshow(e1);
f1=mmthin(mmgradm(mmclohole(e1),mmsecross(0),mmsecross(3)));
figure(12);mmshow(f1);
figure(13);mmshow(a,f1);
d2=mmclohole(c);
figure(14);mmshow(d2);
e2=mmsubm(d2,c);
figure(15);mmshow(e2);
f2=mmareaopen(e2,150);
figure(16);mmshow(f2);
g2=mmgradm(f2);
figure(17);mmshow(g2);
figure(18);mmshow(a,g2);
figure(19);mmshow(a,e,f1,g2);

