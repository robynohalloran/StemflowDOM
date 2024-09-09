# StemflowDOM 
Tutorial for Extracting Parallel Factor Analysis (PARAFAC) Components from Stemflow EEMs.
This tutorial covers the operational basics to obtain a stemflow sample EEM from a Horiba Aqualog instrument and fit to the published PARAFAC model for use in the multivariate lignin estimation presented for the manuscript "Stemflow Dissolved Organic Matter Shows Promise as a Proxy for Lignin Composition and Phenolic Monomer Yield in Tree Biomass".The PARAFAC model components were fit from EEMs of the following species: Liriodendron tulipifera L. (yellow poplar), Fagus grandifolia Ehrh. (American beech), and Betula lenta L. (sweet birch), and Pinus rigida Mill. (pitch pine). The settings listed here are only intended for use with this model as described in the manuscript, and may not be valid for other applications.
I.	Equipment and Materials Needed
      •	Horiba Scientific Aqualog (Horiba Instruments, Edison, NJ, USA), (Optional: UV-Vis Spectrophotometer can be separate from Horiba Aqualog)
      •	Glass tower filter set up with pre-combusted 0.7 μm, 47 mm glass fiber filters (Whatman GF/F 1825-047)
      •	1-cm pathlength quartz cuvette
      •	Lens paper (Kim-Wipes)
      •	18 MW (Milli-Q) water
      •	Methanol, HPLC-grade
      •	1000 µL and 200 µL pipettes and tips
      •	Laboratory notebook
      •	Workstation installed with Aqualog software (v. 4.0)
      •	Workstation with RStudio and the following packages installed: stardom, dplyr

II.	Sample set-up 
    1.	After obtaining stemflow samples, filter water samples through a 0.7 μm, 47 mm glass fiber filter (Whatman GF/F 1825-047) to remove particulates. 
    2.	Before obtaining a fluorescence EEM on Aqualog, analyze the UV-Vis absorbance spectrum. This can be done on the Aqualog or any ultraviolet (UV)-Visible spectrophotometer. Ensure the samples have an absorbance <             1.0 at 254 nm to prevent inner filter light screening effects (Kalbitz et al. 2000). If any of the samples absorbance exceeds 1.0 at 254 nm, complete a 1:4 dilution and test again. Record the dilution factor.
    3.	Once your samples have an absorbance less than 1.0, run stemflow water samples (or diluted samples) on a Horiba Scientific Aqualog with a 1-cm quartz cuvette of filtered samples. 

III.	Fluorescence 3D-EEM Collection on Horiba Aqualog
    1.	Turn on the Aqualog instrument and allow it to warm up for at least 20 minutes while the materials are being prepped. 
    2.	Rinse the cuvette with methanol three times to ensure proper sterilization.
    3.	Rinse the sterilized cuvette three times with Milli-Q water. 
    4.	Once the cuvette is thoroughly cleaned, fill it up about ¾ of the way with Milli-Q water, making sure to eliminate as many bubbles as possible. To establish an accurate read from the Aqualog, the outside of the             cuvette needs to be free of all fingerprints and smudge marks. Wipe the outside of the cuvette with a methanol-soaked lens paper if these marks are present, and then tap dry with another lens paper. The cuvette           is then placed into the Aqualog with the UV letters always facing the front of the instrument. This step is to ensure the same optics every time a sample is scanned. Close the lid.
    5.	Once the instrument has warmed up, open the Aqualog Software. Click on File - Save project as - and then name the project and place it in the respective file folder for the work being collected. Click Save and             then note the project name in a laboratory notebook. 
    6.	If this is the first time the Aqualog has been run since turning the instrument on, once the cuvette filled with Milli-Q water is placed into the sample holder click the “RU” button in the top menu of the software         and then click run. Do not change any settings for this scan. This result is the Raman Scan and should have a peak position of 397  1 nm. Record the Raman peak position and its area for your instrument                     maintenance records as well as in your laboratory notebook along with operator name and date. 
    7.	Collect a 3D EEMs blank. Click the H2O box and select 3D. Then select 3D CCD+Absorbance in the popup window and click next. The following parameters need to be changed/verified for this blank to work for the               samples: 
          •	Integration time: 0.4 s
          •	Maximum wavelength: 600 nm 
          •	Minimum wavelength 240 nm
          •	Excitation increment: 3 nm 
          •	Emission increment: 4 pixel (2.33 nm) 
          •	Gain: medium
          •	Identifier: EEMBlank 
          •	Blank: click the three dots following “blank only” and save the blank as MonthDayYearBlank 
       Click “Run” to run this blank and then once finished, remove the cuvette and prepare it appropriately for the samples using the triple rinse method with Milli-Q water in 3.
    8.	Collect a 3D EEMs sample (take care to dilute if necessary as described in sample set-up). Click the H2O box and select 3D. Then select 3D CCD+Absorbance in the popup window and click next. Use the parameters             above as described in Step 7, except for the following two changes: 
 
          •	Identifier: SampleName 
              (must start with letter, no special symbols, 8 char max) 
          •	Blank from File: Click the three dots following “Blank from file” and choose the blank file from Step 7. 
        Click “Run” to run this sample and then once finished, remove the cuvette and prepare it appropriately for the samples using the triple rinse method with Milli-Q water.
 
