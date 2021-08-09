const card_pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
  const submit_btn = document.getElementById("button");

  submit_btn.addEventListener("click", (e) =>{
    // 購入ボタンが押下されたときにカード情報をトークン化して送信

    e.preventDefault();

    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    const card_data = {
      number:    formData.get("purchase_history_shipping_address[card_number]"),
      cvc:       formData.get("purchase_history_shipping_address[card_cvc]"),
      exp_month: formData.get("purchase_history_shipping_address[card_exp_month]"),
      exp_year:  `20${formData.get("purchase_history_shipping_address[card_exp_year]")}`
    };
    
    Payjp.createToken(card_data, (status, response) => {
      if (status == 200) {
        const token = response.id;

        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value = ${token} name = 'token' type = "hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }

      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");

      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("load", card_pay)