data=load('cv_cluster_data.txt')
x=data(:,1)
y=data(:,2)
z=data(:,3)
xlin=linspace(min(x),max(x),500)
ylin=linspace(min(y),max(y),500)
[X,Y]=meshgrid(xlin,ylin)
Z=griddata(x,y,z,X,Y,'cubic')
contourf(X,Y,Z,20,'LineStyle','none')
h=colorbar
xlabel('CV1','Interpreter','latex','Fontname','TimesNewRoman')
ylabel('CV2','Interpreter','latex','Fontname','TimesNewRoman')
title(h,'Distribution','Position',[65.0 180.0 50.0],'Rotation',90)


