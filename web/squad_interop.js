function SquadPay(onClose, onLoad, onSuccess, key, email, amount, currencycode) {
  const squadInstance = new squad({
    onClose: onClose,
    onLoad: onLoad,
    onSuccess: onSuccess,
    key: key,
    email: email,
    amount: amount,
    currency_code: currencycode
  });
  squadInstance.setup();
  squadInstance.open();

}