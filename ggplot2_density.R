library(ggplot2)
library(dplyr)
library(plyr)
#access.log is required to be included int eh same directory
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

df1 <- df['ip_address']
cnt_top_ten <- count(df1, 'ip_address') %>% arrange(desc(freq)) %>%
  slice(1:10)
df2 <- as.data.frame(cnt_top_ten)
print(df2)
#ggplot( data = df2, aes(x = as.numeric(row.names(df2)), y = df2$freq) ) + geom_bar(stat = 'identity') + xlab('Id') + ylab('Freq')
ggplot( data = df2, aes(x = df2$ip_address, y = df2$freq) ) + geom_bar(stat = 'identity', fill = df2$freq) + xlab('IP') + ylab('Freq') + theme(axis.text.x = element_text(color="black", size=6, angle=45),  axis.text.y = element_text(color="black", size=6, angle=45))
ggsave("plot.png", width = 5, height = 5)