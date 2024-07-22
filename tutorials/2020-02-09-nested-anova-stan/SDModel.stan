
data{
   int n;
   int nA;
   int nSites;
   vector [n] y;
   matrix [nSites,nA] X;
   matrix [n,nSites] Z;
}

parameters{
   vector[nA] beta;
   vector[nSites] gamma;
   real<lower=0> sigma;
   real<lower=0> sigma_S;
   
}

model{
    vector [n] mu_site;
    vector [nSites] mu;

    // Priors
    beta ~ normal( 0 , 1000 );
    gamma ~ normal( 0 , 1000 );
    sigma ~ cauchy( 0 , 25 );
    sigma_S~ cauchy( 0 , 25 );

    mu_site = Z*gamma;
    y ~ normal( mu_site , sigma );
    mu = X*beta;
    gamma ~ normal(mu, sigma_S);
}

generated quantities {
    vector [n] mu_site;
    vector [nSites] mu;
    vector [n] y_err;
    real sd_y;
    vector [nSites] mu_site_err;
    real sd_site;
    real sd_A;
    
    mu_site = Z*gamma;
    y_err = mu_site - y;
    sd_y = sd(y_err);

    mu = X*beta;
    mu_site_err = mu - gamma;
    sd_site = sd(mu_site_err);

    sd_A = sd(beta);
}


