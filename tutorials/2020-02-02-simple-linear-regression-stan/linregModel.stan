
  data {
  int<lower=0> n;
  vector [n] y;
  vector [n] x;
  }
  parameters {
  real beta0;
  real beta;
  real<lower=0> sigma;
  }
  model {
  vector [n] mu;
  #Priors
  beta0 ~ normal(0,10000);
  beta ~ normal(0,10000);
  sigma ~ cauchy(0,5);
 
  mu = beta0+beta*x;
  
  #Likelihood
  y~normal(mu,sigma);
  }
  
  
