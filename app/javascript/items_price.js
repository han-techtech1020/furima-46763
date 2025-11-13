window.addEventListener('turbo:load', function() {
  const priceInput = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  if (priceInput) {
    priceInput.addEventListener("input", () => {
      let value = parseInt(priceInput.value);
      if (!isNaN(value)) {
        const tax = Math.floor(value * 0.1);
        const profitValue = value - tax;
        addTaxPrice.innerHTML = tax;
        profit.innerHTML = profitValue;
      } else {
        addTaxPrice.innerHTML = 0;
        profit.innerHTML = 0;
      }
    });
  }
});