# Terrestrial Laser Scanning (TLS) Location Planning on Construction Projects
New Quadratic Formulation to Guarantee Registrability in Laser Scanner Location Planning on Construction Projects

Terrestrial Laser Scanning (TLS) provides 3-dimensional (3D) represetation of the surrounding surfaces, called point clouds. These point clouds enable the reliable digital documentation of the built environment, supporting various construction engineering and management processes, such as infrastructure monitoring, cultural heritage documentation, and digital twin generation. As the demand for TLS on construction projects increases, it becomes increasingly more desirable to determine the minimum number of stations that maximizes coverage (LOC), maximize density (LOD), maximize registrability (LOO) and enhance accuracy (LOA). The problem can, hence, be formulated as shown in the following image.

![Screenshot 2025-03-06 at 21 04 54](https://github.com/user-attachments/assets/d74c446b-d1bc-4b9c-91f7-73323c7c48b9)

# Problem Formulation and Contributions
Normally, the problem is defined as a solution to a linear programming function whereby the selected scan stations maximize coverage. This problem can be solved using existing linear solvers, such as the intlinprog function in Matlab. Once registrability of the network becomesof concern, the problem becomes non-linear. Here, the registrability of the network of selected scanners is formulated as a quadratic penalty term to incentivize solutions that contain pairwise planar surfaces whose angles are larger than a pre-defined threshold (say 30º). Furthermore, we propose a new closed formulation for the level of accuracy for palanr surfaces within the digital model. The LOA, LOD and LOC are included within the objective function as a linear term through a utility function. The specifics of the formulations can be found in the following image.

![Screenshot 2025-03-06 at 21 05 10](https://github.com/user-attachments/assets/ecc2b873-b50c-464f-b226-a9a8be457edb)

![Screenshot 2025-03-06 at 21 05 22](https://github.com/user-attachments/assets/7159ceef-8b0a-426f-9b93-b6df2c1abbe1)

# Implementaion and Dependencies
The code was implemented in Matlab and solved using the Gurobi integer programming (v. 12.0.0). As such, in order to utilize the code, the user must install the following in addition to an up-to-date Matlab software:

1- Matlab Optimization Toolbox to solve the integer linear programming (ILP) problem to maximize coverage;

2- Gurobi Solver for Matlab to solve the quadratic programming (QP) problem associated with the registrability guarantee between scanners.

# Results of the Study
It was observed that by incorporating the quadratic registrability term, it is possible to improve the registrability of the network; furthermore, when compared with manual planning, the automatic planning provided less number of scan stations, more surface coverage, and less number of points. The following image shos the results of one sample run for the two methods proposed in the study:

![Screenshot 2025-03-06 at 21 01 50](https://github.com/user-attachments/assets/503e2bc3-12a8-4c26-8e49-6bfde19851c3)

# Explanation on Code and Provided Files
As part of this Repository, three folders are provided:

1- Inputs, which includes the required input BIM data in .stl format.

2- Dependent Functions, which includes the new functions called in the main script.

3- Demonstration, which includes three main scripts to provide pre-processing, optimization and plotting.

To successfully run the code, all items must be accessible to Matlab at the time of execution.

# Citations
The study was published and presented at the Creative Construction Conference (CCC), held in Prague on July 2024, where the mathematical formulations are explained in more detail. You may cite the study using the following information:

Maalek, R. and Al-Salihi, M. 2024. "Terrestrial laser scanner location and path planning on construction projects”. Proceedings of the Creative Construction Conference (CCC), July 2024, Prague, Czech Republic. https://doi.org/10.3311/CCC2024-177.

Please also stay in contact with the co-author of this study @Mustafasalihi91!

# Acknowledgements
The author wishes to acknowledge the generous endowment provided by GOLDBECK GmbH to the Karlsruhe Institute of Technology (KIT) for the establishment of the Professorship in Digital Engineering and Construction at the Institute of Technology and Management in Construction (TMB).
