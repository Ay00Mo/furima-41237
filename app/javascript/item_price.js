
const price = () => {

  const priceInput = document.getElementById("item-price");
  const salesCommission = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  priceInput.addEventListener("input", () => {
    const inputValue = Number(priceInput.value);
    const commissionValue = Math.floor(inputValue * 0.10);
    const profitValue = Math.floor(inputValue - commissionValue);
    
    salesCommission.innerHTML = commissionValue.toString();
    profit.innerHTML = profitValue.toString();
  });
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);
