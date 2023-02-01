# 4.6 APIs in MOKIT
Currently only Python APIs are provided. C/C++ APIs may be provided in the future. Some commonly used Python APIs are shown below

1. load_mol_from_fch(fchname)
2. loc(fchname, method, idx)
3. read_int1e_from_gau_log(logname, itype, nbf)
4. read_mo_from_fch(fchname, nbf, nif, ab)
5. read_density_from_gau_log(logname, itype, nbf)
6. read_density_from_fch(fchname, itype, nbf)
7. write_pyscf_dm_into_fch(fchname, nbf, dm, itype, force)
8. gen_ao_tdm(logname, nbf, nif, mo, istate)
9. export_mat_into_txt(txtname, n, mat, lower, label)
10. read_natom_from_pdb(pdbname, natom)
11. read_nframe_from_pdb(pdbname, nframe)
12. read_iframe_from_pdb(pdbname, iframe, natom, cell, elem, resname, coor)
13. write_frame_into_pdb(pdbname, iframe, natom, cell, elem, resname, coor, append)
14. calc_unpaired_from_fch(fchname, wfn_type, gen_dm)

Meanings of frequently appeared arguments are
fchname: filename of .fch(k) file
logname: filename of .log/.out file
nbf: the number of basis functions
nif: the number of (linear-independent) MOs

Meanings of other arguments are shown in below subsections.

## 4.6.1 load_mol_from_fch
Load a PySCF mol object from a Gaussian .fch(k) file. For example, run python in Shell
```
python
>>>from pyscf import scf
>>>from mokit.lib.gaussian import load_mol_from_fch
>>>mol = load_mol_from_fch(fchname='00-h2o_cc-pVDZ_0.96_rhf.fchk')
>>>mf = scf.RHF(mol).run()
```
where the module gaussian is actually the file $MOKIT_ROOT/lib/gaussian.py.

## 4.6.2 loc
Perform orbital localization for a given .fch(k) file. Two localization methods are supported: Foster-Boys or Pipek-Mezey. For example, run python in Shell
```
python
>>>from mokit.lib.gaussian import loc
>>>loc(fchname='benzene_5D7F_rhf.fchk', method='pm', idx=range(6,21))
```
Only 'boys' or 'pm' is allowed for the 2nd argument. You should specify the orbital indices or range in the 3rd argument. Note that the starting integer index is 0 in Python convention, and the final index cannot be reached. So range(6,21) means orbitals 7-21, which are valence occupied orbitals for benzene. The localized orbitals will be exported/written into a new file with suffix `*_LMO.fch` (in this case, it is benzene_5D7F_rhf_LMO.fch).

For system containing only \\( \sigma \\) bonds, these two methods make little difference.
While for system containing \\( \sigma \\) and \\( \pi \\) bonds, the Boys localization
method tends to mix \\( \sigma \\) and \\( \pi \\) bonds, which leads to 'banana' bonds.
The PM localization method tends to keep \\( \sigma \\) and \\( \pi \\) separated. If
you want to analyze localized \\( \pi \\) bonds after localization, you should choose method='pm'.

## 4.6.3 uno
Generate UHF natural orbitals(UNOs) from a given Gaussian .fch(k) file. For example,
```
python
>>>from mokit.lib.gaussian import uno
>>>uno(fchname='benzene_uhf.fch')
```
## 4.6.4 permute_orb
Swap/exchange two orbitals in a given .fch(k) file. For example,
```
python
>>>from mokit.lib.gaussian import permute_orb
>>>permute_orb('ethanol_rhf_proj_loc_pair2gvb8_s.fch',6,13)
```
then the MO 6 and MO 13 will be swapped/exchanged. The index of the first orbital starts from 1.

## 4.6.5 gen_fcidump
Generate a FCIDUMP file which contains the effective 1e integrals and 2e integrals from a given Gaussian .fch(k) file. Such a FICUDMP file can be used in CASCI, DMRG-CASCI, GVB-BCCC, or any post-CASCI calculations. For example,
```
python
>>>from mokit.lib.gaussian import gen_fcidump
>>>gen_fcidump(fchname='anthracene_cc-pVDZ_uhf_uno_asrot2gvb7_s.fch',nacto=14,nacte=14)
```
where the arguments nacto and nacte are the number of active orbitals and the number of active electrons, respectively. This functionality requires the PySCF installed.

