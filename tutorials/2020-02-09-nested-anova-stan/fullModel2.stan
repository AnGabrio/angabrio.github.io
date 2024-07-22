
data{
   int n;
   int nSite;
   int nQuad;
   vector [n] y;
   int A2[n];
   int A3[n];
   int Site[n];
   int Quad[n];
}

parameters{
  real alpha0;
  real alpha2;
  real alpha3;
  real<lower=0> sigma;
  vector [nSite] beta_Site;
  real<lower=0> sigma_Site;
  vector [nQuad] beta_Quad;
  real<lower=0> sigma_Quad;
}
 
model{
    real mu[n];

    // Priors
    alpha0 ~ normal( 0 , 100 );
    alpha2 ~ normal( 0 , 100 );
    alpha3 ~ normal( 0 , 100 );
    beta_Site~ normal( 0 , sigma_Site );
    sigma_Site ~ cauchy( 0 , 25 );
    beta_Quad~ normal( 0 , sigma_Quad );
    sigma_Quad ~ cauchy( 0 , 25 );
    sigma ~ cauchy( 0 , 25 );
    
    for ( i in 1:n ) {
        mu[i] = alpha0 + alpha2*A2[i] + 
               alpha3*A3[i] + beta_Site[Site[i]] + beta_Quad[Quad[i]];
    }
    y ~ normal( mu , sigma );
}


