# 顧客マスタの備考について
# フリー女性、フリー男性、会員情報無し

library(tidyverse)

customer <- read.csv("data/顧客マスタ.csv")
history <- read.csv("data/会計履歴.csv")

# まずはそれぞれの人数
# 空文字がいっぱいあります
# フリー女性：４
# フリー男性：１
# 会員情報無し：１
xtabs(~備考, data = customer)

# そもそも、フリーって何ですか


# フリー男性----
# 顧客ID:991
customer %>% 
  dplyr::filter(備考=="フリー男性")

# 40回買い物してる
# フリー男性と言ってる割に指名はしてたりしてなかったり
# 新宿サウス店と上大岡店にばっかり言ってる。
history %>% 
  dplyr::filter(顧客ID == 991) 


# 累積来店回数、中途半端に多い。
history %>% 
  dplyr::filter(顧客ID == 991) %>% 
  .$累積来店回数



# フリー女性----
# 4人
customer %>% 
  dplyr::filter(備考 == "フリー女性")

female.id <- customer %>% 
  dplyr::filter(備考 == "フリー女性") %>% 
  .$顧客ID

# やっぱりどう考えても累積来店回数が多い。
# フリー女性の4人も、店舗ごとにまとめられてるだけなのでは
for(i in 1:4){
  history %>% dplyr::filter(顧客ID == female.id[1]) %>% show()
}


# 会員情報無し----
# これも同様
customer %>% 
  dplyr::filter(備考 == "会員情報無し")

history %>% 
  dplyr::filter(顧客ID==6137)
# 累積来店回数もポイント残高もやばすぎ

history %>% 
  dplyr::filter(顧客ID==6137) %>% 
  .$販売店舗ID %>% 
  as.factor %>% 
  levels
# 全店舗行ってるし


# 提案----
# フリー女性、フリー男性、会員情報無し
# すべての顧客IDをNULLにすれば良いのでは
# 会計履歴の方も該当IDをNULLに