import 'package:benji/app/home/home.dart';
import 'package:benji/src/common_widgets/appbar/my_appbar.dart';
import 'package:benji/src/frontend/widget/section/breadcrumb.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';

import '../../src/frontend/utils/constant.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class FAQs extends StatefulWidget {
  const FAQs({super.key});

  @override
  State<FAQs> createState() => _FAQsState();
}

class _FAQsState extends State<FAQs> {
  List items = [
    [
      'What is Benji?',
      'Benji is an advanced multi-vendor e-commerce and logistics app developed by the renowned Bomach Group in collaboration with Alpha Logistics. It is designed to revolutionize online shopping and seamless delivery of goods, offering a game-changing experience in the e-commerce and logistics industry.',
    ],
    [
      'How does Benji work?',
      'Benji brings together multiple vendors and their products on a single platform, providing users with a wide variety of options. Customers can browse through various products compare prices, and place orders directly through the app. The app advanced logistics system then facilitates efficient delivery of the purchased goods to the customers specified locations.',
    ],
    [
      'What are the key features of Benji?',
      'Benji boasts several innovative features, including a user-friendly interface, a diverse range of products from multiple vendors, real-time product tracking, secure payment options personalized recommendations, and a seamless and efficient delivery network.',
    ],
    [
      'Can I trust the vendors on Benji?',
      'Absolutely! Bomach Group and Alpha Logistics have carefully curated and on-boarded vendors to ensure the highest quality and credibility. Vendors are thoroughly vetted before being allowed to list their products on the platform. Additionally, user reviews and ratings contribute to building a trustworthy and reliable shopping experience.',
    ],
    [
      'What sets Benji apart from other e-commerce apps?',
      'Benji key differentiator lies in its seamless integration of e-commerce and logistics. Unlike traditional e-commerce apps, Benji partnership with Alpha Logistics ensures quick and reliable deliveries, reducing the risk of delays and order mishaps. The app ability to handle multiple vendors also provides users with an extensive selection of products, all in one place.',
    ],
    [
      'Is my payment information safe on Benji?',
      'Absolutely. Benji employs state-of-the-art encryption and security protocols to safeguard your payment information. Your financial data is protected at all times, ensuring a secure and worry-free shopping experience.',
    ],
    [
      'Can I track my order in real-time?',
      'Yes, you can! Benji advanced tracking system allows you to monitor the status of your order in real-time. From the moment your order is placed to its final delivery, you\'ll receive regular updates, ensuring transparency and peace of mind.',
    ],
    [
      'Does Benji offer customer support?',
      'Certainly! Benji provides dedicated customer support to address any queries or concerns you may have. You can reach out to the support team through the app or their website, and we will be more than happy to assist you.',
    ],
    [
      'Are there any membership fees or subscriptions to use Benji?',
      'No, Benji is free to download and use. There are no membership fees or subscriptions required to access the platform. You only pay for the products you purchase and any associated delivery charges.',
    ],
    [
      'What is Alpha Logistics, and how is it related to Benji?',
      'Alpha Logistics is the logistics arm of the Benji app, responsible for handling the efficient and seamless delivery of goods purchased through the e-commerce platform. It works in partnership with the renowned Bomach Group to provide top-notch logistics services',
    ],
    [
      'What types of logistics services does Alpha Logistics offer?',
      'Alpha Logistics offers a wide range of logistics services, including last-mile delivery, order fulfillment, inventory management, warehousing, courier shipping, freight shipping, package tracking, and efficient transportation solutions.',
    ],
    [
      'How reliable is Alpha Logistics\' delivery network?',
      'Alpha Logistics boasts a highly reliable delivery network, designed to ensure timely and secure deliveries. The logistics system is equipped with advanced tracking technology, enabling customers to monitor their orders in real-time.',
    ],
    [
      'What is last-mile delivery, and how does Alpha Logistics handle it?',
      'Last-mile delivery refers to the final leg of the delivery process, from the distribution center to the customer\'s doorstep. Alpha Logistics optimizes last-mile delivery by using efficient routing algorithms and well-trained delivery personnel to ensure quick and accurate deliveries.',
    ],
    [
      'Are there any delivery options for urgent orders?',
      'Yes, Alpha Logistics understands the importance of urgent deliveries. The app offers express delivery options for customers who require their orders to be delivered within a shorter timeframe.',
    ],
    [
      'Do you deliver internationally?',
      'As of now, we primarily focus on domestic deliveries within any regions in Nigeria. However, expansion plans are in the pipeline to cater to international customers in the future.'
    ],
    [
      'How does Alpha Logistics ensure the safety of packages during transit?',
      'Alpha Logistics prioritizes the safety of packages during transit. The logistics team employs secure and robust packaging methods to protect the goods from any damage. Additionally, the delivery personnel handle packages with care to ensure they reach customers in pristine condition.'
    ],
    [
      'Are there any shipping fees for deliveries?',
      'Shipping fees may apply depending on the location and the nature of the order. However, Alpha Logistics strives to keep shipping fees competitive and transparent, with detailed cost breakdowns provided to customers during the checkout process.'
    ],
    [
      'Can I track my package while it\'s in transit?',
      'Absolutely! Alpha Logistics provides real-time package tracking for all orders. Customers can use the tracking feature on the Benji app or website to stay updated on the status of their deliveries.'
    ],
    [
      'What should I do if there\'s an issue with my delivery?',
      'If you encounter any issues with your delivery, you can reach out to Alpha Logistics\' customer support through the Benji app or website. The dedicated support team will promptly assist you in resolving any problems.'
    ],
    [
      "Can I use Benji internationally?",
      "As of now, Benji is available for use locally. However, the app's popularity is steadily growing, and there are plans to expand its reach to serve customers worldwide in the future."
    ],
    [
      "Do you offer Cash on Delivery (COD) as a payment option?",
      "As of now, Alpha Logistics does not offer Cash on Delivery (COD) as a payment option. However, it provides various other secure and convenient payment methods for customers to choose from during the checkout process."
    ],
    [
      "What are the available payment options for orders placed?",
      "Customers can choose from a variety of payment options, including credit/debit cards, digital wallets, internet banking, and other secure online payment methods to complete their orders."
    ],
    [
      "Why is Cash on Delivery (COD) not available as a payment option?",
      "The decision to not offer Cash on Delivery (COD) is based on a strategic choice to streamline the payment process and ensure seamless transactions for both customers and vendors. This helps enhance the overall efficiency of the delivery system."
    ],
    [
      "Are there any additional fees for using the available payment methods?",
      "Alpha Logistics does not charge any additional fees for using the available payment methods. The total order value displayed during the checkout process is the final amount you will be required to pay."
    ],
    [
      "Will I receive confirmation of my delivery?",
      "Yes, once your order is successfully delivered to the specified address, you will receive a confirmation notification. The confirmation may include details such as the date and time of delivery and the recipient's name."
    ],
    [
      "Can I return goods if I am not satisfied with my purchase?",
      "Certainly! You should check our return and refund policy for eligibility and criteria."
    ],
    [
      "What is the return period for products purchased through Benji?",
      "It could vary depending on the type of product. Check our return and refund policy."
    ],
    [
      "How can I initiate a return for a product?",
      "To initiate a return, you can follow the return process provided on the Benji app or website or contact our support team."
    ],
    [
      "What is the refund policy for returned products?",
      "Once your return request is approved, you will be eligible for a refund. The refund will be processed using the same payment method you used to make the purchase. Please note that the refund process may take a few business days to complete, depending on your payment provider's policies."
    ],
    [
      "What if the product I received is damaged or defective?",
      "In the rare case of this occurrence, please contact our customer support immediately. We will guide you through the process of returning the item and ensure that you receive a replacement or a refund."
    ],
    [
      "Are there any products that cannot be returned?",
      "While most products are eligible for returns, certain items may be non-returnable due to hygiene reasons, expiration dates, or other specific conditions. These details are usually outlined in the product description or the vendor's return policy."
    ],
    [
      "Why should I use Benji for online shopping?",
      "Benji offers a seamless and convenient online shopping experience with a vast selection of products from multiple vendors all in one place. You can easily browse through various categories and find the products you need, making it a time-saving and efficient platform for your shopping needs."
    ],
    [
      "What makes Benji different from other e-commerce apps?",
      "Benji stands out with its advanced logistics arm, Alpha Logistics, which ensures reliable and timely deliveries. The collaboration between Bomach Group and Alpha Logistics creates a unique ecosystem that streamlines the entire shopping and delivery process, setting it apart from traditional e-commerce platforms."
    ],
    [
      "Does Benji provide personalized recommendations?",
      "Yes, Benji utilizes advanced algorithms to offer personalized product recommendations based on your browsing and purchase history. This feature helps you discover new and relevant products that match your preferences."
    ],
  ];