## 4.6.6 read_int1e_from_gau_log
Read various one-electron integral matrices from a Gaussian output file. For example, read AO-basis overlap
```
python
>>>from mokit.lib import rwwfn
>>>S = rwwfn.read_int1e_from_gau_log(logname='00-h2o_cc-pVDZ_1.5.log',itype=1,nbf=24)
```
Attribute itype:
The type of one-electron integral matrices. Allowed values are 1,2,3,4 for Overlap, Kinetic Energy, Potential Energy, and Core Hamiltonian, respectively.

## 4.6.7 read_mo_from_fch
Read MOs from a Gaussian .fch(k) file. For example
```
python
>>>from mokit.lib import rwwfn
>>>mo = rwwfn.read_mo_from_fch(fchname='00-h2o_cc-pVDZ_1.5.fchk',nbf=24,nif=24,ab='a')
```
Attribute ab:
character with length=1, 'a'/'b' for reading alpha/beta orbitals.

## 4.6.8 read_density_from_gau_log
Read various types of density matrix from a Gaussian output file. For example, read the Alpha Density Matrix from a .log file
```
python
>>>from mokit.lib import rwwfn
>>>den = rwwfn.read_density_from_gau_log(logname='00-h2o_cc-pVDZ_1.5.log',
itype=2,nbf=24)
```
Attribute itype:
1/2/3 for Total/Alpha/Beta Density Matrix.

## 4.6.9 read_density_from_fch
Read various types of density matrix from a Gaussian .fch(k) file. For example, read the Total SCF Density from a .fchk file
```
python
>>>from mokit.lib import rwwfn
>>>den = rwwfn.read_density_from_fch(fchname='00-h2o_cc-pVDZ_1.5.fchk',
itype=1,nbf=24)
```
Attribute itype:
itype	type of density	itype	type of density
1	Total SCF Density	6	Spin MP2 Density
2	Spin SCF Density	7	Total CC Density
3	Total CI Density	8	Spin CC Density
4	Spin CI Density	9	Total CI Rho(1)
5	Total MP2 Density	10	Spin CI Rho(1)

## 4.6.10 write_pyscf_dm_into_fch
Write a PySCF density matrix into a given Gaussian .fch(k) file. This module does two things: (1) deal with the order of basis functions and their normalization factors, (2) then export density matrix into a given .fch(k) file. All attributes of this module are shown below
`write_pyscf_dm_into_fch(fchname, nbf, dm, itype, force)`
where dm is the PySCF density matrix with dimension (nbf,nbf). itype has the same meaning with that in Section 4.6.5. force is a bool variable, and its meaning is:
(1) If the string corresponding to itype (e.g. 'Total SCF Density') can be found/located in the given .fch file, this parameter will not be used, i.e. setting True/False does not matter.
(2) If the string corresponding to itype cannot be found, setting force=True will enforce writing density matrix into the given file; setting force=False will stop/abort the program and signal errors immediately (this can be used to check whether desired strings exists in the specified file).

You should use this module via
```
python
>>>from py2fch import write_pyscf_dm_into_fch
```
Note that this module cannot generate a .fch(k) file from scratch, the user must provide one such file. The recommended approach is firstly using the module bas_fch2py to generate PySCF input file or using load_mol_from_fch to generate proper PySCF object, then do computations in PySCF. Finally using the module write_pyscf_dm_into_fch to export desired density matrix.

## 4.6.11 gen_ao_tdm
Generate AO-basis ground->excited state Transition Density Matrix for CIS/TDHF/TDDFT from a Gaussian output file. Currently only closed shell is taken into consideration. For example, read the S0->S1 Transition Density Matrix from a Gaussian .log file (with iop(9/40=5) specified in .gjf file)
```
python
>>>from mokit.lib import rwwfn, excited
>>>mo = rwwfn.read_mo_from_fch(fchname='00-h2o_cc-pVDZ_0.96_rhf.fchk',nbf=24,
nif=24,ab='a')
>>>tdm = excited.gen_ao_tdm(logname='00-h2o_cc-pVDZ_0.96_rhf.log',nbf=24,nif=24,
mo=mo,istate=1)
>>>rwwfn.export_mat_into_txt(txtname='h2o_tdm.txt',n=24,mat=tdm,lower=False,label='transition density matrix')
```
Attribute istate:
The i-th excited state. For example, i=1 for the first excited state.

