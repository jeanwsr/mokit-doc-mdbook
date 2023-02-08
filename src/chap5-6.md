# 5.6 Generating different GVB solutions
This section is for experienced GVB users. For conjugated molecules, there often
exists multiple GVB solutions.

## 5.6.1 \\( \sigma \\) - \\( \pi \\) separated *v.s.* \\( \sigma \\) - \\( \pi \\) mixed solution
By default, the PM (Pipek-Mezey) localization method is used in constructing the
initial guess of GVB orbitals. For example, if we calculate a benzene molecule,
```
%mem=48GB
%nprocshared=48
#p CASSCF/cc-pVDZ

mokit{}

0 1
C   -0.90252711    0.46329723    0.00000000
C    0.49263289    0.46329723    0.00000000
C    1.19017089    1.67104823    0.00000000
C    0.49251689    2.87955723   -0.00119900
C   -0.90230811    2.87947923   -0.00167800
C   -1.59990911    1.67127323   -0.00068200
H   -1.45228611   -0.48901977    0.00045000
H    1.04214089   -0.48921577    0.00131500
H    2.28985089    1.67112823    0.00063400
H    1.04271689    3.83170023   -0.00125800
H   -1.45243011    3.83176023   -0.00263100
H   -2.69951311    1.67145623   -0.00086200

```
we will obtain GVB(15) and CASSCF(6,6) natural orbitals, in which we can find 3
\\( \pi \\) bonding orbitals and 3 \\( \pi \\)* anti-bonding orbitals:

But if we deliberately change the orbital localization method as the Boys method:
```
mokit{LocalM=Boys}
```
then the \\( \sigma \\) - \\( \pi \\) orbitals are mixed during orbital localization,
and the GVB will converge to a lower-energy solution, but with \\( \sigma \\) - \\( \pi \\)
orbitals mixed. And we will probably get the complain information from `automr`
```
There is no active orbital/electron. AutoMR terminated.

The reason is this molecule has little multi-configurational or multi-reference
character...
```

This is because in the lower-energy GVB solution, there are no pure \\( \pi \\)
orbitals, and the corresponding pair coefficients are totally different
```
   CICOEF(  1)=  0.99795122275633, -0.06397934822390
   CICOEF(  3)=  0.99795102014144, -0.06398250853672
   CICOEF(  5)=  0.99794887464558, -0.06401596358426
   CICOEF(  7)=  0.99608018865066, -0.08845483467657
   CICOEF(  9)=  0.99607885713120, -0.08846982749052
   CICOEF( 11)=  0.99607599571862, -0.08850203812992
   CICOEF( 13)=  0.99602509688574, -0.08907303954478
   CICOEF( 15)=  0.99602503059542, -0.08907378080778
   CICOEF( 17)=  0.99602141489628, -0.08911420239227
   CICOEF( 19)=  0.99591536359976, -0.09029168591829
   CICOEF( 21)=  0.99591522848545, -0.09029317621383
   CICOEF( 23)=  0.99591456661139, -0.09030047625144
   CICOEF( 25)=  0.99591440686394, -0.09030223807220
   CICOEF( 27)=  0.99591436826541, -0.09030266376197
   CICOEF( 29)=  0.99591319014626, -0.09031565585597
```
It shows the symmetry of 3 C-C \\( \sigma \\) bonds, 6 C-H \\( \sigma \\) bonds,
and 6 \\( \sigma \\) - \\( \pi \\) mixing bonds ("banana" bonds). These pair coefficients
are of less multi-reference characteristics so that `automr` thinks there is no
strongly correlated orbitals to be picked for CASSCF calculations.

## 5.6.2 closed-shell-like *v.s.* diradical-like solution
To be added.

