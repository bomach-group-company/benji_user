import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../src/providers/constants.dart';
import '../../src/common_widgets/my appbar.dart';
import '../../src/common_widgets/my intl phonefield.dart';
import '../../src/common_widgets/my textformfield.dart';
import '../../theme/colors.dart';
import 'choose rider.dart';
import 'itemCategoryDropDownMenu.dart';

class SendPackage extends StatefulWidget {
  const SendPackage({super.key});

  @override
  State<SendPackage> createState() => _SendPackageState();
}

class _SendPackageState extends State<SendPackage> {
  //=============================== ALL VARIABLES ==================================\\
  int _currentStep = 0;
  bool _nextPage = false;
  bool _continuePage = false;
  get mediaWidth => MediaQuery.of(context).size.width;

  //=============================== CONTROLLERS ==================================\\

  var _formKey = GlobalKey<FormState>();

  //=============================== CONTROLLERS ==================================\\
  var pickupEC = TextEditingController();
  var senderNameEC = TextEditingController();
  var senderPhoneEC = TextEditingController();
  var dropOffEC = TextEditingController();
  var receiverNameEC = TextEditingController();
  var receiverPhoneEC = TextEditingController();
  var itemNameEC = TextEditingController();
  var itemCategoryEC = TextEditingController();
  var itemWeightEC = TextEditingController();
  var itemQuantityEC = TextEditingController();
  var itemValueEC = TextEditingController();

  //=============================== FOCUS NODES ==================================\\
  var pickupFN = FocusNode();
  var senderNameFN = FocusNode();
  var senderPhoneFN = FocusNode();
  var dropOffFN = FocusNode();
  var receiverNameFN = FocusNode();
  var receiverPhoneFN = FocusNode();
  var itemNameFN = FocusNode();
  var itemQuantityFN = FocusNode();
  var itemValueFN = FocusNode();

  //=============================== FUNCTIONS ==================================\\
  continueStep() {
    if (_currentStep < 2) {
      setState(() {
        _nextPage = true;
        _currentStep = _currentStep + 1;
      });
    }
    if (_currentStep == 2) {
      setState(() {
        _nextPage = true;
        _continuePage = true;
      });
    }
  }

  cancelStep() {
    if (_currentStep < 2) {
      setState(() {
        _nextPage = false;
      });
    }

    if (_currentStep > 0) {
      setState(() {
        _currentStep = _currentStep - 1;
        _continuePage = false;
      });
    }
  }

  onStepTapped(int value) {
    setState(() {
      _currentStep = value;
    });
  }

  //=============================== WIDGETS ==================================\\

  // Widget stepIconBuilder(context, details) {
  //   return Icon(
  //     Icons.check,
  //     color: kPrimaryColor,
  //     size: 15,
  //   );
  // }

