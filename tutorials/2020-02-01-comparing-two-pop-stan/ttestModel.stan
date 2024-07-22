 
data {
 int n;
 vector [n] y;
 vector [n] x;
 }
 parameters {
 real <lower=0, upper=100> sigma;
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
 y ~ normal(mu, sigma);
 }
 generated quantities {
 vector [2] Group_means;
 real CohensD;
 //Other Derived parameters 
 //# Group means (note, beta is a vector)
 Group_means[1] = beta0;
 Group_means[2] = beta0+beta;
 
 CohensD = beta /sigma;  
 }
 
 
