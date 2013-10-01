create table iug_ionospheric_cond (
       sigma_0 real not null,
       sigma_1 real not null,
       sigma_2 real not null,
       sigma_xx real not null,
       sigma_yy real not null,
       sigma_xy real not null,
       height real not null,
       glat real not null,
       glon real not null,
       yyyy int not null,
       mmdd int not null,
       ltut int not null,
       atime int not null,
       algorithm int not null,
       primary key(height, glat, glon, yyyy, mmdd, ltut, atime, algorithm)
);