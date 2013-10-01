create table iug_iri2012 {
       glat real not null, 
       glon real not null,
       yyyy int not null, -- year 
       mm int not null, -- month
       dd int not null, -- day
       ltut int not null, -- 0:LT, 1:UT
       atime int not null, -- hour
       height real not null, -- km
       ne  int not null, -- Ne/cm-3
       ner real not null, -- Ne/NmF2
       tn int not null, -- Tn/K
       te int not null, -- Ti/K
       io int not null, -- Te/K
       ih int not null, -- O+
       ihe int not null, -- N+
       ino int not null, -- H+
       io2 int not null, -- He+
       icl int not null, -- O2+
       tec int not null, -- NO+
       topp int not null, -- Clust
       tec int not null,  -- TEC
       hoge int not null, -- t/%
       hoge2 int not null, -- Peak Densities/cm-3: NmF2 
       hoge3 int not null, -- NmF1
       noge4 int not null, -- NmE
       hoge5 int not null, -- Peak heights/km: hmF2,
       hoge6 int not null, -- hmF1
       hoge7 int not null, -- hmE
       hoge8 int not null, -- Solar Zenith Angle/degree
       hoge9 int not null, -- Dip (Magnetic inclination)/degree
       hoge10 int not null, -- Modip (Modified Dip)/degree
       hoge11 int not null, -- Solar Sunsplot Number (12-months running mean) Rz12
       hoge12 int not null, -- Ionospheric-Effective Solar Index IG12
       hoge13 int not null, -- TEC
}