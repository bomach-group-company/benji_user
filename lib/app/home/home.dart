import 'package:alpha_logistics/app/send%20package/send%20package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../providers/constants.dart';
import '../../reusable widgets/custom showSearch.dart';
import '../../reusable widgets/my floating snackbar.dart';
import '../../reusable widgets/see all container.dart';
import '../../theme/colors.dart';
import '../../widgets/appBar delivery location.dart';
import '../../widgets/category button section.dart';
import '../../widgets/home hot deals.dart';
import '../../widgets/home popular vendors card.dart';
import '../../widgets/homepage vendors.dart';
import '../address/address.dart';
import '../cart/cart.dart';
import '../orders/order history.dart';
import '../profile/edit profile.dart';
import '../screens/login.dart';
import 'home drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //============================= ALL VARIABLES =====================================\\

  //===================== TEXTEDITING CONTROLLER =======================\\
  TextEditingController searchController = TextEditingController();

  //===================== CATEGORY BUTTONS =======================\\
  final List _categoryButton = [
    "Food",
    "Drinks",
    "Groceries",
    "Pharmaceuticals",
    "Snacks",
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
    ),
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
    ),
  ];

//===================== POPULAR VENDORS =======================\\
  final List<int> popularVendorsIndex = [
    0,
    1,
    2,
    3,
    4,
  ];

  final List<String> popularVendorImage = [
    "best-choice-restaurant.png",
    "golden-toast.png",
    "best-choice-restaurant.png",
    "best-choice-restaurant.png",
    "best-choice-restaurant.png",
  ];
  final List<dynamic> popularVendorBannerColor = [
    kAccentColor,
    Color(
      0x00000000,
    ),
    kAccentColor,
    kAccentColor,
    kAccentColor,
  ];
  final List<dynamic> popularVendorBannerText = [
    "Free Delivery",
    "",
    "Free Delivery",
    "Free Delivery",
    "Free Delivery",
  ];

  final List<String> popularVendorName = [
    "Best Choice restaurant",
    "Golden Toast",
    "Best Choice restaurant",
    "Best Choice restaurant",
    "Best Choice restaurant",
  ];

  final List<String> popularVendorFood = [
    "Food",
    "Traditional",
    "Food",
    "Food",
    "Food",
  ];

  final List<String> popularVendorCategory = [
    "Fast Food",
    "Continental",
    "Fast Food",
    "Fast Food",
    "Fast Food",
  ];
  final List<String> popularVendorRating = [
    "3.6",
    "3.6",
    "3.6",
    "3.6",
    "3.6",
  ];
  final List<String> popularVendorNoOfUsersRating = [
    "500",
    "500",
    "500",
    "500",
    "500",
  ];

  //===================== COPY TO CLIPBOARD =======================\\
  final String userID = 'ID: 337890-AZQ';
  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(
      ClipboardData(
        text: userID,
      ),
    );

    //===================== SNACK BAR =======================\\

    mySnackBar(
      context,
      "Success!",
      "Copied to clipboard",
      Duration(
        seconds: 2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        drawer: HomeDrawer(
          userID: userID,
          toEditProfilePage: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditProfile(),
              ),
            );
          },
          copyUserIdToClipBoard: () {
            _copyToClipboard(
              context,
            );
          },
          toAddressesPage: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Addresses(),
              ),
            );
          },
          toSendPackagePage: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SendPackage(),
              ),
            );
          },
          toFavoritesPage: () {},
          toInvitesPage: () {},
          toOrdersPage: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => OrdersHistory(),
              ),
            );
          },
          logOut: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Login(),
              ),
            );
          },
        ),
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          automaticallyImplyLeading: false,
          titleSpacing: kDefaultPadding / 2,
          elevation: 0.0,
          title: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding / 2,
                ),
                child: Builder(
                  builder: (context) => IconButton(
                    splashRadius: 20,
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Image.asset(
                      "assets/images/icons/drawer-icon.png",
                    ),
                  ),
                ),
              ),
              AppBarDeliveryLocation(
                deliveryLocation: 'Achara Layout, Enugu',
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
              },
              icon: Icon(
                Icons.search_rounded,
                color: kAccentColor,
              ),
            ),
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Cart(),
                      ),
                    );
                  },
                  splashRadius: 20,
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: kAccentColor,
                  ),
                ),
                Positioned(
                  top: 2,
                  right: 10,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: ShapeDecoration(
                      color: kAccentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "10+",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Container(
            color: kPrimaryColor,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(
              kDefaultPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kHalfSizedBox,
                CategoryButtonSection(
                  category: _categoryButton,
                  categorybgColor: _categoryButtonBgColor,
                  categoryFontColor: _categoryButtonFontColor,
                ),
                SizedBox(height: 8),
                Flexible(
                  fit: FlexFit.loose,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: [
                      SeeAllContainer(
                        title: "Vendors Near you",
                        onPressed: () {},
                      ),
                      kSizedBox,
                      HomePageVendorsCard(),
                      SizedBox(
                        height: kDefaultPadding * 2,
                      ),
                      SeeAllContainer(
                        title: "Popular Vendors",
                        onPressed: () {},
                      ),
                      kSizedBox,
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int i = 0;
                                i < popularVendorsIndex.length;
                                i++,)
                              PopularVendorsCard(
                                onTap: () {},
                                cardImage: popularVendorImage[i],
                                bannerColor: popularVendorBannerColor[i],
                                bannerText: popularVendorBannerText[i],
                                vendorName: popularVendorName[i],
                                food: popularVendorFood[i],
                                category: popularVendorCategory[i],
                                rating: popularVendorRating[i],
                                noOfUsersRated: popularVendorNoOfUsersRating[i],
                              ),
                          ],
                        ),
                      ),
                      kSizedBox,
                      Text(
                        'Hot Deals',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.40,
                        ),
                      ),
                      kSizedBox,
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int i = 0; i < 5; i++,) HomeHotDeals(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
