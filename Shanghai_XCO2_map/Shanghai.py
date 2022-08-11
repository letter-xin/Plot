from cProfile import label
import os
from turtle import color
import h5py
import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt
from mpl_toolkits.basemap import Basemap
from matplotlib.patches import Polygon

#xco2=[]
longitude_oco=[]
latitude_oco=[]
longitude_gosat=[]
latitude_gosat=[]
units='XCO$_{2}$[ppm]'
path_oco = 'data/OCO_2'
path_gosat = 'data/GOSAT/SWIRL2CO2'

for cur_dir, sub_dir, included_file in os.walk(path_oco):
    for file in included_file:
        h5filepath=cur_dir + "/" + file
        if 'oco2' in h5filepath:
            print(h5filepath)
            with h5py.File(h5filepath, mode='r') as f:
                #data = f['/RetrievalResults/xco2'][:]
                lati = f['/RetrievalGeometry/retrieval_latitude'][:]
                long = f['/RetrievalGeometry/retrieval_longitude'][:]

                #xco2=np.hstack((xco2,data*(10**6)))
                longitude_oco=np.hstack((longitude_oco,long))
                latitude_oco=np.hstack((latitude_oco,lati))
                f.close()

for cur_dir, sub_dir, included_file in os.walk(path_gosat):
    for file in included_file:
        h5filepath=cur_dir + "/" + file
        if 'GOSAT' in h5filepath:
            print(h5filepath)
            with h5py.File(h5filepath, mode='r') as f:
                #data = f['/Data/mixingRatio/XCO2'][:]
                lati = f['/Data/geolocation/latitude'][:]
                long = f['/Data/geolocation/longitude'][:]

                #xco2=np.hstack((xco2,data))
                longitude_gosat=np.hstack((longitude_gosat,long))
                latitude_gosat=np.hstack((latitude_gosat,lati))
                f.close()

#m = Basemap(projection='cyl', resolution='l', llcrnrlat=20, urcrnrlat=40,llcrnrlon=110, urcrnrlon=135)
#m.drawcoastlines(linewidth=0.5)
#m.bluemarble()

fig = plt.figure(figsize=(8, 6), dpi=1000)
ax1 = fig.add_axes([0.1,0.1,0.8,0.8])
m = Basemap(projection='cyl', resolution='f', llcrnrlat=30, urcrnrlat=32,llcrnrlon=120.5, urcrnrlon=122.7,ax=ax1)
shp_info = m.readshapefile("CHN_adm_shp/CHN_adm1",'states',drawbounds=False)
m.fillcontinents(color='white', lake_color='lightskyblue')
m.drawmapboundary(fill_color='skyblue')
# for info,shp in zip(m.states_info,m.states):
#     proid = info['NAME_1']
#     if proid =='Shanghai':
#         poly = Polygon(shp,lw=1)
#         ax1.add_patch(poly)

#m.drawcoastlines(linewidth=1)
#m.fillcontinents(lake_color='aqua')
#m.bluemarble()

m.drawmeridians(np.arange(120, 123, 1), labels=[1,0,0,1])
m.drawparallels(np.arange(30, 32.001, 1), labels=[1,0,0,1])
m.scatter(longitude_gosat, latitude_gosat,c='r',zorder=10, s=45,label='GOSAT')
m.scatter(longitude_oco, latitude_oco,c='b',zorder=10, s=2,label='OCO-2')
#m.fillcontinents(color='gray', lake_color='lightskyblue')
#m.drawmapboundary(fill_color='skyblue')
#m.drawparallels(np.arange(30.7,31.5))
#m.drawmeridians(np.arange(120.5,122.4), labels=[True,False,False,True])
#m.drawmapscale(121, 31, 122, 31.5, 40, barstyle='fancy')
#cb = m.colorbar(location="bottom",pad='10%')
#cb.set_label(units)
#m.legend()
plt.gcf()
plt.legend(loc='upper right')
plt.title('2021-06 Satellite measurements')
plt.tight_layout()
pngfile = "202106_shanghai.png"
fig.savefig(pngfile)