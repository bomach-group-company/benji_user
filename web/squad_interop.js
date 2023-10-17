async function SquadPay(onClose, onLoad, onSuccess, key, email, amount, currencycode, customername) {
  const squadInstance = new squad({
    onClose: onClose,
    onLoad: onLoad,
    onSuccess: onSuccess,
    key: key,
    email: email,
    amount: amount,
    currency_code: currencycode,
    customer_name: customername,
    // pass_charge: true,
  });
  await squadInstance.setup();
  await squadInstance.open();
  console.dir(squadInstance.data);
  console.dir(squadInstance.message);
  return await squadInstance;
}