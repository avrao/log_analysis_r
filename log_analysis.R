library(ggplot2)

df = read.table('access.log')
head(df)
colnames(df) = c('ip_address', 'nameless_v2', 'nameless_v3', 'date', 'nameless_v5', 'request', 'status', 'bytes', 'url', 'browser_specs')
df$date = as.Date(df$date, "[%d/%b/%Y")
#df$time = as.Date(df$time, ":h:m:s")
# head(df[["date"]])
# head(df[["status"]])
# head(df)
# str(df)
#print(names(df))
print(table(df$date))
reqs = as.data.frame(table(df$date))
print(reqs)

ggplot(data = reqs, aes(x = as.Date(reqs[['Var1']]), y = reqs[['Freq']]) ) + geom_line() + xlab('Date') + ylab('Requests')

ggplot( data = df, aes(x = format(df$status)) ) + geom_bar() + xlab('Status') + ylab('Count')

