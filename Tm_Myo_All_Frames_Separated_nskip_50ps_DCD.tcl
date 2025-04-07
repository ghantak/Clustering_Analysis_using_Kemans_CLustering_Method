# Load your topology file (PSF or PDB)
mol new complex_wt.psf
 
# Load your dcd file 
mol addfile Complex_MetaD1.dcd waitfor all step 5
mol addfile Complex_MetaD2.dcd waitfor all step 5
mol addfile Complex_MetaD3.dcd waitfor all step 5
mol addfile Complex_MetaD4.dcd waitfor all step 5
mol addfile Complex_MetaD5.dcd waitfor all step 5
mol addfile Complex_MetaD6.dcd waitfor all step 5
mol addfile Complex_MetaD7.dcd waitfor all step 5
mol addfile Complex_MetaD8.dcd waitfor all step 5
mol addfile Complex_MetaD9.dcd waitfor all step 5
mol addfile Complex_MetaD10.dcd waitfor all step 5
mol addfile Complex_MetaD11.dcd waitfor all step 5
mol addfile Complex_MetaD12.dcd waitfor all step 5
mol addfile Complex_MetaD13.dcd waitfor all step 5
mol addfile Complex_MetaD14.dcd waitfor all step 5
mol addfile Complex_MetaD15.dcd waitfor all step 5
mol addfile Complex_MetaD16.dcd waitfor all step 5
mol addfile Complex_MetaD17.dcd waitfor all step 5
mol addfile Complex_MetaD17m.dcd waitfor all step 5
mol addfile Complex_MetaD18.dcd waitfor all step 5
mol addfile Complex_MetaD19.dcd waitfor all step 5
mol addfile Complex_MetaD20.dcd waitfor all step 5
mol addfile Complex_MetaD21.dcd waitfor all step 5
mol addfile Complex_MetaD22.dcd waitfor all step 5
mol addfile Complex_MetaD23.dcd waitfor all step 5
mol addfile Complex_MetaD24.dcd waitfor all step 5
mol addfile Complex_MetaD25.dcd waitfor all step 5
mol addfile Complex_MetaD26.dcd waitfor all step 5
mol addfile Complex_MetaD27.dcd waitfor all step 5
mol addfile Complex_MetaD28.dcd waitfor all step 5
mol addfile Complex_MetaD29.dcd waitfor all step 5
mol addfile Complex_MetaD30.dcd waitfor all step 5
mol addfile Complex_MetaD31.dcd waitfor all step 5
mol addfile Complex_MetaD32.dcd waitfor all step 5
mol addfile Complex_MetaD33.dcd waitfor all step 5
mol addfile Complex_MetaD34.dcd waitfor all step 5

# Select the residues you want to visualize 
set tm [atomselect top "segname TMCA TMCB TMCC TMCD TMNI TMNJ TMNK TMNL"]
set myo [atomselect top "segname MYH7"]

animate write dcd Tm_nskip_50ps.dcd sel $tm
animate write dcd Myo_nskip_50ps.dcd sel $myo

$tm writepsf Tm.psf
$tm writepdb Tm.pdb
$myo writepsf Myo.psf
$myo writepdb Myo.pdb



quit
