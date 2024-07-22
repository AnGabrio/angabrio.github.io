
data {
int<lower=0> n_sim;
vector[n_sim] y;
vector[n_sim] x;
}
parameters {
real beta0;
real beta1;
real<lower=0> sigma;
}
transformed parameters {
vector[n_sim] mu;
mu=beta0 + beta1*x;
} 
model {
sigma~uniform(0,100);
beta0~normal(0,1000);
beta1~normal(0,1000);
y~normal(mu,sigma);
}


