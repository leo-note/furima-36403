function fee_calculation (){
  
  // 価格の取得
  const itemPrice = document.getElementById("item-price")

  itemPrice.addEventListener('input', function() {
   const price = this.value
   
   // 販売手数料の計算 小数点以下は切り捨て 
   const addTaxPrice = document.getElementById("add-tax-price")
   addTaxPrice.value = Math.floor(price * 0.1)
   // 販売利益の計算
   const profit = document.getElementById("profit")
   profit.value = price - (addTaxPrice.value)

   addTaxPrice.innerHTML = addTaxPrice.value
   profit.innerHTML = profit.value

  })
}

window.addEventListener('load', fee_calculation)