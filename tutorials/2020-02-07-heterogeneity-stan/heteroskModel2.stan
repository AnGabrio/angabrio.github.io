
  data {
  int<lower=1> n;
  int<lower=1> nX;
  vector [n] y;
  matrix [n,nX] X;
  }
  parameters {
  vector[nX] beta;
  vector<lower=0>[nX] sigma;
  }
  transformed parameters {
  vector[n] mu;
  vector<lower=0>[n] sig;

  mu = X*beta;
  sig = X*sigma;
  }
  model {
  // Likelihood
  y~normal(mu,sig);
  
  // Priors
  beta ~ normal(0,1000);
  sigma~cauchy(0,5);
  }
  generated quantities {
  vector[n] log_lik;
  
  for (i in 1:n) {
  log_lik[i] = normal_lpdf(y[i] | mu[i], sig[i]); 
  }
  }
  
  