  Widget controlsBuilder(context, details) {
    return _nextPage == false
        ? ElevatedButton(
            onPressed: details.onStepContinue,
            child: Text("Next"),
            style: ElevatedButton.styleFrom(
              backgroundColor: kAccentColor,
              elevation: 10.0,
              fixedSize: Size(MediaQuery.of(context).size.width / 1.2, 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          )
        : _continuePage == true
            ? Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ChooseRider(),
                        ),
                      );
                    },
                    child: Text("Continue"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kAccentColor,
                      elevation: 10.0,
                      fixedSize:
                          Size(MediaQuery.of(context).size.width / 1.9, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  kWidthSizedBox,
                  OutlinedButton(
                    onPressed: details.onStepCancel,
                    child: Text(
                      "Back",
                      style: TextStyle(color: kAccentColor),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      elevation: 10.0,
                      side: BorderSide(color: kAccentColor, width: 1.2),
                      fixedSize:
                          Size(MediaQuery.of(context).size.width / 5, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              )
            : Row(
                children: [
                  ElevatedButton(
                    onPressed: details.onStepContinue,
                    child: Text("Next"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kAccentColor,
                      elevation: 10.0,
                      fixedSize:
                          Size(MediaQuery.of(context).size.width / 1.9, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  kWidthSizedBox,
                  OutlinedButton(
                    onPressed: details.onStepCancel,
                    child: Text(
                      "Back",
                      style: TextStyle(color: kAccentColor),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      elevation: 10.0,
                      side: BorderSide(color: kAccentColor, width: 1.2),
                      fixedSize:
                          Size(MediaQuery.of(context).size.width / 5, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              );
  }

  List<Step> steps() => [
        Step(
          subtitle: Text("details"),
          isActive: _currentStep >= 0,
          state: _currentStep > 0 ? StepState.complete : StepState.indexed,
          title: Text(
            "Sender's",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          content: Column(
            // mainAxisAlignment: MainAxis,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pickup Address",
                style: TextStyle(
                  fontSize: 17.6,
                  fontWeight: FontWeight.w400,
                ),
              ),
              kHalfSizedBox,
              MyTextFormField(
                controller: pickupEC,
                validator: (value) {
                  RegExp pickupAddress = RegExp(r'^\d+\s+[a-zA-Z0-9\s.-]+$');
                  if (value!.isEmpty || value == null) {
                    pickupFN.requestFocus();
                    return "Enter pickup location";
                  } else if (!pickupAddress.hasMatch(value)) {
                    pickupFN.requestFocus();
                    return "Enter a valid address (must have a street number)";
                  }
                  return null;
                },
                onSaved: (value) {
                  pickupEC.text = value;
                },
                textInputAction: TextInputAction.next,
                focusNode: pickupFN,
                hintText: "E.g 123, Main Street",
                textInputType: TextInputType.streetAddress,
              ),
              kHalfSizedBox,
              Text(
                "Sender's Name",
                style: TextStyle(
                  fontSize: 17.6,
                  fontWeight: FontWeight.w400,
                ),
              ),
              kHalfSizedBox,
              MyTextFormField(
                controller: senderNameEC,
                validator: (value) {
                  RegExp userNamePattern = RegExp(
                    r'^.{3,}$', //Min. of 3 characters
                  );
                  if (value == null || value!.isEmpty) {
                    senderNameFN.requestFocus();
                    return "Enter your name";
                  } else if (!userNamePattern.hasMatch(value)) {
                    senderNameFN.requestFocus();
                    return "Name must be at least 3 characters";
                  }
                  return null;
                },
                onSaved: (value) {
                  senderNameEC.text = value;
                },
                textInputAction: TextInputAction.done,
                focusNode: senderNameFN,
                hintText: "Enter your name",
                textInputType: TextInputType.name,
              ),
              kHalfSizedBox,
              Text(
                "Phone Number",
                style: TextStyle(
                  fontSize: 17.6,
                  fontWeight: FontWeight.w400,
                ),
              ),
              kHalfSizedBox,
              MyIntlPhoneField(
                initialCountryCode: "NG",
                invalidNumberMessage: "Invalid phone number",
                dropdownIconPosition: IconPosition.trailing,
                showCountryFlag: true,
                showDropdownIcon: true,
                dropdownIcon: Icon(
                  Icons.arrow_drop_down_rounded,
                  color: kAccentColor,
                ),
                controller: senderPhoneEC,
                textInputAction: TextInputAction.done,
                focusNode: senderPhoneFN,
                validator: (value) {
                  if (value == null || value!.isEmpty) {
                    senderPhoneFN.requestFocus();
                    return "Enter your phone number";
                  }
                  return null;
                },
                onSaved: (value) {
                  senderPhoneEC.text = value;
                },
              ),
              kSizedBox,
            ],
          ),
        ),
        Step(
          subtitle: Text("details"),
          isActive: _currentStep >= 1,
          state: _currentStep > 1 ? StepState.complete : StepState.indexed,
          title: Text(
            "Receiver's",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          content: Column(
            // mainAxisAlignment: MainAxis,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Drop-off Address",
                style: TextStyle(
                  fontSize: 17.6,
                  fontWeight: FontWeight.w400,
                ),
              ),
              kHalfSizedBox,
              MyTextFormField(
                controller: dropOffEC,
                validator: (value) {
                  RegExp dropOffAddress = RegExp(r'^\d+\s+[a-zA-Z0-9\s.-]+$');
                  if (value.isEmpty || value == null) {
                    dropOffFN.requestFocus();
                    return "Enter drop-off address";
                  } else if (!dropOffAddress.hasMatch(value)) {
                    dropOffFN.requestFocus();
                    return "Enter a valid address (must have a street number)";
                  }
                  return null;
                },
                onSaved: (value) {
                  dropOffEC.text = value;
                },
                textInputAction: TextInputAction.next,
                focusNode: dropOffFN,
                hintText: "E.g 123, Main Street",
                textInputType: TextInputType.streetAddress,
              ),
              kHalfSizedBox,
              Text(
                "Receiver's Name",
                style: TextStyle(
                  fontSize: 17.6,
                  fontWeight: FontWeight.w400,
                ),
              ),
              kHalfSizedBox,
              MyTextFormField(
                controller: receiverNameEC,
                validator: (value) {
                  RegExp userNamePattern = RegExp(
                    r'^.{3,}$', //Min. of 3 characters
                  );
                  if (value == null || value!.isEmpty) {
                    receiverNameFN.requestFocus();
                    return "Enter receiver's name";
                  } else if (!userNamePattern.hasMatch(value)) {
                    receiverNameFN.requestFocus();
                    return "Name must be at least 3 characters";
                  }
                  return null;
                },
                onSaved: (value) {
                  receiverNameEC.text = value;
                },
                textInputAction: TextInputAction.done,
                focusNode: receiverNameFN,
                hintText: "Enter receiver's name",
                textInputType: TextInputType.name,
              ),
              kHalfSizedBox,
              Text(
                "Phone Number",
                style: TextStyle(
                  fontSize: 17.6,
                  fontWeight: FontWeight.w400,
                ),
              ),
              kHalfSizedBox,
              MyIntlPhoneField(
                initialCountryCode: "NG",
                invalidNumberMessage: "Invalid phone number",
                dropdownIconPosition: IconPosition.trailing,
                showCountryFlag: true,
                showDropdownIcon: true,
                dropdownIcon: Icon(
                  Icons.arrow_drop_down_rounded,
                  color: kAccentColor,
                ),
                controller: receiverPhoneEC,
                textInputAction: TextInputAction.done,
                focusNode: receiverPhoneFN,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      receiverPhoneEC.text.isEmpty) {
                    receiverPhoneFN.requestFocus();
                    return "Enter receiver's phone number";
                  }
                  return null;
                },
                onSaved: (value) {
                  receiverPhoneEC.text = value;
                },
              ),
              kSizedBox,
            ],
          ),
        ),
        Step(
          subtitle: Text("details"),
          isActive: _currentStep >= 2,
          state: _currentStep > 2 ? StepState.complete : StepState.indexed,
          title: Text(
            "Item",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Item Name",
                style: TextStyle(
                  fontSize: 17.6,
                  fontWeight: FontWeight.w400,
                ),
              ),
              kHalfSizedBox,
              MyTextFormField(
                controller: itemNameEC,
                validator: (value) {
                  RegExp userNamePattern = RegExp(
                    r'^.{3,}$', //Min. of 3 characters
                  );
                  if (value == null || value!.isEmpty) {
                    itemNameFN.requestFocus();
                    return "Enter the item's name";
                  } else if (!userNamePattern.hasMatch(value)) {
                    itemNameFN.requestFocus();
                    return "Name must be at least 3 characters";
                  }
                  return null;
                },
                onSaved: (value) {
                  itemNameEC.text = value;
                },
                textInputAction: TextInputAction.next,
                focusNode: itemNameFN,
                hintText: "Enter the name of the item",
                textInputType: TextInputType.name,
              ),
              kHalfSizedBox,
              Text(
                "Item Category",
                style: TextStyle(
                  fontSize: 17.6,
                  fontWeight: FontWeight.w400,
                ),
              ),
              kHalfSizedBox,
              ItemDropDownMenu(
                itemEC: itemCategoryEC,
                mediaWidth: mediaWidth,
                hintText: "Choose category",
                dropdownMenuEntries2: <DropdownMenuEntry<String>>[
                  DropdownMenuEntry(value: "Clothes", label: "Furnitures"),
                  DropdownMenuEntry(value: "Drinks", label: "Drinks"),
                  DropdownMenuEntry(value: "Electronics", label: "Electronics"),
                  DropdownMenuEntry(value: "Fabrics", label: "Fabrics"),
                  DropdownMenuEntry(value: "Food", label: "Food"),
                  DropdownMenuEntry(value: "Furnitures", label: "Furnitures"),
                  DropdownMenuEntry(value: "Groceries", label: "Groceries"),
                ],
              ),
              kSizedBox,
              Text(
                "Item Weight",
                style: TextStyle(
                  fontSize: 17.6,
                  fontWeight: FontWeight.w400,
                ),
              ),
              kHalfSizedBox,
              ItemDropDownMenu(
                itemEC: itemWeightEC,
                mediaWidth: mediaWidth,
                hintText: "Choose weight",
                dropdownMenuEntries2: <DropdownMenuEntry<String>>[
                  DropdownMenuEntry(value: "1", label: "Less than 1 KG"),
                  DropdownMenuEntry(value: "2", label: "Less than 2 KG"),
                  DropdownMenuEntry(value: "3", label: "Less than 3 KG"),
                  DropdownMenuEntry(value: "4", label: "Less than 4 KG"),
                  DropdownMenuEntry(value: "5", label: "Less than 5 KG"),
                ],
              ),
              kSizedBox,
              Text(
                "Item Quantity",
                style: TextStyle(
                  fontSize: 17.6,
                  fontWeight: FontWeight.w400,
                ),
              ),
              kHalfSizedBox,
              MyTextFormField(
                controller: itemQuantityEC,
                validator: (value) {
                  if (value == null || value!.isEmpty) {
                    itemQuantityFN.requestFocus();
                    return "Enter the item's quantity";
                  }
                  return null;
                },
                onSaved: (value) {
                  itemQuantityEC.text = value;
                },
                textInputAction: TextInputAction.next,
                focusNode: itemQuantityFN,
                hintText: "Enter the quantity ",
                textInputType: TextInputType.number,
              ),
              kSizedBox,
              Text(
                "Item Value",
                style: TextStyle(
                  fontSize: 17.6,
                  fontWeight: FontWeight.w400,
                ),
              ),
              kHalfSizedBox,
              MyTextFormField(
                controller: itemValueEC,
                validator: (value) {
                  if (value == null || value!.isEmpty) {
                    itemValueFN.requestFocus();
                    return "Enter the item's value";
                  }
                  return null;
                },
                onSaved: (value) {
                  itemValueEC.text = value;
                },
                textInputAction: TextInputAction.done,
                focusNode: itemValueFN,
                hintText: "Enter the value",
                textInputType: TextInputType.number,
              ),
              kSizedBox,
              InkWell(
                borderRadius: BorderRadius.circular(16),
                splashColor: Colors.blue.shade50,
                focusColor: Colors.blue.shade50,
                highlightColor: Colors.blue.shade50,
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 144,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        style: BorderStyle.solid,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: Color(
                          0xFFE6E6E6,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cloud_upload),
                        // Image.asset(
                        //   "assets/images/icons/image-upload.png",
                        // ),
                        kHalfSizedBox,
                        const Text(
                          'Upload an image of the item',
                          style: TextStyle(
                            color: Color(
                              0xFF808080,
                            ),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              kSizedBox,
            ],
          ),
        ),
      ];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: MyAppBar(
          title: "Send Package",
          elevation: 0.0,
          actions: [],
          backgroundColor: kPrimaryColor,
          toolbarHeight: kToolbarHeight,
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Container(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Form(
              key: _formKey,
              child: Stepper(
                physics: BouncingScrollPhysics(),
                margin: EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                ),
                currentStep: _currentStep,
                onStepContinue: continueStep,
                onStepCancel: cancelStep,
                onStepTapped: onStepTapped,
                controlsBuilder: controlsBuilder,
                elevation: 0.0,
                // stepIconBuilder: stepIconBuilder,
                type: StepperType.horizontal,
                steps: steps(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
