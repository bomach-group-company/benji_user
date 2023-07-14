import 'package:alpha_logistics/app/vendor/vendor%20location.dart';
import 'package:alpha_logistics/providers/constants.dart';
import 'package:alpha_logistics/reusable%20widgets/message%20textformfield.dart';
import 'package:alpha_logistics/reusable%20widgets/my%20elevatedbutton.dart';
import 'package:alpha_logistics/reusable%20widgets/my%20floating%20snackbar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../reusable widgets/custom showSearch.dart';
import '../../reusable widgets/search field.dart';
import '../../theme/colors.dart';
import '../../widgets/category button section.dart';
import '../../widgets/vendors food container.dart';
import '../food/food detail screen.dart';

class Vendor extends StatefulWidget {
  const Vendor({super.key});

  @override
  State<Vendor> createState() => _VendorState();
}

class _VendorState extends State<Vendor> {
  //=================================== ALL VARIABLES ====================================\\
  int selectedRating = 0;

  //TextEditingController
  TextEditingController searchController = TextEditingController();
  TextEditingController rateVendorEC = TextEditingController();

//===================== KEYS =======================\\
  final _formKey = GlobalKey<FormState>();

//===================== FOCUS NODES =======================\\
  FocusNode rateVendorFN = FocusNode();

//===================== BOOL VALUES =======================\\
  bool isLoading = false;
  bool isValidating = false;
//===================== CATEGORY BUTTONS =======================\\
  final List _categoryButtonText = [
    "Pasta",
    "Burgers",
    "Rice Dishes",
    "Chicken",
    "Snacks"
  ];

