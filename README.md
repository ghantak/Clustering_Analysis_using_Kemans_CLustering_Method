Step by Step procedure to analyze the clustering method from metadynamics trajectory

Step 1: First extract the frame numbers, CV1, and CV2 from metadynamics.hills.traj traj output files of NAMD.
./Extract_Frame_CV1_CV2_From_Colvar_Traj_File.sh

This will provide an output of the form 

           1   1.04382157      0.274770528            1000
           2   1.03086960      0.345884204           25000
           3   1.01820266      0.388222963           50000
           4   1.01712644      0.678611040           75000
           5   1.01240420      0.564967692          100000
           6   1.01390851      0.676540256          125000
           7   1.00837898      0.496194065          150000
           8   1.00669944      0.353408128          175000
           9   1.01317286      0.455951363          200000
          10   1.00697887      0.286935151          225000
          11  0.991827667      0.292948306          250000
          12  0.974975884      0.281399876          275000
          13  0.965437949      0.319120437          300000
          14  0.942141414      0.263666630          325000

          ...


Step 2: Run the kmeans python code 
python tm_clustering_by_kmeans.py

Note: Use the frame number of your MetaD trajectory with similar saving frequency as above. 
You can extract the .dcd file from NAMD trajectory using the .tcl script as given. 

vmd -dispdev text -e file.tcl

Step 3: use the analyze_kmeans_output_tm.sh script to extract the % of cluster with 
frame number for the different populated regions. 

./analyze_kmeans_output_tm.sh