The last python statement means exporting the transition density matrix into a plain text file, see the API below.

## 4.6.12 export_mat_into_txt
Export a square matrix into a plain text file. The example of exporting transition density matrix is shown in Section 4.6.6. Here I offer one more example – export the lower triangle of a symmetric AO-basis overlap matrix
```
python
>>>from mokit.lib import rwwfn
>>>S = rwwfn.read_int1e_from_gau_log(logname='00-h2o_cc-pVDZ_1.5.log',itype=1,nbf=24)
>>>rwwfn.export_mat_into_txt(txtname='ovlp.txt',n=24,mat=S,lower=True,label='Overlap')
```
Attribute	Explanation
txtname	file name
mat	the square matrix with dimension (n,n)
lower	True/False for whether or not printing only the lower triangle part of a matrix
label	a string, the meaning of exported matrix (provided by yourself)


## 4.6.13 read_natom_from_pdb
Read the number of atoms from a given pdb file. If there exists more than one frame in the pdb file, only the 1st frame will be detected. See an example in Section 4.6.13.

## 4.6.14 read_nframe_from_pdb
Read the number of frames from a given pdb file. See an example in Section 4.6.13.

## 4.6.15 read_iframe_from_pdb
Read the i-th frame from a given pdb file. See an example in Section 4.6.13.

## 4.6.16 write_frame_into_pdb
Write a frame into the given pdb file. A python script is shown below, to illustrate how to use these pdb-related APIs:
```
import mokit.lib.rwgeom as rg
natom = rg.read_natom_from_pdb(pdbname='test.pdb')
cell, elem, resname, coor = rg.read_iframe_from_pdb('test.pdb', 10, natom)
for i in range(0,natom):
  s1 = elem[i][0].decode('utf-8')
  s2 = elem[i][1].decode('utf-8')
  print(s1, s2)
rg.write_frame_into_pdb('a.pdb', 10, natom, cell, elem, resname, coor, False)
```

## 4.6.17 calc_unpaired_from_fch
Calculate the Yamaguchi’s unpaired electrons and Head-Gordon’s unpaired electrons using the provided .fch(k) file. Biradical and tetraradical indices are printed as well. This .fch file must include natural orbitals and their corresponding occupation numbers. For example, a UNO, GVB or CASSCF NO .fch file is expected. DO NOT use a UHF .fch file. A python script is shown below:
```
from mokit.lib.wfn_analysis import calc_unpaired_from_fch
calc_unpaired_from_fch(fchname='00-h2o_cc-pVDZ_1.5_uhf_uno_asrot2gvb4_s.fch', wfn_type=2, gen_dm=False)
```
The attribute wfn_type has values 1/2/3 for UNO/GVB/CASSCF NOs, respectively. The example above will print the following

If the attribute gen_dm is set to True (i.e. gen_dm=True), then a file like `*_unpaired.fch` will also be generated, in which the unpaired electron density is stored. The unpaired density can be visualized by GaussView or Multiwfn+VMD.

Yamaguchi's biradical index for UHF:
 
Yamaguchi's biradical index for CAS(2,2):
 
where   is the CI coefficients of the 2nd configurations in CASCI wave function (assuming natural orbitals are used). Note that there is no unique way to define biradical (or tetraradical, etc) index for general cases including CASSCF(m,m) where m>=4, or GVB(n) where n>=2. The   formula is adopted in the module calc_unpaired_from_fch for these general cases.

