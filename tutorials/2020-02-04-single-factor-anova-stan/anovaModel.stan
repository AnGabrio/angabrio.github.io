
  data {
  int<lower=1> n;
  int<lower=1> nX;
  vector [n] y;
  matrix [n,nX] X;
  }
  parameters {
  vector[nX] beta;
  real<lower=0> sigma;
  }
  transformed parameters {
  vector[n] mu;

  mu = X*beta;
  }
  model {
  //Likelihood
  y~normal(mu,sigma);
  
  //Priors
  beta ~ normal(0,1000);
  sigma~cauchy(0,5);
  }
  generated quantities {
  vector[n] log_lik;
  
  for (i in 1:n) {
  log_lik[i] = normal_lpdf(y[i] | mu[i], sigma); 
  }
  }
  
  
