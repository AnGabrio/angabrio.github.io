
data{
   int n;
   int nX;
   int nB;
   vector [n] y;
   matrix [n,nX] X;
   int B[n];
}

parameters{
  vector [nX] beta;
  real<lower=0> sigma;
  vector [nB] gamma;
  real<lower=0> sigma_B;
}
transformed parameters {
  vector[n] mu;    
  
  mu = X*beta;
  for (i in 1:n) {
    mu[i] = mu[i] + gamma[B[i]];
  }
} 
model{
    // Priors
    beta ~ normal( 0 , 100 );
    gamma ~ normal( 0 , sigma_B );
    sigma_B ~ cauchy( 0 , 25 );
    sigma ~ cauchy( 0 , 25 );
    
    y ~ normal( mu , sigma );
}