There are also modules which calculate the number of unpaired electrons of GVB by reading information from GAMESS .dat/.gms file:
```
from mokit.lib.wfn_analysis import calc_unpaired_from_gms_dat
calc_unpaired_from_gms_dat(datname='00-h2o_cc-pVDZ_1.5_uhf_uno_asrot2gvb4_s.fch',mult=1)
```
It requires the user to input the spin multiplicity since there is no spin information in .dat file. Or you can use
```
from mokit.lib.wfn_analysis import calc_unpaired_from_gms_out
calc_unpaired_from_gms_out(outname='00-h2o_cc-pVDZ_1.5_uhf_uno_asrot2gvb4.gms')
```
Reference for these two types of unpaired eletrons:
[1] Theoret. Chim. Acta (Berl.) 48, 175-183 (1978). DOI: 10.1007/BF00549017.
[2] Chemical Physics Letters 372 (2003) 508–511. DOI: 10.1016/S0009-2614(03)00422-6.

## 4.6.18 gen_no_using_density_in_fch
Generate natural orbitals using specified density in a .fch file. The density is read from the specified section of .fch file and the AO-basis overlap is obtained by calling Gaussian. An example is shown below
```
from mokit.lib.lo import gen_no_using_density_in_fch
gen_no_using_density_in_fch('ben.fch', 1)
```
where 1 means reading density from "Total SCF Density" section.

## 4.6.19 gen_cf_orb
Generate Coulson-Fischer orbitals using GVB natural orbitals from a GAMESS .dat file. The Coulson-Fischer orbitals are non-orthogonal and the GVB natural orbitals are orthogonal, so this module actually performs an orthogonalnon-orthogonal orbital transformation. This transformation requires the information of GVB pair coefficients so currently only the GAMESS .dat file is accepted while the .fch file is not supported. An example is shown below
```
from mokit.lib.lo import gen_cf_orb
gen_cf_orb(datname='naphthalene_gvb5.dat',ndb=29,nopen=0)
```

where ndb is the number of doubly occupied orbitals and nopen is the number of singly occupied orbitals. A new file named naphthalene_gvb5_new.dat will be generated. If you want to visualize the Coulson-Fischer orbitals, you need to use the dat2fch utility to transfer orbitals from .dat to .fch.

## 4.6.20 py2qchem
Export MOs from PySCF to Q-Chem. An input (.in) file and a directory containing orbital files will be generated. The restricted/unrestricted-type (i.e. RHF, ROHF or UHF) can be automatically detected. Two examples are shown below:

(1) Transfer RHF, ROHF or UHF orbitals. Create/Write a PySCF input file, e.g. h2o.py
```
from pyscf import gto, scf
from mokit.lib.py2qchem import py2qchem

mol = gto.M(atom = '''
O  -0.49390246   0.93902438   0.0
H   0.46609754   0.93902438   0.0
H  -0.81435705   1.84396021   0.0
''', basis = 'cc-pVDZ')

mf = scf.RHF(mol).run()
py2qchem(mf, 'h2o.in')
```
Run it using python and then a Q-Chem input file h2o.in and a scratch directory h2o will be generated. The orbital file(s) is put in h2o/. If you run
```
qchem h2o.in h2o.out h2o
```
you will find RHF in Q-Chem converges in 2 cycles. If the environment variable QCSCRATCH is already defined in your node/computer, the scratch directory h2o will be automatically put into $QCSCRATCH/; otherwise h2o will be put in the current directory.

(2) Transfer GVB orbitals
If you have performed GVB calculations and stored GVB orbitals in the object mf, then you can write in python
```
py2qchem(mf, 'h2o.in', npair=2)
```
to generate the GVB-PP input file of Q-Chem, where npair tells py2qchem how many pairs you want to calculate.

