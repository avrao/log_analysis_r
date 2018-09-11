#What were malicious hackers - for example anything that has php is a hacker (since we don't use Php).
# How many puts / posts were there.

library(ggplot2)
library(stringr)
#access.log is required to be included int eh same directory
df = read.table('access.log')
#head(df)
colnames(df) = c('ip_address', 'nameless_v2', 'nameless_v3', 'date', 'nameless_v5', 'request', 'status', 'bytes', 'url', 'browser_specs')
#head(df['request'])
df$request = as.vector(str_sub(df$request, -13,-10))
x <- as.vector(df$request)
#print(x)


contains_php <- str_detect(x , pattern = DOT %R% 'php')
sum_php <- sum(contains_php)

reqs = as.data.frame(table(df$request[contains_php]))

ggplot( data = reqs, aes(x = reqs$Var1, y = reqs$Freq) ) + geom_bar(stat = 'identity', fill = reqs$Freq) + xlab('Number of .php in request') + ylab('Count')
ggsave("plot_php_count.png", width = 15, height = 15)

