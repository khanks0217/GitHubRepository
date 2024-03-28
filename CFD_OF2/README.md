# CFD : Flow Over a 2D Cylinder

In this study, the objective is to simulate the flow around a two dimensional circular cylinder to gain insights into mesh generation and its impact on the accuracy of velocity fields and stress derivatives. Additionally, the dependence of flow and drag on the Reynolds number will be explored. Through this investigation, we aim to deepen our understanding of fluid dynamics and computational fluid dynamics (CFD) techniques while uncovering valuable insights into the behavior of flow around cylindrical objects at different Reynolds numbers.

## Table of Contents

- [File Contents](#FileConents)
- [Usage](#usage)
- [Features](#features)
- [Contributing](#contributing)
- [License](#license)

## FileContents

**Section2_PrelimSoln**
This section contains the OpenFOAM and MATLAB files for the preliminary solutions for the Reynold's number of 20 and 110. 
  - PrelimSoln_Viz - Contains images from ParaView vizualizing the streamlines, recirculation region, and contour plots for the x component of velocity (Ux), the y component of velocity (Uy) and the pressure for both Re=20 and Re=110.
  - Re110_MeshB - Contains the OpenFoam results from the preliminary solution for Re = 110 with a refined mesh. 
  - Re20_MeshA - Contains the OpenFoam results from the preliminary solution for Re = 20 with a coarser mesh. 
  - Re110_ProbeAnalysis.m - MATLAB File for the analysis of the unsteady flow (Re=110) at two proble locations (5.5, +-0.5).

**Section3_MeshRef**
This section contains the OpenFOAM files for exploring the affect of mesh refinement and changes in the domain on steady and unsteady flow.
  - MeshA_Refine - Contains the OpenFOAM files for the steady solution (Re=20) with increasingly finer meshes.
  - MeshB_Refine - Contains the OpenFOAM files for the steady solution (Re=110) with increasingly finer meshes.
    
**Section4_Strouhal**
This section contains the OpenFOAM and MATLAB files for exploring the Strouhal number and vortex shedding in unsteady flow.
  - MeshB_H1 - Contains the OpenFOAM files for the unsteady solution (Re=110) with increased height in the domain.
  - MeshB_H2 - Contains the OpenFOAM files for the unsteady solution (Re=110) with more increased height in the domain.
  - MeshB_L1 - Contains the OpenFOAM files for the unsteady solution (Re=110) with increased lenght of the wake in the domain.
  - MeshB_L2 - Contains the OpenFOAM files for the unsteady solution (Re=110) with more increased lenght of the wake in the domain.
  - Strouhal_Analysis.m - MATLAB File for the analysis of vortex shedding frequency for the calculation of the Strouhal number
    
**Section5_Drag**
This section contains the OpenFOAM and MATLAB files for calculating the drag coefficient where (Re=20).

## Usage

Instructions for using the project...

## Features

- Feature 1
- Feature 2