  final List<Color> _categoryButtonBgColor = [
    kAccentColor,
    Color(
      0xFFF2F2F2,
    ),
    Color(
      0xFFF2F2F2,
    ),
    Color(
      0xFFF2F2F2,
    ),
    Color(
      0xFFF2F2F2,
    )
  ];
  final List<Color> _categoryButtonFontColor = [
    kPrimaryColor,
    Color(
      0xFF828282,
    ),
    Color(
      0xFF828282,
    ),
    Color(
      0xFF828282,
    ),
    Color(
      0xFF828282,
    )
  ];

//===================== VENDORS LIST VIEW INDEX =======================\\
  List<int> foodListView = [0, 1, 3, 4, 5, 6];

//===================== FUNCTIONS =======================\\
  void validate() {
    mySnackBar(
      context,
      "Success!",
      "Thank you for your feedback!",
      Duration(seconds: 1),
    );

    Navigator.of(context).pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.white.withOpacity(
            0.6,
          ),
          elevation: 0.0,
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        "assets/images/food/burgers.png",
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.47,
                left: kDefaultPadding,
                right: kDefaultPadding,
                child: Container(
                  height: MediaQuery.of(context).size.height - 300,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      bottom: kDefaultPadding * 2,
                    ),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SearchField(
                          hintText: "Search here",
                          onTap: () {
                            showSearch(
                              context: context,
                              delegate: CustomSearchDelegate(),
                            );
                          },
                          searchController: searchController,
                        ),
                        kHalfSizedBox,
                        CategoryButtonSection(
                          category: _categoryButtonText,
                          categorybgColor: _categoryButtonBgColor,
                          categoryFontColor: _categoryButtonFontColor,
                        ),
                        Text(
                          _categoryButtonText[0],
                          style: TextStyle(
                            color: Color(
                              0xFF333333,
                            ),
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        for (int i = 0; i < foodListView.length; i++,)
                          VendorFoodContainer(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => FoodDetailScreen(),
                                ),
                              );
                            },
                          ),
                        SizedBox(
                          height: kDefaultPadding * 4,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.04,
                left: kDefaultPadding,
                right: kDefaultPadding,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(context);
                        },
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: ShapeDecoration(
                            color: Color(
                              0xFFFAFAFA,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                19,
                              ),
                            ),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 16,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          rating(
                            (() async {
                              if (_formKey.currentState!.validate()) {
                                validate();
                              }
                            }),
                            "Rate Vendor",
                            context,
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                for (int i = 1; i <= 5; i++)
                                  InkWell(
                                    radius: 10,
                                    splashColor: Colors.amber,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                    onTap: () {
                                      setState(() {
                                        selectedRating = i;
                                      });
                                    },
                                    child: Icon(
                                      Icons.star_rounded,
                                      size: 30,
                                      color: i <= selectedRating
                                          ? Colors.yellow
                                          : Colors.grey,
                                    ),
                                  ),
                              ],
                            ),
                            rateVendorEC,
                            (value) {
                              if (value == null || value.isEmpty) {
                                rateVendorFN.requestFocus();
                                return "Enter a review";
                              }
                              return null;
                            },
                            rateVendorFN,
                            _formKey,
                          );
                        },
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: ShapeDecoration(
                            color: Color(
                              0xFFFAFAFA,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                19,
                              ),
                            ),
                          ),
                          child: Icon(
                            Icons.star_outline_rounded,
                            color: kAccentColor,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.14,
                left: kDefaultPadding,
                right: kDefaultPadding,
                child: Container(
                  width: 200,
                  padding: EdgeInsets.all(kDefaultPadding / 2),
                  decoration: ShapeDecoration(
                    shadows: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                          0.1,
                        ),
                        blurRadius: 5,
                        spreadRadius: 2,
                        blurStyle: BlurStyle.normal,
                      ),
                    ],
                    color: Color(
                      0xFFFEF8F8,
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.50,
                        color: Color(
                          0xFFFDEDED,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(
                        25,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: kDefaultPadding * 2.6,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Ntachi Osa",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(
                              0xFF302F3C,
                            ),
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        kHalfSizedBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_pin,
                              color: kAccentColor,
                              size: 15,
                            ),
                            kHalfWidthSizedBox,
                            Text(
                              "23 Liza street, GRA",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        kHalfSizedBox,
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => VendorLocation(),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: mediaWidth / 4,
                            padding: EdgeInsets.all(kDefaultPadding / 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: kAccentColor,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              "Show on map",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        kHalfSizedBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 102,
                              height: 56.67,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    19,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.access_time_outlined,
                                    color: kAccentColor,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "30 mins",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.28,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 102,
                              height: 56.67,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    19,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star_rounded,
                                    color: HexColor(
                                      "#FF6838",
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "4.8",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.28,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 102,
                              height: 56.67,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    19,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Open',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(
                                        0xFF189D60,
                                      ),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.36,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.info_outline,
                                    color: kAccentColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.08,
                left: MediaQuery.of(context).size.width / 2.7,
                child: Container(
                  width: 107,
                  height: 107,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/vendors/ntachi-osa-logo.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        43.50,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void setState(Null Function() param0) {}

rating(
  Function() onPressed,
  String title,
  BuildContext context,
  Widget rowWidget,
  TextEditingController controller,
  FormFieldValidator validator,
  FocusNode focusNode,
  GlobalKey formKey,
) {
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setStateForDialog) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(kDefaultPadding)),
            ),
            scrollable: true,
            shadowColor: kBlackColor.withOpacity(0.9),
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop(context);
                },
                splashRadius: 20,
                icon: Icon(
                  Icons.close_rounded,
                  color: kAccentColor,
                ),
              ),
            ],
            contentPadding: EdgeInsets.all(kDefaultPadding),
            content: Form(
              key: formKey,
              child: Column(
                children: [
                  rowWidget,
                  kSizedBox,
                  MyMessageTextFormField(
                    controller: controller,
                    validator: validator,
                    textInputAction: TextInputAction.newline,
                    focusNode: focusNode,
                    hintText: "Enter your review",
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                  ),
                  kSizedBox,
                  MyElevatedButton(
                    title: "Send",
                    onPressed: onPressed,
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
