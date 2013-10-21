create table coordinate_system(
       coordinate_system int unique not null check (coordinate_system between 1 and 2),
       name text not null,
       note text,
       primary key(coordinate_system)
);

insert into coordinate_system values(1,'geodetic','shape of Earth is approximated by a spheroid');
insert into coordinate_system values(2,'geocentric','shape of Earth is approximated by a sphere');


create table igrf11 (
       coordinate_system references coordinate_system(coordinate_system),
       yyyy int not null, -- year
       glat real not null, -- deg
       glon real not null, -- deg
       height real not null, -- km
       d_deg  real not null, -- deg
       d_min real not null, -- min
       i_deg  real not null, -- deg
       i_min real not null, -- min
       h real not null, -- nT
       x real not null, -- nT
       y real not null, -- nT
       z real not null, -- nT
       f real not null, -- nT
       d_sv real not null, -- min/yr
       i_sv real not null, -- min/yr
       h_sv real not null, -- nT/yr
       x_sv real not null, -- nT/yr
       y_sv real not null, -- nT/yr
       z_sv real not null, -- nT/yr
       f_sv real not null, -- nT/yr
       primary key(coordinate_system, yyyy, glat, glon, height)
);

create view igrf11_view as
       select coordinate_system,yyyy,glat,glon,height,d_deg+d_min/60,i_deg*i_min/60,h,x,y,z,f,d_sv,i_sv,h_sv,x_sv,y_sv,z_sv,f_sv from igrf11;
