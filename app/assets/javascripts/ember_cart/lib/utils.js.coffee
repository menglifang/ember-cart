window.round = (number, fractionDigits) ->
  return (Math.round(number * Math.pow(10, fractionDigits)) / Math.pow(10, fractionDigits)).toFixed(fractionDigits);
