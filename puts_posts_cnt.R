# How many puts / posts were there.
library(ggplot2)
library(stringr)
#access.log is required to be included int eh same directory
df = read.table('access.log')
#head(df)
colnames(df) = c('ip_address', 'nameless_v2', 'nameless_v3', 'date', 'nameless_v5', 'request', 'status', 'bytes', 'url', 'browser_specs')
head(df['request'])
df$request = as.vector(str_sub(df$request, 1,4))
x <- as.vector(df$request)
print(typeof(x))

put_post <- or("POST", "PUT")

contains_post <- str_detect(x , pattern = START %R% put_post)
sum_post <- sum(contains_post)
reqs = as.data.frame(table(df$request[contains_post]))
reqs
ggplot( data = reqs, aes(x = reqs$Var1, y = reqs$Freq) ) + geom_bar(stat = 'identity', fill = reqs$Freq) + xlab('Put vs POST') + ylab('Count') + ggtitle('Total PUT & POST in URLs')
ggsave("plot_put_post.png", width = 15, height = 15)