  bool _showBackToTopButton = false;
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 400) {
            _showBackToTopButton = true;
          } else {
            _showBackToTopButton = false;
          }
        });
      });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }

//========================= NAVIGAITON ====================\\

  void _toHomePage() => Get.offAll(
        () => const Home(),
        routeName: 'Home',
        duration: const Duration(milliseconds: 1000),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        predicate: (route) => false,
        popGesture: true,
        transition: Transition.cupertinoDialog,
      );
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      drawerScrimColor: kTransparentColor,
      backgroundColor: kPrimaryColor,
      appBar: MyAppBar(
        title: "FAQs",
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _toHomePage,
            icon: FaIcon(
              FontAwesomeIcons.house,
              color: kAccentColor,
              size: deviceType(media.width) > 2 ? 30 : 24,
            ),
          ),
        ],
        backgroundColor: kPrimaryColor,
        toolbarHeight: kToolbarHeight,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Scrollbar(
                controller: _scrollController,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  controller: _scrollController,
                  children: [
                    const MyBreadcrumb(
                      text: 'FAQs',
                      hasBeadcrumb: false,
                    ),
                    kSizedBox,
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: breakPoint(media.width, 25, 50, 50),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: items.map((item) {
                              return Column(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 1,
                                      )
                                    ]),
                                    child: ExpansionTile(
                                      iconColor: Colors.black45,
                                      collapsedBackgroundColor: kPrimaryColor,
                                      backgroundColor: Colors.white30,
                                      title: Text(
                                        item[0],
                                        style: TextStyle(
                                          color: kSecondaryColor,
                                        ),
                                      ),
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: kPrimaryColor,
                                            border: const Border.symmetric(
                                              horizontal: BorderSide(
                                                width: 1,
                                                color: Colors.black12,
                                              ),
                                            ),
                                          ),
                                          padding: const EdgeInsets.all(20),
                                          width: double.infinity,
                                          child: Text(item[1]),
                                        )
                                      ],
                                    ),
                                  ),
                                  kSizedBox,
                                ],
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton(
              onPressed: _scrollToTop,
              mini: deviceType(media.width) > 2 ? false : true,
              backgroundColor: kAccentColor,
              enableFeedback: true,
              mouseCursor: SystemMouseCursors.click,
              tooltip: "Scroll to top",
              hoverColor: kAccentColor,
              hoverElevation: 50.0,
              child: const FaIcon(FontAwesomeIcons.chevronUp, size: 18),
            ),
    );
  }
}
