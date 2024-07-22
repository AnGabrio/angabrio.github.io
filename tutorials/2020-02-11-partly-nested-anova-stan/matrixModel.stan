
data{
   int n;
   int nZ;
   int nX;
   vector [n] y;
   matrix [n,nX] X;
   matrix [n,nZ] Z;
   vector [nX] a0;
   matrix [nX,nX] A0;
}

parameters{
  vector [nX] beta;
  real<lower=0> sigma;
  vector [nZ] gamma;
  real<lower=0> sigma_Z;
}
transformed parameters {
   vector [n] mu;

   mu = X*beta + Z*gamma; 
} 
model{
    // Priors
    beta ~ multi_normal(a0,A0);
    gamma ~ normal( 0 , sigma_Z );
    sigma_Z ~ cauchy(0,25);
    sigma ~ cauchy(0,25);

    y ~ normal( mu , sigma );
}
generated quantities {
    vector [n] y_err;
    real<lower=0> sd_Resid;

    y_err = y - mu;
    sd_Resid = sd(y_err);
}


