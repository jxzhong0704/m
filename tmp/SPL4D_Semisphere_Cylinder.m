function [x_ss,y_ss,z_ss,SPL_ss,x_cz,y_cz,z_cz,SPL_cz]=SPL4D_Semisphere_Cylinder(x,y,z,A,R,a1,a2,a3,a4);
%%�ڰ����Բ��ģ���ϻ�����άɫͼ%%%%%%
%%����x,y,zΪ�������(������)��AΪ�����ѹ����ֵ(������)��RΪ�����Բ���뾶��a1,a2Ϊȱʡ����Ƕȷ�Χ,a3~a4ͬ%%
%%For R=0.5m,a1=45,a2=157.5,a3=202.5,a4=315;For R=1m,a1=67.5,a2=135,a3=225,a4=292.5;

x0=x.';y0=y.';z0=z.';SPL1=A.';

%Interpolation
F=scatteredInterpolant([x0,y0,z0],SPL1);
coef1=4;%��������0-90�㣬ÿ15��ȡ�㣬6�ݣ�ƽ���0-360�㣬ÿ22.5��ȡ�㣬16�ݡ�
ns=6*16*coef1+1;%Number of Elevation, Angle and Z-plane

%Semisphere
alpha=linspace(0,pi/2,ns);phi=linspace(0,pi*2,ns);
[alpha,phi]=meshgrid(alpha,phi);%Meshgrid
R_ss=R*ones(size(phi));
x_ss=R_ss.*sin(alpha).*cos(phi);%Transfer Spherical Coordinate to Cartesian Coordinate 
y_ss=R_ss.*sin(alpha).*sin(phi);
z_ss=R_ss.*cos(alpha)+1.15;
SPL_ss=reshape(F([reshape(x_ss,ns^2,1),reshape(y_ss,ns^2,1),reshape(z_ss,ns^2,1)]),ns,ns);%Calculate Interpolation Value

%Cylinder
nc=23*16+1;%Բ��z����0-1.15m��ÿ0.05ȡ�㣬23�ݣ�Բ�ܷ���0-360����ÿ22.5��ȡ�㣬16�ݡ�
[x_cz,y_cz,z_cz]=cylinder(R*ones(nc,1),nc-1);z_cz=z_cz*1.15;%Meshgrid
SPL_cz=reshape(F([reshape(x_cz,numel(x_cz),1),reshape(y_cz,numel(y_cz),1),reshape(z_cz,numel(z_cz),1)]),nc,nc);%Calculate Interpolation Value
SPL_cz(:,floor((a1:a2)/360*nc))=0/0;%Empty Useless Surface
SPL_cz(:,floor((a3:a4)/360*nc))=0/0;

% figure
surf(x_ss,y_ss,z_ss,SPL_ss);hold on;
surf(x_cz,y_cz,z_cz,SPL_cz);
shading interp;%Show inner or not
axis equal;
% xlabel('x(m)','fontsize',12);ylabel('y(m)','fontsize',12);zlabel('z(m)','fontsize',12);
% unit=strcat(get(colorbar,'YTickLabel'),' dB');
% set(colorbar,'YTickLabel',unit);
end