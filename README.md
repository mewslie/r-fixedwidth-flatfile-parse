# r-fixedwidth-flatfile-parse
R code for reading a fixed-width flat file**, like Genbank flat file format excluding sequence data, and storing the features and values in a list of lists.

**created to parse reaction flat file from KEGG FTP (ligand/reaction.tar.gz)
```
ENTRY       R00001                      Reaction
NAME        polyphosphate polyphosphohydrolase
DEFINITION  Polyphosphate + n H2O <=> (n+1) Oligophosphate
EQUATION    C00404 + n C00001 <=> (n+1) C02174
ENZYME      3.6.1.10
DBLINKS     RHEA: 22455
///
ENTRY       R00002                      Reaction
NAME        Reduced ferredoxin:dinitrogen oxidoreductase (ATP-hydrolysing)
DEFINITION  16 ATP + 16 H2O + 8 Reduced ferredoxin <=> 8 e- + 16 Orthophosphate + 16 ADP + 8 Oxidized ferredoxin
EQUATION    16 C00002 + 16 C00001 + 8 C00138 <=> 8 C05359 + 16 C00009 + 16 C00008 + 8 C00139
COMMENT     a part of multi-step reaction (see R05185, R00002+R00067+R00153+R02802+R04782)
RCLASS      RC00002  C00002_C00008
ENZYME      1.18.6.1
///
```
R code should output a list of lists
```
[[1]]
[[1]]$ENTRY
[1] "R00001                      Reaction"

[[1]]$NAME
[1] "polyphosphate polyphosphohydrolase"

[[1]]$DEFINITION
[1] "Polyphosphate + n H2O <=> (n+1) Oligophosphate"

[[1]]$EQUATION
[1] "C00404 + n C00001 <=> (n+1) C02174"

[[1]]$ENZYME
[1] "3.6.1.10"

[[1]]$DBLINKS
[1] "RHEA: 22455"
```
***
Detected issues with KEGG reaction flatfile

Some reactions don't list orthology even if the enzyme has one.

Reaction file
```
ENTRY       R00011                      Reaction
NAME        Mn(II):hydrogen-peroxide oxidoreductase
DEFINITION  2 Manganese(2+) + Hydrogen peroxide + 2 H+ <=> 2 Manganese(3+) + 2 H2O
EQUATION    2 C19610 + C00027 + 2 C00080 <=> 2 C19611 + 2 C00001
ENZYME      1.11.1.13       1.11.1.16
DBLINKS     RHEA: 22779
```

Enzyme file
```
ENTRY       EC 1.11.1.13                Enzyme
NAME        manganese peroxidase;
            peroxidase-M2;
            Mn-dependent (NADH-oxidizing) peroxidase
CLASS       Oxidoreductases;
            Acting on a peroxide as acceptor;
            Peroxidases
SYSNAME     Mn(II):hydrogen-peroxide oxidoreductase
REACTION    2 Mn(II) + 2 H+ + H2O2 = 2 Mn(III) + 2 H2O [RN:R00011]
ALL_REAC    R00011
SUBSTRATE   Mn(II) [CPD:C19610];
            H+ [CPD:C00080];
            H2O2 [CPD:C00027]
PRODUCT     Mn(III) [CPD:C19611];
            H2O [CPD:C00001]
ORTHOLOGY   K20205  manganese peroxidase
```
