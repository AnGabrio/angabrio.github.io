
data{
   int n;
   int nB;
   int nA;
   vector [n] y;
   matrix [n,nA] X;
   int B[n];
   vector [nA] a0;
   matrix [nA,nA] A0;
}

parameters{
  vector [nA] alpha;
  real<lower=0> sigma;
  vector [nB] beta;
  real<lower=0> sigma_B;
}
 
model{
    real mu[n];

    // Priors
    //alpha ~ normal( 0 , 100 );
    alpha ~ multi_normal(a0,A0);
    beta ~ normal( 0 , sigma_B );
    sigma_B ~ cauchy( 0 , 25);
    sigma ~ cauchy( 0 , 25 );
    
    for ( i in 1:n ) {
        mu[i] = dot_product(X[i],alpha) + beta[B[i]];
    }
    y ~ normal( mu , sigma );
}


