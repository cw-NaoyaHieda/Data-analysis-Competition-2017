# #NAME?になっている商品の調査
library(tidyverse)


# データの読み込み
# 各自のディレクトリでどうぞ
detail <- read.csv("D:/Git/DataAnalysis2017/data/会計明細.csv")
item <- read.csv("D:/Git/DataAnalysis2017/data/商品マスタ.csv")


item %>% dplyr::filter(商品名=="#NAME?") # 2個あった
  # 第１カテゴリ：クーポン
  # 第２カテゴリ：直営店クーポン
  # 施術分数：１０分
  # 値段：1000円と1500円

  # トリートメントとか前髪調整とかの小技系じゃないか。


# どれぐらい売り買いされているかを見る。
item %>%  
  dplyr::filter(商品名=="#NAME?") %>% 
  .$会計明細販売商品ID %>% 
  as.character() %>% 
  as.integer() -> NAME.id # 該当商品のidを保存。
  
# それなりに売り買いされている
detail %>% 
  dplyr::filter(会計明細販売商品ID==NAME.id) 



# 提案：商品名を「不明クーポン」などにして放置。



# 気づいちゃったこと。
detail %>% 
  dplyr::filter(会計明細販売商品ID==NAME.id) %>% 
  .$会計明細販売担当者ID %>% 
  as.factor %>% 
  levels
# "5"   "9"   "34"  "38"  "40"  "43"  "49"  "152"
# なんと、136回の会計があるが８人の担当者しかいない！
# 少なくない？？？