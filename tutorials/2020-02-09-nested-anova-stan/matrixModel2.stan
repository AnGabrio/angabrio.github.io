
data{
   int n;
   int nSite;
   int nQuad;
   int nA;
   vector [n] y;
   matrix [n,nA] X;
   int Site[n];
   int Quad[n];
   vector [nA] a0;
   matrix [nA,nA] A0;
}

parameters{
  vector [nA] alpha;
  real<lower=0> sigma;
  vector [nSite] beta_Site;
  real<lower=0> sigma_Site;
  vector [nQuad] beta_Quad;
  real<lower=0> sigma_Quad;
}
 
model{
    real mu[n];

    // Priors
    //alpha ~ normal( 0 , 100 );
    alpha ~ multi_normal(a0,A0);
    beta_Site ~ normal( 0 , sigma_Site );
    sigma_Site ~ cauchy( 0 , 25);
	beta_Quad ~ normal( 0 , sigma_Quad );
    sigma_Quad ~ cauchy( 0 , 25);
    sigma ~ cauchy( 0 , 25 );
    
    for ( i in 1:n ) {
        mu[i] = dot_product(X[i],alpha) + beta_Site[Site[i]] + beta_Quad[Quad[i]];
    }
    y ~ normal( mu , sigma );
}