## 4.6.21 Other modules in rwwfn
modify_IROHF_in_fch(fchname, k)  
read_charge_and_mult_from_fch(fchname, charge, mult)  
read_charge_and_mult_from_mkl(mklname, charge, mult)  
read_na_and_nb_from_fch(fchname, na, nb)  
read_nbf_and_nif_from_fch(fchname, nbf, nif)  
read_nbf_and_nif_from_orb(orbname, nbf, nif)  
read_nbf_from_dat(datname, nbf)  
read_mo_from_chk_txt(txtname, nbf, nif, ab, mo)  
read_mo_from_orb(orbname, nbf, nif, ab, mo)  
read_mo_from_xml(xmlname, nbf, nif, ab, mo)  
read_mo_from_bdf_orb(orbname, nbf, nif, ab, mo)  
read_mo_from_dalton_mopun(orbname, nbf, nif, coeff)  
read_eigenvalues_from_fch(fchname, nif, ab, noon)  
read_on_from_orb(orbname, nif, ab, on)  
read_on_from_dat(datname, nmo, on, alive)  
read_on_from_xml(xmlname, nmo, ab, on)  
read_on_from_bdf_orb(orbname, nif, ab, on)  
read_ev_from_bdf_orb(orbname, nif, ab, ev)  
read_on_from_dalton_mopun(orbname, nif, on)  
read_ncontr_from_fch(fchname, ncontr)  
read_shltyp_and_shl2atm_from_fch(fchname, k, shltyp, shl2atm)  
read_ovlp_from_molcas_out(outname, nbf, S)  
write_eigenvalues_to_fch(fchname, nif, ab, on, replace)  
write_on_to_orb(orbname, nif, ab, on, replace)  
write_mo_into_fch(fchname, nbf, nif, ab, mo)  
write_mo_into_psi_mat(matfile, nbf, nif, mo)  
determine_sph_or_cart(fchname, cart)  
read_npair_from_uno_out(nbf, nif, ndb, npair, nopen, lin_dep)  
read_gvb_energy_from_gms(gmsname, e)  
read_cas_energy_from_output(cas_prog, outname, e, scf, spin, dmrg, ptchg_e, nuc_pt_e)  
read_cas_energy_from_gaulog(outname, e, scf)  
read_cas_energy_from_pyout(outname, e, scf, spin, dmrg)  
read_cas_energy_from_gmsgms(outname, e, scf, spin)  
read_cas_energy_from_molcas_out(outname, e, scf)  
read_cas_energy_from_orca_out(outname, e, scf)  
read_cas_energy_from_molpro_out(outname, e, scf)  
read_cas_energy_from_bdf_out(outname, e, scf)  
read_cas_energy_from_psi4_out(outname, e, scf)  
read_cas_energy_from_dalton_out(outname, e, scf)  
read_mrpt_energy_from_pyscf_out(outname, ref_e, corr_e)  
read_mrpt_energy_from_molcas_out(outname, itype, ref_e, corr_e)  
read_mrpt_energy_from_molpro_out(outname, itype, ref_e, corr_e)  
read_mrpt_energy_from_orca_out(outname, itype, ref_e, corr_e)  
read_mrpt_energy_from_gms_out(outname, ref_e, corr_e)  
read_mrpt_energy_from_bdf_out(outname, itype, ref_e, corr_e, dav_e)  
read_mrcisd_energy_from_output(CtrType, mrcisd_prog, outname, ptchg_e, nuc_pt_e, davidson_e, e)  
read_mcpdft_e_from_output(prog, outname, ref_e, corr_e)  
find_npair0_from_dat(datname, npair, npair0)  
find_npair0_from_fch(fchname, nopen, npair0)  
read_no_info_from_fch(fchname, nbf, nif, ndb, nopen, nacta, nactb, nacto, nacte)  
check_cart(fchname, cart)  
check_sph(fchname, sph)  
write_density_into_fch(fchname, nbf, total, dm)  
detect_spin_scf_density_in_fch(fchname, alive)  
add_density_str_into_fch(fchname, itype)  
update_density_using_mo_in_fch(fchname)  
update_density_using_no_and_on(fchname)  
check_if_uhf_equal_rhf(fchname, eq)  
copy_orb_and_den_in_fch(fchname1, fchname2, deleted)  
read_ao_ovlp_from_47(file47, nbf, S)  
get_no_from_density_and_ao_ovlp(nbf, nif, P, ao_ovlp, noon, new_coeff)  
read_mult_from_fch(fchname, mult)  
get_1e_exp_and_sort_pair(mo_fch, no_fch, npair)

## 4.6.22 Other modules in `$MOKIT_ROOT/mokit/lib`
py2bdf(mf, inpname, write_no=None)  
py2dalton(mf, inpname)  
py2gms(mf, inpname, npair=None, nopen=None)  
py2molcas(mf, inpname)  
py2molpro(mf, inpname)  
py2orca(mf, inpname)  
py2psi(mf, inpname)

