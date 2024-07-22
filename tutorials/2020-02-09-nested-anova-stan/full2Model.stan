
data{
   int n;
   int nB;
   vector [n] y;
   int A2[n];
   int A3[n];
   int B[n];
}

parameters{
  real alpha0;
  real alpha2;
  real alpha3;
  real<lower=0> sigma;
  vector [nB] beta;
  real<lower=0> sigma_B;
}
 
model{
    real mu[n];

    // Priors
    alpha0 ~ normal( 0 , 100 );
    alpha2 ~ normal( 0 , 100 );
    alpha3 ~ normal( 0 , 100 );
    beta ~ normal( 0 , sigma_B );
    sigma_B ~ cauchy( 0 , 25 );
    sigma ~ cauchy( 0 , 25 );
    
    for ( i in 1:n ) {
        mu[i] = alpha0 + alpha2*A2[i] + 
               alpha3*A3[i] + beta[B[i]];
    }
    y ~ normal( mu , sigma );
}


