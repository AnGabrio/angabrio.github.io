
data{
   int n;
   int nA;
   int nB;
   vector [n] y;
   int A[n];
   int B[n];
}

parameters{
  real alpha[nA];
  real<lower=0> sigma;
  vector [nB] beta;
  real<lower=0> sigma_B;
}
 
model{
    real mu[n];

    // Priors
    alpha ~ normal( 0 , 100 );
    beta ~ normal( 0 , sigma_B );
    sigma_B ~ cauchy( 0 , 25 );
    sigma ~ cauchy( 0 , 25 );
    
    for ( i in 1:n ) {
        mu[i] = alpha[A[i]] + beta[B[i]];
    }
    y ~ normal( mu , sigma );
}


