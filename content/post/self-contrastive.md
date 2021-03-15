---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Self-contrastive Training of Generative Models"
subtitle: ""
summary: ""
authors: []
tags: []
categories: []
date: 2016-10-26
lastmod: 
featured: false
draft: true

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: ""
  focal_point: ""
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: []
---
In the original paper on [Noise Contrastive Estimation (NCE)](http://jmlr.csail.mit.edu/proceedings/papers/v9/gutmann10a/gutmann10a.pdf), the author proves that the lower bound on the variance of the NCE estimator can be achieved if the noise distribution is equal to the data distribution. Therefore it becomes natural to think if we can use as a noise model the generative model trained in previous epoch/iteration. I would call this kind of training self-contrastive, since it uses samples from previous models. In this post, I going to give some justifications of this training method and present a toy experiment on VAE.

## Can Self-Contrastive Methods Work?

The success of NCE is due to the following fact: The derivative of the NCE objective would converge to that of an MLE objective, once you have enough number of noise samples. Nevertheless, can we still have the same result in the self-contrastive case, where the noise distribution is constantly changing? The answer is yes. Ian Goodfellow provides an argument in [this paper](https://arxiv.org/pdf/1412.6515v4.pdf). The main result is that the gradient of self-contrastive objective is
$$
\frac{1}{2} \mathbb{E}\_{x\sim p\_d} \frac{\partial }{\partial\theta} \log p\_m(x) 
$$
where $p_d, p_m$ are data and model distribution. This result provides the theoretic guarantee that we are optimizing in the right direction.

Another justification for this training method comes from a more fundamental energy-based view. Any probability distribution can be characterized using an energy function $E(x)$ such that
$$
P(x) = \frac{e^{-E(x)}}{Z}
$$
where $Z$ is the partition function. Therefore during training, basically we need to pull down the energy of all the data seen before. This is usually easy to do. Nevertheless, we need to be cautious about the naive solution where the energy is low for all data. Hence, during training we also need to pull up the energy of the unseen data, which is difficult because of the intractability of the partition function $Z$. 

In self-contrastive training, we achieve the high energy of unseen data by selectively choosing the negative examples. Sampling from previously trained models should be more efficient than sampling from simple uniform or Gaussian distribution, since these negative examples should be closer to the true data manifold and we don't waste time pulling up the energy of apparently nonsense data.

## Toy Experiment on VAE

I choose VAE to do the experiment taking into account the following facts:

* VAE is easy to sample. This is a big plus as we need to constantly sample from previous models.
* VAE has a good approximation of lower bound of log-likelihood, which can be computed efficiently.

I used VAE for MNIST dataset, and for each five epochs, I switched the noise model to be the previous trained VAE. Here is the plot of validation lower-bound.

{{< figure src="/img/self-contrastive-ll.png" title="Validation Lower Bound" lightbox="true" >}}

There is an interesting "step" behavior whenever we switch noise, and with a better noise, we are going to converge slower. Our generative model is able to out-perform the previous itself until it converges. In the end, we have a lower bound around -90, which is close to the normal way of training VAE. 

## Some Conclusions
Although self-contrastive training works in some cases and it exhibits interesting training behaviors, some facts must be considered here:

The value of self-contrastive training is more theoretical than practical. The experiment shows that optimizing self-contrastive objective indeed can improve log-likelihood as is suggested by Goodfellow. Nevertheless, there's no guarantee, at least not to my knowledge, that this training could lead to better results than MLE asymptotically. 

Considering the fact that we are pulling up the energy of samples close to the data manifold, it is likely that this training framework could result in a sharper energy surface than pure MLE method. As a result, it could be one potential solution for generating crispy and clear images from VAE.

The toy experiment is flawed because of the lower bound in VAE. Lower bound is suitable when you want to improve the likelihood, but in the second the term of self-contrastive objective $ \mathbb{E}_{x\sim p_n} \log \frac{p_g(x)}{p_m(x) + p_g(x)} $, we would like to minimize $ p_m(x) $. Minimizing a lower bound would not minimize the likelihood for sure. One possible solution is to use the family of Renyi $ \alpha $-divergence mentioned [here](https://arxiv.org/pdf/1602.02311v2.pdf) in an encoder-decoder context. By choosing the right parameter, we are able to get a variational upper bound for likelihood, but how to approximate that upper bound by sampling is another problem if we are going down this path.