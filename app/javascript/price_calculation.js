document.addEventListener('DOMContentLoaded', function() {
  const inputPrice = document.getElementById('item-price');
  const addTaxPrice = document.getElementById('add-tax-price');
  const profitPrice = document.getElementById('profit');
  const tax = 0.1
  
  // 販売手数料及び利益を計算
  inputPrice.addEventListener('keyup', () => {
    const itemPrice = Number(inputPrice.value);
    const taxPrice = itemPrice * tax;
    const profit = itemPrice - taxPrice;
    addTaxPrice.innerHTML = Math.floor(taxPrice);
    profitPrice.innerHTML = Math.floor(profit);
  })
})