IV.	Fluorescence 3D-EEM Export on Horiba Aqualog
    1.	Open the sample in the project that you wish to export.
    2.	If not already showing, select the Sample-Blank Waterfall Plot tab from the bottom to activate the Waterfall plot. Then select the inner filter effect icon (square box divided diagonally black/white) on the               toolbar. Check both boxes and leave the width at the default (10 nm). Repeat this process for all the samples. 
    3.	To export data, make sure the sample you wish to export has the Processed Data: IFE tab from the bottom selected and showing. This tab will show numerical values, not a plot. Next, click on the "File" menu and             select "Export" to open the export dialog box, and then select "ASCII" as the file type because this file type is the format required for the PARAFAC model. Then, navigate to the desired folder, give the file a           descriptive name that includes a unique sample name, and select ".dat" as the file extension before clicking "Save" to export the file. 
    4.	Record the filename and the Raman area for each sample in your laboratory notebook. This information will also be needed to input the files into the PARAFAC model, so consider recording this in a spreadsheet or           document.
    5.	Repeat these steps for each sample, giving each file a unique name and noting the corresponding Raman area. Once you have exported all the samples, load them onto your workstation with RStudio ensuring that the           files are all in one single folder. 

V.	Obtaining components from PARAFAC model
    1.	To use the stemflow-DOM PARAFAC model, start by downloading the PARAFAC folder (https://github.com/robynohalloran/StemflowDOM.git) which includes the raw data, R script, and metadata format, and save it to your           desktop. 
    2.	Update the metadata file with your sample names, dilution, and Raman area, and add your .dat files to the "data" folder. Do not replace the existing samples or names, simply add the ones for your data. 
    3.	Open the R script and modify lines 25 and 26 to match the location of the PARAFAC folder on your computer. 
    4.	If you haven't used the "stardom" and "dplyr" packages before, install them by typing install.packages("stardom") and install.packages("dplyr"). 
    5.	Crucially, alter line 50 to list all of your sample names under “exclude” for correct model execution. This step will allow the PARAFAC model to regenerate the same exact model in this paper without the influence           of your samples. You can subsequently fit your samples to this model to obtain the desired component loadings. 
    6.	Run the entire R code to analyze your data, which will be exported as a .txt file by the "eem_parafac_export" function. Convert this file to a .xlsx file, and you're ready for the next step of your analysis.
    Some important notes to keep in mind: ensure the file paths in the R code match your computer's organization, installation of new packages takes a few minutes, and double-check your metadata and sample exclusions         for accuracy. The exported .txt file can be viewed in any text editor or spreadsheet program.
VI.	Utilizing the multivariate model equations
    1.	Once the component data is exported from R, open the Excel file and find your sample's row. 
    2.	In the last column, sum the component loadings to get the total loadings. 
    3.	In subsequent columns, divide each individual loading by the total to get the relative loading per sample. 
    4.	Use the relative loadings as the input values for the models discussed in this paper.
