#Who were malicious hackers - for example anything that has php is a hacker (since we don't use Php).

library(ggplot2)
library(stringr)
library(stringi)
library(rebus)
library(devtools)
library(IPtoCountry)
#access.log is required to be included int eh same directory
df = read.table('access.log')
#head(df)
colnames(df) = c('country', 'nameless_v2', 'nameless_v3', 'date', 'nameless_v5', 'request', 'status', 'bytes', 'url', 'browser_specs')
#head(df['request'])
df$date = as.Date(df$date, "[%d/%b/%Y")
df$request = str_sub(df$request, -13,-10)
df$country = IP_country(df$country)
df1 <- df[df[6] == '.php',]

#print(x)
#df_ip_summary <- IP_country(df$ip_address)
#df_ip_summary
#contains_php <- str_detect(x , pattern = DOT %R% 'php')
#sum_php <- sum(contains_php)

reqs = as.data.frame(table(df1$country))
php_reqs = reqs[reqs$Freq >0,]

ggplot( data = php_reqs, aes(x = php_reqs$Var1, y = php_reqs$Freq)) + geom_bar(stat = 'identity', fill = php_reqs$Freq) + 
  xlab('Country with .php in request') + ylab('Count') + 
  theme(axis.text.x = element_text(color = "black", size = 8, angle = 45),  axis.text.y = element_text(color = "black", size=8, angle=45))

#ggsave("plot_php_count.png", width = 15, height = 15)

