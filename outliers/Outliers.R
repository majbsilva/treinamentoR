library(rstatix)
library(dplyr)

# Adicionando dados
ds = mtcars

# Procurando outliers com o método do IQR utilizando o pacote rstatix

outliers = ds %>% identify_outliers(hp)
outliers
ds_clean = ds %>% filter(hp != 335)

## is.outlier tambem faz pelo intervalo interquartil.
ds$is_outlier_hp = is_outlier(ds$hp)  # faz pelo intervali interquartil


# Procurando outliers utilizando o Z-score
ds$hpzscore = scale(ds$hp) # essa função faz o z-score

# Procurando um outlier - teste de Grubb - ele é indicado para distribuicao normal. G = valor extremo - média / desvio padrao
library(outliers)
grubbs.test(ds$hp)
ds_clean = ds %>% filter(hp != 335)

# Procurando mais de um outlier - teste de rosner. -----
## A estatística usada é uma versão modificada do teste t (estatística Z modificada). Ele compara o valor extremo com a média e desvio padrão dos dados restantes (excluindo temporariamente o ponto extremo). O teste de Rosner detecta outliers de forma iterativa, ou seja, ele identifica o outlier mais extremo, remove-o temporariamente e então reavalia o restante dos dados para verificar se há outros outliers. Ele faz isso até atingir um número máximo de outliers especificado por você.

library(EnvStats)
rosnerTest (ds$hp, k = 5)
ds_clean = ds[-31, ]
