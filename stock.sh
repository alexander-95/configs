#!/bin/bash
symbol="AAPL"
url=https://www.marketwatch.com/investing/stock/$symbol
price=$(curl -s $url | grep '<meta name="price" content="' | cut -d '"' -f4)
diff=$(curl -s $url | grep '<meta name="priceChange" content="' | cut -d '"' -f4)
if [[ "$diff" == *"-"* ]]
then
    diff=$(echo $diff | cut -d '-' -f2)
    echo $symbol': $'$price '#[fg=red]-$'$diff '#[fg=default]'
else
    echo $symbol': $'$price '#[fg=green]$'$diff '#[fg=default]'
fi
