set PUB;

param budget >= 0;
param personne_semaine >= 0;
param cout_personne {PUB} >= 0;
param achat_min {PUB} >= 0;
param cout_unite {PUB} >= 0;
param audimat {PUB} >= 0;


var unite_achetee {p in PUB} >= achat_min [p];

maximize audimat_total :
	sum {p in PUB} unite_achetee [p] * audimat [p];

subject to budget_limite :
	sum {p in PUB}(unite_achetee [p] * cout_unite [p]) <= budget;

subject to personnel_limite :
	sum {p in PUB}(unite_achetee [p] * cout_personne [p]) <= personne_semaine;


data;
set PUB := TV Mag Radio;
param personne_semaine := 100;
param budget := 1000000;
param: cout_unite audimat cout_personne achat_min :=
TV        20000      1800000	    1		    10
Mag       10000      1000000	    3                0
Radio	  2000	      250000	    0.14285714285    120;
