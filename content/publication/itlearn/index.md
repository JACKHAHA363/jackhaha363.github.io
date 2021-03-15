    ---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Countering Language Drift with Seeded Iterated Learning"
authors: [Yuchen Lu, Soumye Singhal, Florian Strub, Olivier Pietquin, Aaron Courville]
date: 2020-05-23T23:52:57-05:00
doi: ""

# Schedule page publish date (NOT publication's date).
publishDate: 2020-05-23T23:52:57-05:00

# Publication type.
# Legend: 0 = Uncategorized; 1 = Conference paper; 2 = Journal article;
# 3 = Preprint / Working Paper; 4 = Report; 5 = Book; 6 = Book section;
# 7 = Thesis; 8 = Patent
publication_types: ["1"]

# Publication name and optional abbreviated publication name.
publication: "Thirty-seventh International Conference on Machine Learning"
publication_short: "ICML"

abstract: "Supervised learning methods excel at capturing statistical properties of language when trained over large text corpora. Yet, these models often produce inconsistent outputs in goal-oriented language settings as they are not trained to completethe underlying task. Moreover, as soon as theagents are finetuned to maximize task completion, they suffer from the so-called language drift phenomenon: they slowly lose syntactic and semantic properties of language as they only focus on solving the task. In this paper, we proposea generic approach to counter language drift by using iterated learning. We iterate between finetuning agents with interactive training steps, and periodically replacing them with new agents that are seeded from last iteration and trained to imitate the latest finetuned models. Iterated learning does not require external syntactic constraint nor semantic knowledge, making it a valuable task-agnostic finetuning protocol. We first  explore iterated learning in the Lewis Game. We then scale-up the approach in the translation game. In both settings, our results show that iterated learning drastically counters language drift as well as it improves the task completion metric."

# Summary. An optional shortened abstract.
summary: ""

tags: []
categories: []
featured: true

# Custom links (optional).
#   Uncomment and edit lines below to show custom links.
# links:
# - name: Follow
#   url: https://twitter.com
#   icon_pack: fab
#   icon: twitter

url_pdf: https://arxiv.org/abs/2003.12694
url_code: https://github.com/JACKHAHA363/SILTranslationGame
url_dataset:
url_poster:
url_project:
url_slides: slides.pdf
url_source:
url_video:

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder. 
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: "Game Overview"
  focal_point: "Center"
  preview_only: false

# Associated Projects (optional).
#   Associate this publication with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `internal-project` references `content/project/internal-project/index.md`.
#   Otherwise, set `projects: []`.
projects: []

# Slides (optional).
#   Associate this publication with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides: "example"` references `content/slides/example/index.md`.
#   Otherwise, set `slides: ""`.
slides: ""
---
