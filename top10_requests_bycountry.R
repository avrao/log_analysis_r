#Requests from top 10 countries
library(ggplot2)
library(dplyr)
library(plyr)
#devtools::install_github("gitronald/IPtoCountry")
library(devtools)
library(IPtoCountry)


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
# ip_int <- IP_integer(df1$ip_address)
# ip_lkup <- IP_lookup(ip_int)
# print(ip_lkup)



ip_summary <- IP_location(df1$ip_address)
#print(head(ip_summary))
cnt_ip <- count(ip_summary, 'country')
cnt_top <- count(ip_summary, 'country') %>% arrange(desc(freq)) %>% slice(1:10)
#lets change an unknown country to "Unknown"
cnt_top$country <- gsub('-', 'Unknown', cnt_top$country)
#list1 <- list(cnt_top,ip_summary[])
#df1 <- as.data.frame(list1)

ggplot( data = cnt_top, aes(x = cnt_top$country, y = cnt_top$freq) ) + geom_bar(stat = 'identity', fill = cnt_top$freq) 
+ xlab('Country') + ylab('Count') + ggtitle('Top 10 Request from Country') 
+ theme(axis.text.x = element_text(color = "black", size = 8, angle = 45),  axis.text.y = element_text(color = "black", size=8, angle=45))
ggsave("plot_top10_requests_bycountry.png", width = 15, height = 15)