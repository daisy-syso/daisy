angular.module("DaisyApp").filter 'otcLogo', () ->
  return (num) ->
    switch num 
    	when 1
    		"otc"
    	when 2
    		"otc"
    	when 3
    		"RX"