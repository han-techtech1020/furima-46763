// app/javascript/card.js
const pay = () => {
  const payjp = Payjp(gon.public_key); 
  const elements = payjp.elements();

  elements.create('cardNumber').mount('#number-form');
  elements.create('cardExpiry').mount('#expiry-form');
  elements.create('cardCvc').mount('#cvc-form');

  const form = document.getElementById('charge-form');

  form.addEventListener("submit", (e) => {
    e.preventDefault();

    payjp.createToken(elements).then((response) => {
      if (response.error) {
        alert(response.error.message);
      } else {
        const tokenInput = document.createElement('input');
        tokenInput.setAttribute('type', 'hidden');
        tokenInput.setAttribute('name', 'token');
        tokenInput.setAttribute('value', response.id);
        form.appendChild(tokenInput);

        form.submit();
      }
    });
  });
};

window.addEventListener("turbo:load", pay);