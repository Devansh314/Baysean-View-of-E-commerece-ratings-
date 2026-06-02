# Baysean-View-of-E-commerece-ratings-
Bayesian Beta-Binomial framework for ranking e-commerce sellers by probability of dominance — derives closed-form P(X₁ > X₂) solutions and shows why expected-value ranking fails under review-count uncertainty. Implemented in R. It is essentially a probabilistic approach to the "which seller should you trust?" problem 
🛒 Bayesian View of E-Commerce Resellers
A Probabilistic Framework for Evaluating Seller Trustworthiness from Review Data
![R](https://www.r-project.org/)
![License: MIT](https://opensource.org/licenses/MIT)
[![Stats](https://img.shields.io/badge/Method-Bayesian%20Inference-8A2BE2?style=flat-square)]()
[![Domain](https://img.shields.io/badge/Domain-E--Commerce%20Analytics-FF6B35?style=flat-square)]()
---
📌 Overview
When you browse a product on an e-commerce platform and see three sellers — one with 10 reviews at 100% positive, another with 50 reviews at 96% positive, and a third with 200 reviews at 93% positive — which do you choose?
This project answers that question rigorously using Bayesian statistical inference. Rather than relying on raw percentages or simple averages, we model each seller's underlying quality as a continuous random variable and compute the probability that one seller is genuinely better than the others — accounting for uncertainty introduced by small sample sizes.
The project derives and implements a closed-form analytical solution for the probability of dominance between Beta-distributed random variables, providing a mathematically principled basis for consumer decision-making in e-commerce.
---
🎯 Research Objectives
Formalize the buyer's problem: Frame the seller-selection problem as Bayesian inference over an unknown success rate parameter `S ∈ \[0, 1]`.
Model seller quality with the Beta distribution: Derive why the Beta distribution is the natural conjugate prior for binomial review data.
Quantify comparative trust: Derive closed-form expressions for `P(X₁ > X₂)` and `P(Xₖ > max(Xᵢ, Xⱼ))` for Beta-distributed random variables.
Demonstrate why expected value alone is insufficient: Show that probability of dominance — not just posterior mean — is the correct optimality criterion.
Apply to a real scenario: Evaluate the three-seller problem from the opening example with full mathematical transparency.
---
🧠 Research Hypotheses
> \*\*H1 (Sample Size Effect):\*\* A seller with more reviews but a slightly lower percentage rating will have a higher posterior probability of being the best choice than a seller with fewer reviews and a higher percentage, due to reduced uncertainty.
> \*\*H2 (Inadequacy of Expected Value):\*\* Ranking sellers by posterior expected value `E\[S] = α/(α+β)` does not always agree with ranking by probability of dominance `P(Xₖ = max)`, and the latter is the superior decision criterion under uncertainty.
> \*\*H3 (Convergence of Posterior):\*\* As review counts grow, the posterior Beta distribution tightens around the true success rate, reducing the gap between probability-of-dominance rankings and simple percentage rankings.
---
📐 Methodology
Statistical Framework
The model treats each seller-buyer interaction as a Bernoulli trial: each review is either positive (success, probability `S`) or negative (failure, probability `1-S`). The seller's underlying quality `S` is unknown and modeled probabilistically.
Step 1 — Likelihood (Binomial Distribution)
For `n` total reviews with `x` positive reviews, given a known success rate `S`:
```
P(X = x | S) = C(n,x) · Sˣ · (1-S)^(n-x)
```
Step 2 — Prior & Posterior (Beta Distribution)
Since `S` is continuous on `\[0,1]`, we need a probability density function. The Beta distribution is derived as the natural choice:
```
f(s | α, β) = \[s^(α-1) · (1-s)^(β-1)] / B(α, β)
```
With a uniform prior `Beta(1,1)`, the posterior after observing `a` successes and `b` failures becomes:
```
Posterior: Beta(α = a+1, β = b+1)
```
This is the conjugate update: the prior and posterior share the same distributional family.
Step 3 — Deriving P(X₁ > X₂) Analytically
For two independent Beta random variables, the probability that `X₁` dominates `X₂` is derived via the regularized incomplete Beta function:
```
P(x₁ > x₂) = 1 - Σᵢ₌₀^(α₂-1) \[ B(α₁+i, β₁+β₂) / ((β₂+i)·B(1+i, β₂)·B(α₁, β₁)) ]
```
Step 4 — Three-Way Dominance
The probability that seller `k` beats both other sellers is computed using double summation over the regularized incomplete Beta function:
```
P(x₃ > max{x₁,x₂}) = 1 − P(x₁>x₃) − P(x₂>x₃)
    + Σᵢ Σⱼ \[ B(α₃+i+j, β₃+β₂+β₁) / ((β₁+i)(β₂+j)B(1+i,β₁)B(1+j,β₂)B(α₃,β₃)) ]
```
Data
The analysis uses a motivating example drawn from real e-commerce review dynamics:
Seller	Total Reviews	Positive	Negative	Rating
D1	10	10	0	100%
D2	50	48	2	96%
D3	200	186	14	93%
Posterior distributions:
Seller	Posterior	α	β
D1	Beta(11, 1)	11	1
D2	Beta(49, 3)	49	3
D3	Beta(187, 15)	187	15
Implementation Language
All derivations, numerical computations, and visualizations are implemented in R using base R functions (`dbeta`, `pbeta`, `integrate`) with no external package dependencies beyond base graphics.
---
📊 Key Findings & Visualizations
Finding 1 — Posterior Beta Distributions
Plotting `Beta(11,1)`, `Beta(49,3)`, and `Beta(187,15)` reveals that:
D1's distribution (10 reviews, 100%) is extremely wide — high uncertainty
D2's distribution is moderately concentrated around ~0.94
D3's distribution is sharply peaked near 0.925 — lowest uncertainty
Visualization: `beta\_distributions.png` — overlaid density plot of three posterior distributions.
Finding 2 — Expected Values
Computing posterior means `E\[X] = α/(α+β)`:
```
E(X₁) = 11/12  = 0.9166   (Seller D1)
E(X₂) = 49/52  = 0.9423   (Seller D2)  ← highest mean
E(X₃) = 187/202 = 0.9257  (Seller D3)
```
By this metric alone: D2 > D3 > D1.
Finding 3 — Probability of Dominance (Key Result)
Using the closed-form analytical solution:
```
P(D3 beats both D1 and D2) = 0.1415
P(D2 beats both D1 and D3) = 0.4463   ← WINNER
P(D1 beats both D2 and D3) = 0.4122
```
Counterintuitive insight: D1 (100% rating, only 10 reviews) has a substantial probability (41%) of being the best seller — nearly matching D2. This is because extreme small-sample results generate wide posterior distributions with heavy tails at high values of `S`.
Finding 4 — Why Expected Value Misleads
The project demonstrates a concrete case using `Beta(5,5)` vs `Beta(20,6)`:
`E\[Beta(5,5)] = 0.50`, `E\[Beta(20,6)] = 0.769` → expected value favors `Beta(20,6)`
However, `Var\[Beta(5,5)] = 0.0227 > Var\[Beta(20,6)] = 0.00657`
The spread of `Beta(5,5)` means it occasionally generates very high values, giving it a non-trivial probability of dominance despite the lower mean
This validates H2: probability of dominance is the superior criterion.
---
📁 Repository Structure
```
bayesian-ecommerce-resellers/
│
├── README.md                        # This file
│
├── report/
│   └── PS\_Project.pdf               # Full 44-page project report with
│                                    # derivations, visualizations, and R code
│
├── code/
│   ├── beta\_distributions.R         # Plot three posterior Beta distributions
│   ├── pairwise\_dominance.R         # Compute P(X₁ > X₂) using closed-form solution
│   ├── three\_way\_dominance.R        # Compute P(Xₖ > max(Xᵢ, Xⱼ)) for all sellers
│   ├── expectation\_variance.R       # Posterior mean and variance calculations
│   └── dominance\_vs\_expectation.R   # Comparison: E\[X] ranking vs P(dominance) ranking
│
├── figures/
│   ├── beta\_distributions.png       # Overlaid posterior density plots
│   ├── beta\_with\_expectations.png   # Beta distributions annotated with E\[X] values
│   └── 3d\_joint\_distribution.png    # Joint density surface for P(x₁ > x₂) visualization
│
└── LICENSE
```
---
⚙️ Installation & Usage
Prerequisites
R (version 4.0 or above) — Download R
No additional packages required; all code uses base R
Setup
```bash
# Clone the repository
git clone https://github.com/<your-username>/bayesian-ecommerce-resellers.git
cd bayesian-ecommerce-resellers
```
Running the Analysis
Step 1 — Visualize the three posterior Beta distributions:
```r
source("code/beta\_distributions.R")
# Outputs: figures/beta\_distributions.png
```
Step 2 — Compute pairwise dominance probability:
```r
source("code/pairwise\_dominance.R")
# Returns: P(X₁ > X₂), P(X₂ > X₁), etc.
```
Step 3 — Compute three-way dominance (main result):
```r
source("code/three\_way\_dominance.R")
# Returns:
#   P(D1 beats both) = 0.4122
#   P(D2 beats both) = 0.4463
#   P(D3 beats both) = 0.1415
```
Step 4 — Compare E[X] ranking vs dominance ranking:
```r
source("code/dominance\_vs\_expectation.R")
```
Reproducing the Core Visualization (Beta Distributions Plot)
```r
x <- seq(0, 1, length = 10000)

y1 <- dbeta(x, shape1 = 11, shape2 = 1)    # Seller D1: Beta(11,1)
y2 <- dbeta(x, shape1 = 49, shape2 = 3)    # Seller D2: Beta(49,3)
y3 <- dbeta(x, shape1 = 187, shape2 = 15)  # Seller D3: Beta(187,15)

plot(x, y1, type = "l", col = "blue", lwd = 2,
     ylim = c(0, max(y1, y2, y3)),
     main = "Beta Distributions", xlab = "x", ylab = "Density")
lines(x, y2, col = "red", lwd = 2)
lines(x, y3, col = "violet", lwd = 2)
legend("topleft",
       legend = c("Beta(11,1)", "Beta(49,3)", "Beta(187,15)"),
       col = c("blue", "red", "violet"), lwd = 2)
```
---
🔍 Results Interpretation Guide
Metric	Formula	Interpretation
Posterior α	`α = positive\_reviews + 1`	Effective "success count" including prior
Posterior β	`β = negative\_reviews + 1`	Effective "failure count" including prior
Posterior Mean	`E\[X] = α / (α + β)`	Best single estimate of seller quality
Posterior Variance	`Var\[X] = αβ / \[(α+β)²(α+β+1)]`	Uncertainty in the quality estimate; decreases with more reviews
P(Xₖ > Xⱼ)	Closed-form double sum	Probability seller k is genuinely better than seller j
P(Xₖ = best)	Three-way dominance formula	Probability seller k is the best option to buy from
Decision rule: Choose the seller with the highest `P(Xₖ = best)`. This outperforms both "highest rating %" and "highest posterior mean" as a selection criterion because it fully accounts for the uncertainty that arises from small review counts.
---
💡 Contribution to Consumer Behavior Research
This project offers several insights relevant to e-commerce platforms, behavioral economics, and consumer psychology:
1. The 100% Paradox: A seller with a perfect rating from a small number of reviews is not necessarily inferior to one with a slightly lower rating from more reviews. Bayesian updating assigns a wide posterior to perfect-but-sparse data, preserving the possibility of genuine high quality.
2. Sample Size is Information: The model formally quantifies what consumers intuitively feel — that more reviews make a rating more credible. The posterior variance `Var\[X] = αβ/\[(α+β)²(α+β+1)]` decreases as review counts grow, narrowing the distribution.
3. Platform Design Implications: E-commerce platforms currently display raw percentages or star averages. A Bayesian "confidence-adjusted score" — equivalent to displaying the posterior mean or a probability of dominance ranking — would better serve buyers, particularly for sellers with fewer than ~30 reviews.
4. Review Inflation Detection: Sellers artificially suppressing negative reviews would show an unusually narrow, high-confidence posterior inconsistent with their volume. Platforms could flag such anomalies using this framework.
5. Generalizability: While framed around e-commerce resellers, the Beta-Binomial Bayesian framework applies broadly — clinical trial success rates, ad click-through optimization, A/B testing, and anywhere a sequence of binary outcomes must be ranked under uncertainty.
---
📄 License
This project is licensed under the MIT License — see the LICENSE file for details.
---
📖 Citation
If you use this work in your research or coursework, please cite:
```bibtex
@misc{bayesian\_ecommerce\_resellers\_2024,
  author       = {A222, A210},
  title        = {Bayesian View of E-Commerce Resellers: A Probabilistic Framework
                  for Evaluating Seller Trustworthiness from Review Data},
  year         = {2024},
  institution  = {B.Tech Computer Engineering, Batch II},
  note         = {Probability and Statistics Course Project}
}
```
---
🙏 Acknowledgements
This project was developed as part of a Probability and Statistics course in the B.Tech Computer Engineering program. The motivating problem — choosing between three sellers with different review volumes and ratings — was used as a pedagogical thread to connect Bayesian inference, Beta distributions, and decision theory.
---
Presented by: A222, A210 · B-Tech C.E., Batch II · November 2024
