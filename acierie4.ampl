set PROD;
param vitesse_production {PROD} >= 0;
param vente_min {PROD} >= 0;
param vente_max {PROD} >= 0;
param N integer >= 0;
set SEMS := 1 .. N;
param heures_ouvrees {SEMS} >= 0;
param prix_vente {SEMS, PROD} >= 0;
param stock_max >= 0;
var qte_produite {SEMS, PROD} >= 0;
var qte_vendue {s in SEMS, p in PROD} >= vente_min [p], <= vente_max [p];
var qte_stock {1 .. N+1, PROD} >= 0;
maximize profit :
	sum {s in SEMS, p in PROD} qte_vendue [s, p]*prix_vente [s, p];
subject to production_limitee {s in SEMS} :
	sum {p in PROD}(qte_produite [s, p] / vitesse_production [p]) <= heures_ouvrees [s];
subject to stock_initial {p in PROD} :
	qte_stock [1, p] = 0;
subject to stock_final {p in PROD} :
	qte_stock [N+1, p] = 0;
subject to equilibre {s in SEMS, p in PROD} :
	qte_stock [s, p] + qte_produite [s, p] = qte_stock [s+1, p] + qte_vendue [s, p];

data;
set PROD := bandes rouleaux poutres;
param: vitesse_production vente_max vente_min :=
bandes        200           6000       1000
rouleaux      140           4000        500
poutres       160           3500        750;

param heures_ouvrees :=
1       40
2       20
3       35;

param N := 3;
param stock_max := 1000;
param prix_vente:
bandes rouleaux poutres :=
1       25      30      29
2       27      30      28
3       29      30      20;


