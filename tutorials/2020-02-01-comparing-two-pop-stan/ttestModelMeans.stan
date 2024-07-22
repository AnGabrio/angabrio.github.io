  
 data {
 int n;
 int nX;
 vector [n] y;
 matrix [n,nX] x;
 }
 parameters {
 real <lower=0, upper=100> sigma;
 vector [nX] beta;
 }
 transformed parameters {
 }
 model {
 vector [n] mu;
 
 //Priors
 beta ~ normal(0,1000);
 sigma ~ cauchy(0,25);
 
 mu = x*beta;
 //Likelihood
 y ~ normal(mu, sigma);
 }
 generated quantities {
 vector [2] Group_means;
 real CohensD;
 
 //Other Derived parameters 
 Group_means[1] = beta[1];
 Group_means[2] = beta[1]+beta[2];
 
 CohensD = beta[2] /sigma;  
 }
 
 
