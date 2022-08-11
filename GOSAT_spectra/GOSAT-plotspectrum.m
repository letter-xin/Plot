filename='FTSL1B/GOSATTFTS2020060102500030220_1BSPOD220220.01';
dwv1= h5read(filename,'/spectrum/SWIR/interval');
dwv2= h5read(filename,'/spectrum/TIR/interval');
nb1=h5read(filename,'/spectrum/SWIR/band1/obsDataPointNum');
nb2=h5read(filename,'/spectrum/SWIR/band2/obsDataPointNum');
nb3=h5read(filename,'/spectrum/SWIR/band3/obsDataPointNum');
nb4=h5read(filename,'/spectrum/TIR/band4/obsDataPointNum');
wvb1=h5read(filename,'/spectrum/SWIR/band1/obsBeginningWavenumber');
wvb2=h5read(filename,'/spectrum/SWIR/band2/obsBeginningWavenumber');
wvb3=h5read(filename,'/spectrum/SWIR/band3/obsBeginningWavenumber');
wvb4=h5read(filename,'/spectrum/TIR/band4/obsBeginningWavenumber');
band1=h5read(filename,'/spectrum/SWIR/band1/observedSpectrum')*1e-4;
band2=h5read(filename,'/spectrum/SWIR/band2/observedSpectrum')*1e-4;
band3=h5read(filename,'/spectrum/SWIR/band3/observedSpectrum')*1e-4;
band4=h5read(filename,'/spectrum/TIR/band4/observedSpectrum')*1e-4;
wavenumber1=zeros(nb1,1);
wavenumber2=zeros(nb2,1);
wavenumber3=zeros(nb3,1);
wavenumber4=zeros(nb4,1);
for i=1:nb1;
    wavenumber1(i)=wvb1+(i-1)*dwv1;
end
for i=1:nb2;
    wavenumber2(i)=wvb2+(i-1)*dwv1;
end
for i=1:nb3;
    wavenumber3(i)=wvb3+(i-1)*dwv1;
end
for i=1:nb4;
    wavenumber4(i)=wvb4+(i-1)*dwv2;
end
% wavenumber1=10000./wavenumber1
% wavenumber2=10000./wavenumber2
% wavenumber3=10000./wavenumber3
% wavenumber4=10000./wavenumber4

f = figure(1);

ax1= subplot(2,2,1);
plot(wavenumber1,band1(1,:,1,55),'b','LineWidth',1.0);
ax = gca;
ax.XAxis.Exponent = 0;
set(ax,'FontSize',20)
 axis([12700 13400 0 7E-7])
pbaspect([5 2 1])
grid on
title('Band 1','FontSize',20)
rectangle('Position',[12950,6e-7,280,0.5e-7],'FaceColor',[0.75 0 .75],'EdgeColor',[0.75 0 .75],'LineWidth',3)
txt = 'O_2';
text(13240,6.2e-7,txt,'FontSize',20,'Color',[0.75 0 .75])
xlabel('wavenumber (cm^{-1})')
ylabel('I_\eta  (W/cm^2/cm^{-1}/sr)')

ax2= subplot(2,2,2);
plot(wavenumber2,band2(1,:,1,1),'b','LineWidth',1.0);
ax = gca;
set(ax,'FontSize',20)
axis([5400 6700 0 0.7E-7])
pbaspect([5 2 1])
grid on
title('Band 2','FontSize',20)
rectangle('Position',[5800,6.1e-8,330,0.5e-8],'FaceColor',[0 0.7 0],'EdgeColor',[0 0.7 0],'LineWidth',3)
rectangle('Position',[6180,6.1e-8,250,0.5e-8],'FaceColor','r','EdgeColor','r','LineWidth',3)
txt = 'CH_4';
text(5680,6.2e-8,txt,'FontSize',20,'Color',[0 0.7 0])
txt = 'CO_2';
text(6460,6.2e-8,txt,'FontSize',20,'Color','r')
xlabel('wavenumber (cm^{-1})')
ylabel('I_\eta  (W/cm^2/cm^{-1}/sr)')

ax3= subplot(2,2,3);
plot(wavenumber3,band3(1,:,1,1),'b','LineWidth',1.0);
ax = gca;
set(ax,'FontSize',20)
axis([4600 5400 0 1E-7])
pbaspect([5 2 1])
grid on
title('Band 3','FontSize',20)
rectangle('Position',[4750,8.6e-8,400,0.8e-8],'FaceColor','r','EdgeColor','r','LineWidth',3)
rectangle('Position',[5170,8.6e-8,130,0.8e-8],'FaceColor','b','EdgeColor','b','LineWidth',3)
txt = 'CO_2';
text(4675,8.8e-8,txt,'FontSize',20,'Color','r')
txt = 'H_2O';
text(5310,8.8e-8,txt,'FontSize',20,'Color','b')
xlabel('wavenumber (cm^{-1})')
ylabel('I_\eta  (W/cm^2/cm^{-1}/sr)')

ax4= subplot(2,2,4);
plot(wavenumber4,band4(1,:,1),'r','LineWidth',1.0);
ax = gca;
set(ax,'FontSize',20)
 axis([700 1800 0 1.2e-9])
pbaspect([5 2 1])
grid on
title('Band 4','FontSize',20)
rectangle('Position',[712,1.04e-9,100,0.09e-9],'FaceColor','r','EdgeColor','r','LineWidth',3)
rectangle('Position',[980,1.04e-9,110,0.09e-9],'FaceColor','r','EdgeColor','r','LineWidth',3)
rectangle('Position',[1250,1.04e-9,200,0.09e-9],'FaceColor',[0 0.7 0],'EdgeColor',[0 0.7 0],'LineWidth',3)
txt = 'CO_2';
text(840,1.07e-9,txt,'FontSize',20,'Color','r')
txt = 'CH_4';
text(1470,1.07e-9,txt,'FontSize',20,'Color',[0 0.7 0])
xlabel('wavenumber (cm^{-1})')
ylabel('I_\eta  (W/cm^2/cm^{-1}/sr)')
h=gcf;
set(h,'PaperOrientation','landscape');
saveas(gcf,'myfigure2.pdf')