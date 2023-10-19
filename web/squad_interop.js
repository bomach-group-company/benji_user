async function SquadPay(onClose, onLoad, onSuccess, key, email, amount, currencycode, customername, metadata) {
  const squadInstance = new squad({
    onClose: onClose,
    onLoad: onLoad,
    onSuccess: onSuccess,
    key: key,
    email: email,
    amount: amount,
    currency_code: currencycode,
    customer_name: customername,
    pass_charge: true,
    metadata: metadata,
  });
  squadInstance.setup();
  squadInstance.open();
}