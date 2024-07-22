
  data {
  int<lower=1> n;
  vector [n] y;
  int<lower=1> nX;
  matrix[n,nX] X;
  }
  transformed data {
  }
  parameters {
  vector[nX] beta;
  real<lower=0> sigma;
  real<lower=-1,upper=1> phi;
  }
  transformed parameters {
  vector[n] mu;
  vector[n] epsilon;
  mu = X*beta;
  epsilon[1] = y[1] - mu[1];
  for (i in 2:n) {
  epsilon[i] = (y[i] - mu[i]);
  mu[i] = mu[i] + phi*epsilon[i-1];
  }
  }
  model {
  phi ~ uniform(-1,1);
  beta ~ normal(0,100);
  sigma ~ cauchy(0,5);
  y ~ normal(mu, sigma);
  }
  generated quantities {
  }
  
  
