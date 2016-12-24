
figure(1);
x = [1;2;4;5];
y = [1;3;7;9];
% [x_gr, y_gr] = meshgrid(x,y);
spl = [0,0,3,4;0,0,4,5;3,4,5,6;5,6,7,8];
pcolor(x,y,spl);
shading interp
colorbar;

xx = [1;2];
yy = [1;3];
spll = [1,1;1,1];
hold on;
h = pcolor(xx,yy,spll);
set(h,'facecolor','w');
shading interp

xxx = [4;5];
yyy = [7;9];
hold on
hh = pcolor(xxx,yyy,spll);
set(hh,'facecolor','w');

