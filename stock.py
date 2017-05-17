#get single stock price
#curl -s 'http://download.finance.yahoo.com/d/quotes.csv?s=anet&f=l1'

#get single stock price with change
#curl -s 'http://download.finance.yahoo.com/d/quotes.csv?s=anet&f=l1c1'

import subprocess

def bash(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE):
    out, err = subprocess.Popen(command, stdout=stdout, stderr=stderr).communicate()
    return (out, err)

#can return empty string if no network connection
def getStockPrice(sym):
    url = 'http://download.finance.yahoo.com/d/quotes.csv?s='+sym+'&f=l1'
    price, err = bash(["curl", "-s", url])
    if price is '':
        exit
    return float(price)

def getStockAndChange(sym):
    url = 'http://download.finance.yahoo.com/d/quotes.csv?s='+sym+'&f=l1c1'
    out, err = bash(["curl", "-s", url])
    if out is '':
        exit
    price, change = out.split(',')
    return price, change[:-1]
    
symbol = "AAPL"
buy = 0
amount = 0
sell = getStockPrice(symbol)
diff = sell - buy
diff*=amount

stock, change = getStockAndChange(symbol)
output = symbol+": $"+stock
if change[0] is '+':
    output += "#[fg=green] "+change+" #[fg=white]"
else: output += "#[fg=red] "+change+" #[fg=white]"
print output

