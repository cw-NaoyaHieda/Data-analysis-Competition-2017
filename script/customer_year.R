#パッケージのインストールと読み込み
#持ってないパッケージはインストールする
targetPackages <- c('tidyverse', 'dplyr') 
newPackages <- targetPackages[!(targetPackages %in% installed.packages()[,"Package"])]
if(length(newPackages)) install.packages(newPackages, repos = "http://cran.us.r-project.org")
for(package in targetPackages) library(package, character.only = T)

# 顧客マスタ
# 誕生年代との初回来店年の異常について

customer <- read.csv("data/顧客マスタ.csv")
history <- read.csv("data/会計履歴.csv")
summary(customer)
dim(customer)



# 誕生年代について----
# NAは7915人
xtabs(~誕生年代, data=customer)

# 明らかに2名ほどやべぇやついる。
# 2030年代生まれ
# 2080年代生まれ

# 確認
customer %>% 
  dplyr::filter(誕生年代 > 2011)
# 備考もなにもない。会計データと照らし合わせてみる。

# 2030年生まれ
history %>% 
  dplyr::filter(顧客ID == 10504)
# 2080年生まれ
history %>% 
  dplyr::filter(顧客ID == 18135)

# どちらも、累計来店回数などを見ると普通のお客さんっぽい

# 提案:普通にNULLにしてしまえば良いのでは。



# 初回来店年について----
# NA:なし

# とりあえず、分布をみる。
# 少なくとも1980年より前は何なのか良く分からん。
xtabs(~初回来店年, data = customer)

# 1980年以前のやつを抜き出してみる。
# 88人
customer %>% 
  dplyr::filter(初回来店年 < 1980) 
# 来店店舗は1, 10, 11, 12に集中している。
# それぞれ青山店、上大岡店、横浜西口店、吉祥寺店


# さらに、誕生する前に来てるやつもおかしいよね。
# 74件ヒット
customer %>% 
  dplyr::filter(初回来店年 < 誕生年代)

# 提案
# 日本進出がいつからなのか分からないけれども上記の
# 不自然な奴はNULLにしちゃえばいいと思います。



# 20170924/稗田
# 誕生年代についての二件---- 年代をNULLでよし
# 初回来店について
# 日本進出は1978年 http://modshair.co.jp/bland/
# 初回来店年について----　こちらもNULLで
