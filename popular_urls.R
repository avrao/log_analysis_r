#What were the most popular URLS
library(ggplot2)
library(dplyr)

df = read.table('access.log')
#head(df)
colnames(df) = c('ip_address', 'nameless_v2', 'nameless_v3', 'date', 'nameless_v5', 'request', 'status', 'bytes', 'url', 'browser_specs')
df$date = as.Date(df$date, "[%d/%b/%Y")
#df$time = as.Date(df$time, ":h:m:s")
# head(df[["date"]])
# head(df[["status"]])
# head(df)
# str(df)
#print(names(df))

#tbl <- table(df$ip_address) 

df1 <- df['url']
cnt_top_five <- count(df1, 'url') %>% arrange(desc(freq)) %>%
  slice(1:5)
df2 <- as.data.frame(cnt_top_five)
print(df2)
#ggplot( data = df2, aes(x = as.numeric(row.names(df2)), y = df2$freq) ) + geom_bar(stat = 'identity') + xlab('Id') + ylab('Freq')
ggplot( data = df2, aes(x = df2$url, y = df2$freq) ) + geom_bar(stat = 'identity', fill = df2$freq) + xlab('URL') + ylab('Freq') + ggtitle('Popular SJAC URLs') + theme(axis.text.x = element_text(color = "black", size = 8, angle = 45),  axis.text.y = element_text(color = "black", size=8, angle=45))
ggsave("plot_top5_urls.png", width = 15, height = 15)