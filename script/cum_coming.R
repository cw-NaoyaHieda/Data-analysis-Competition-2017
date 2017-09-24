#パッケージのインストールと読み込み
#持ってないパッケージはインストールする
targetPackages <- c('tidyverse') 
newPackages <- targetPackages[!(targetPackages %in% installed.packages()[,"Package"])]
if(length(newPackages)) install.packages(newPackages, repos = "http://cran.us.r-project.org")
for(package in targetPackages) library(package, character.only = T)

# 会計履歴の累積来店回数が負のものの確認

history <- read.csv("data/会計履歴.csv")

summary(history)

# 0以下のもの。全部で877件ある
history %>% 
  dplyr::filter(累積来店回数 <= 0) %>% 
  dim()

# 0のもの。全部で832件ある
history %>%
  dplyr::filter(累積来店回数 == 0) %>% 
  dim()

# 負のもの。全部で45件ある
history %>%
  dplyr::filter(累積来店回数 < 0)


# 負のものに限ってやってみる。----
# なんか怪しい奴いる。
# ID:22843
history %>% 
  dplyr::filter(累積来店回数 < 0) %>% 
  xtabs(data=., ~顧客ID)

# 単調増加になることが予想される
# 違った。
history %>% 
  dplyr::filter(顧客ID == 22843) %>% 
  .$累積来店回数

# 返品処理によるマイナスの分で負になってるのではないか
# その通りでした。
history %>% 
  dplyr::filter(顧客ID== 22843) %>% 
  .[,c("取引種別","累積来店回数")]


# 提案----
# 返品処理を正しく行ってから考える必要がある。
# 原因もわかり、そこまで深刻な問題ではない。

# Excellent! 
# じゃあ、保留にしとくね 20170924