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
                         -- TEC
                         -- t/%
-- Peak Densities/cm-3: NmF2 
-- NmF1
-- NmE
-- Peak heights/km: hmF2,
-- hmF1
-- hmE

       -- Solar Zenith Angle/degree
       -- Dip (Magnetic inclination)/degree
       -- Modip (Modified Dip)/degree
       -- Solar Sunsplot Number (12-months running mean) Rz12
       -- Ionospheric-Effective Solar Index IG12
       -- TEC
}