## 3.5 Are my computation results reasonable?

(1) You should make sure that your CASSCF initial orbitals and final(i.e. converged) orbitals contain proper active orbitals. Here are two examples:

(i) Assuming you are studying the bond breaking of a C-C bond, you use CAS(2,2) at least. And you should make sure that your CASSCF initial orbitals and final orbitals contain the bonding and anti-bonding orbitals this C-C bond. Note that the RHF orbitals or MP2 natural orbitals are usually poor to be used as the initial guess when studying bond breaking or transition-metal-containing molecules.  
(ii) Assuming you are studying the \\( \pi \\) -> \\( \pi \\)* excited energies, then your active space is expected to contain desired \\( \pi \\) and \\( \pi \\)* orbitals.

(2) If you perform the CASSCF (or CASSCF-based methods like NEVPT2, CASPT2, etc), there would be a file with suffix `*CASSCF_NO.fch` generated, in which the CASSCF natural orbitals and corresponding occupation numbers are held. You can use GaussView or Multiwfn to open this file and visualize whether these active orbitals are reasonable, if you know your molecule fairly well.

If you perform CASCI (or CASCI-based jobs), the CASCI NOs are held in a `*CASCI_NO.fch` file. If you only perform GVB computation, the GVB NOs are held in the `*gvb2_s.fch` file.

(3) If you are comparing relative energies of two target molecules (e.g. two local minima of the same molecule), be sure that you are using the same size of active space for two molecules. For example, it is incorrect(or unfair) to compare two NEVPT2 energies if one is based on CAS(4,4) and the other one is based on CAS(8,8). If, unfortunately, you encounter such special case, you have two options:

(i) explicitly specify the active space in the former calculation, i.e. NEVPT2(8,8) in the input file.  
(ii) if you find there are 4 orbitals not so active in the latter calculation (meaning occupation numbers close to 0 or 2), you can specify NEVPT2(4,4) in the input file.

(4) If you are calculating the bond dissociation energy, you should check whether the sum or combination of active space from two fragments equals to the active space of the original molecule. You are supposed to analyze main components of the active space. For example, assuming the original molecule has a CAS(6,6) active space, and assuming it contains 2 singly occupied orbitals from fragment 1, two bonding orbitals and two anti-bonding orbitals constructed by two fragments. Then quintuplet CAS(4,4) should be used for fragment 1 and triplet CAS(2,2) for fragment 2.

(5) For the rigid/unrelaxed scanning of a chemical bond, you are always recommended to scan the bond from long distance to short distance, rather than from short to long. And you are recommended to write the keyword `scan` in the Gaussian keyword `#p` line. This will perform the rigid/unrelaxed scan automatically. It is not recommended to calculate each scanned geometry manually. Note: the `scan` functionality in MOKIT has not been implemented yet.

