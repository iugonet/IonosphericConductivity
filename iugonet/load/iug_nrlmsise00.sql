create table iug_nrlmsise00 {
       height not null, -- km
       iday int not null,       
       xlst not null, -- XLST (See header of nrlmsise00_sub.for)
       ut not null, -- UT(SEC)
       xlat not null, --
       xlong not null, --
       f107a not null, -- F107A
       f107 not null, -- F107
       ap not null, -- AP
       t1 not null, -- TINF
       t2 not null, -- TG
       d1 not null, -- HE
       d2 not null, -- O
       d3 not null, -- N2
       d4 not null, -- O2
       d5 not null, -- AR
       d6 not null, -- H
       d7 not null, -- N
       d8 not null, -- ANM O
       d9 not null, -- RHO
       primary key(height,iday,xlst,ut,xlat,xlong,f107a,f107,ap)
}