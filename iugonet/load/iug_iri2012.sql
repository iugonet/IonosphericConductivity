create table iug_iri2012 (
       jmag int not null, -- 0:geog, 1:geom
       lat real not null, -- latitude
       lon real not null, -- longitude
       yyyy int not null, -- year 
       mm int not null, -- month
       dd int not null, -- day
       ltut int not null, -- 0:LT, 1:UT
       atime int not null, -- hour
       height real not null, -- km
       ne  int not null, -- Ne/cm-3
       ner real not null, -- Ne/NmF2
       tn int not null, -- Tn/K
       ti int not null, -- Ti/K
       te int not null, -- Te/K
       io int not null, -- O+
       ih int not null, -- H+
       ihe int not null, -- N+
       io2 int not null, -- He+
       ino int not null, -- H+
       icl int not null, -- O2+
       tec real not null,  -- TEC
       t int not null, -- t/%
       NmF2 real not null, -- Peak Densities/cm-3: NmF2 
       NmF1 real not null, -- NmF1
       NmE real not null, -- NmE
       hmF2 real not null, -- Peak heights/km: hmF2,
       hmF1 real not null, -- hmF1
       hmE real not null, -- hmE
       sza real not null, -- Solar Zenith Angle/degree
       dip real not null, -- Dip (Magnetic inclination)/degree
       modip real not null, -- Modip (Modified Dip)/degree
       rz12 real not null, -- Solar Sunsplot Number (12-months running mean) Rz12
       ig12 real not null, -- Ionospheric-Effective Solar Index IG12
       primary key(jmag,lat,lon,yyyy,mm,dd,ltut,atime,height)
);