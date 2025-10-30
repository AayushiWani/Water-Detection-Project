# Water-Detection-Project

Automate water body detection using NDWI on Landsat 8 satellite imagery. MATLAB code preprocesses bands, enhances imagery, computes NDWI, segments water features, and visualizes results. Ideal for remote sensing, environmental studies, and reproducible geospatial analysis.

---

## Workflow Overview

This project enables fast, automated detection and visualization of water bodies using open-source satellite data and reproducible MATLAB scripts.

---

## Steps to Perform

### 1. **Create a USGS Account**
Register for a free account at [USGS EarthExplorer](https://earthexplorer.usgs.gov). An account is required to order, manage, and download most datasets.

### 2. **Define Region of Interest**
Log in and use the map interface or enter coordinates, address, shapefile, or draw a polygon to select your geographic area.
- Select regions by:
  - Clicking the interactive map
  - Drawing a bounding box or polygon
  - Uploading shapefiles or KML files

### 3. **Set a Date Range**
Specify the start and end dates for your data search. This helps target seasonal events or historical periods.

### 4. **Select Dataset(s)**
Choose appropriate datasets for water and land monitoring:
- *Landsat Collections (for NDWI)*
- *Sentinel-2*
- *MODIS*
- *High-resolution datasets*
- *DEM (elevation data)*
Each offers unique spatial, spectral, and temporal qualities.

### 5. **Apply Filters**
Use the “Additional Criteria” tab to refine searches by:
- Cloud cover percentage
- Sensor type
- Data quality

### 6. **Preview & Select Scenes**
Check preview images and metadata, and select only those scenes that fit your requirements.

### 7. **Download Data**
Add scenes to your cart and download (GeoTIFF and other formats available; bulk downloaders supported).

### 8. **Data Preprocessing**
Unpack and organize your files. Use GIS/remote sensing software (QGIS, ArcGIS, ENVI, Python, or MATLAB):
- Reproject and subset data
- Apply radiometric/atmospheric corrections
- Perform cloud masking

### 9. **Analysis in MATLAB**
Run the provided MATLAB code to:
- Preprocess Landsat bands
- Compute NDWI (Normalized Difference Water Index)
- Segment water features
- Enhance and visualize results

### 10. **Visualization & Reporting**
Visualize the results in GIS software or using script-generated maps. Prepare summary reports, maps, and share findings for reproducibility.

---

## Use Cases

- Water resource monitoring and change detection
- Hydrological mapping for environmental study
- Reproducible geospatial analysis for academic and policy research

---


