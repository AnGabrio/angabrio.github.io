 
 data {
 int n;
 vector [n] y;
 vector [n] x;
 int<lower=1,upper=2> xn[n];
 }
 parameters {
 vector <lower=0, upper=100>[2] sigma;
 real beta0;
 real beta;
 }
 transformed parameters {
 }
 model {
 vector [n] mu;
 //Priors
 beta0 ~ normal(0,1000);
 beta ~ normal(0,1000);
 sigma ~ cauchy(0,25);

 mu = beta0 + beta*x;
 //Likelihood
 for (i in 1:n) y[i] ~ normal(mu[i], sigma[xn[i]]);
 }
 generated quantities {
 vector [2] Group_means;
 real CohensD;
 real CLES;

 Group_means[1] = beta0;
 Group_means[2] = beta0+beta;
 CohensD = beta /(sum(sigma)/2);
 CLES = normal_cdf(beta /sum(sigma),0,1);  
 }
 
 
