import 'package:benji/src/frontend/widget/responsive/appbar/appbar.dart';
import 'package:benji/src/frontend/widget/section/breadcrumb.dart';
import 'package:benji/src/frontend/widget/section/title_body.dart';
import 'package:flutter/material.dart';

import '../../src/frontend/widget/drawer/drawer.dart';
import '../../src/frontend/widget/section/footer.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  bool _showBackToTopButton = false;

  // scroll controller
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: kTransparentColor,
      backgroundColor: kPrimaryColor,
      appBar: const MyAppbar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                controller: _scrollController,
                children: const [
                  MyBreadcrumb(text: 'Privacy Policy'),
                  kSizedBox,
                  TitleBody(
                      body:
                          'Please read this Privacy Policy carefully as it will help you make informed decisions about sharing your personal  information with us. '),
                  kSizedBox,
                  TitleBody(
                    title: '1. ABOUT THIS NOTICE',
                    body:
                        '''This Privacy Notice offers insights into Benji's practices for gathering and handling your personal data when you browse our website or use our mobile applications. It outlines our procedures for handling your personal information, ensuring its security, and outlines your rights regarding your personal data.''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '2. WHO WE ARE',
                    body:
                        '''Benji is an advanced multi-vendor e-commerce and courier platform developed by the renowned Bomach Group of Company and subsidiaries. It is designed to revolutionize online shopping and seamless delivery of goods, offering a game-changing experience in the e-commerce and logistics industry. Our platform consists of our marketplace, which connects vendors (sellers/suppliers) with users(customers/consumers), our logistics service, which enables the shipment and delivery of packages from vendors (sellers/suppliers) to users(customers/consumers), and our payment service, which facilitates transactions among active users on our platform. This website and/or mobile app is operated by a member of the Bomach Group of company and/or subsidiaries the companies whose collaboration developed Benji. Information on our subsidiaries can be found on Appendix 1. Any personal data provided or collected by Benji is controlled by the subsidiary that the website and/or mobile app relates to.''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '3. THE DATA WE COLLECT ABOUT YOU?',
                    body:
                        '''Personal data encompasses any information that has the potential to directly or indirectly identify a particular individual. We gather your personal data with the intent of offering customized products and services and for the purpose of analyzing and enhancing our offerings continually. We may collect, utilize, retain, and transfer various categories of personal data for marketing and personal data optimization objectives. Additionally, Benji employs Google Digital Marketing to present tailored offers related to specific products and services to our customers. When you register your personal information on our website and mobile platforms and engage in transactions, you are supplying us with your personal data. We gather various forms of personal information, which encompass: (A) THE INFORMATION YOU DIRECTLY PROVIDE TO US: The information you furnish to us encompasses your identity data, contact data, biometric data, delivery address, and financial data. This category of personal information may encompass the following: i. contact details (such as your name, postal addresses, phone numbers and email addresses), ii. demographic information (such as your location, date of birth, age or age range and gender), iii. online registration information (such as your password and other authentication information), iv. payment information (such as your credit card information and billing address), v. information provided as part of online questionnaires (such as responses to any customer satisfaction surveys or market research), vi. competition entries/submissions, and vii. in certain cases, your marketing preferences.''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title:
                        'B) INFORMATION WE AUTOMATICALLY COLLECT/GENERATE OR OBTAIN FROM THIRD PARTIES:',
                    body:
                        '''We automatically gather and retain specific types of data concerning your utilization of the Benji marketplace, encompassing details about your searches, views, downloads, and purchases. Furthermore, we may receive information about you from third-party sources, including our carriers, payment service providers, merchants/brands, and advertising service providers. These categories of personal data may pertain to your device (such as your PC, tablet, or other mobile device), your interactions with our websites and apps (as well as select third-party websites with which we have collaborated), and/or your individual preferences, interests, or geographical location. Instances of such information include: i. name and age (or predicted age range), ii. information about your device, operating system, browser and IP address, iii. unique identifiers associated with your device, iv. details of web pages that you have visited, v. which products you have looked at online (including information about products you have searched for or viewed, purchased or added to an online shopping basket), vi. how long you spend on certain areas of a website or app together with the date and time of your visit/usage, vii. personal data contained within user-generated content (such as blogs and social media postings), viii. social media user name or ID, and ix. social media profile photo and other social media profile information (such as number of followers).''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title:
                        'We are committed to offering you choices regarding the Personal Data you share with us.',
                    body:
                        '''Where applicable by law, if you desire to have Benji utilize your Personal Data for the purpose of delivering a tailored experience, targeted advertising, and content, you can indicate your preference by selecting the relevant tick-box(es) on the registration form or by responding to questions posed by Benji representatives. Should you decide that you no longer wish to enjoy this level of personalization, you have the option to opt-out or modify your preferences at any time. You can accomplish this by either closing your account or by sending an email to support@benjiexpress.com. To close your account, simply click on this link and follow the provided instructions. Please be aware that once your account is closed, you will lose access to all products and services associated with your account.''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '4. CONSENT',
                    body:
                        '''By using this site, you have consented to our Privacy Policy and that you have the legal capacity to give consent. Otherwise, you may discontinue and log out at this stage.''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '5. COOKIES AND OTHER IDENTIFIERS',
                    body:
                        '''A cookie is a small file containing letters and numbers that we may place on your computer, mobile phone, or tablet if you provide consent. Cookies enable us to differentiate you from other visitors to our website and mobile applications, contributing to an improved browsing experience. For comprehensive details about cookies and their usage by us, please refer to our Cookie Notice''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '6. HOW WE USE YOUR PERSONAL DATA',
                    body:
                        '''We use your personal data to operate, provide, develop and improve the products and services that we offer, including the following: i. Registering you as a new customer. ii. Processing and delivering your orders. iii. Managing your relationship with us. iv. Enabling you to participate in promotions, competitions and surveys. v. Improving our website, applications, products and services. vi. Recommending/advertising products or services which may be of interest to you. vii. Enabling you to access certain products and services offered by our partners and vendors. viii. Complying with our legal obligations, including verifying your identity where necessary. ix. Detecting fraud.''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '7. LEGAL BASIS FOR THE PROCESSING OF PERSONAL DATA',
                    body:
                        '''We will only handle your personal data when a lawful basis exists to do so. The selection of the legal basis is contingent on the objectives for which we have gathered and employed your personal data. In nearly all instances, the legal basis will fall under one of the following categories i. Consent: This includes instances where you have given your explicit permission to receive specific marketing communications from us. You have the option to revoke your consent at any time, which can be done, for example, by clicking the "unsubscribe" link found at the bottom of any marketing email we send you. ii. Our Legitimate Business Interests: We may rely on our legitimate business interests as a basis for processing your data when it is essential for us to understand our customers, promote our services, and operate efficiently. It's important to note that we carry out these activities in a lawful manner, ensuring that your privacy and other rights are not unreasonably impacted. iii. Performance of a Contract with You: This applies when we need to fulfill our obligations under a contract with you or take necessary steps prior to entering into such a contract. For instance, if you've made a purchase from us, we may need to use your contact information and payment details to process your order and deliver the product to you. iv. Compliance with the Law: In situations where we are bound by legal obligations and must use your personal data to adhere to those obligations, we will do so in compliance with the law.''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '8. HOW WE SHARE YOUR PERSONAL DATA',
                    body:
                        '''A. We may need to share your personal data with third parties for the following purposes: 1. Sale of products and services: In order to deliver products and services purchased on our marketplace from third parties, we may be required to provide your personal data to such third parties. 2. Working with third party service providers: We engage third parties to perform certain functions on our behalf. Examples include fulfilling orders for products or services, delivering packages, analyzing data, providing marketing assistance, processing payments, transmitting content, assessing and managing credit risk, and providing customer service. 3. Business transfers: As we continue to develop our business, we might sell or buy other businesses or services. In such transactions, customer information may be transferred together with other business assets. 4. Detecting fraud and abuse: We release account and other personal data to other companies and organizations for fraud protection and credit risk reduction, and to comply with applicable law. B. When we share your personal data with third parties, we: 1. require them to agree to use your data in accordance with the terms of this Privacy Notice, our Privacy Policy and in accordance with applicable law; and 2. only permit them to process your personal data for specified purposes and in accordance with our instructions. We do not allow our third-party service providers to use your personal data for their own purposes.''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '8. INTERNATIONAL TRANSFERS',
                    body:
                        '''We may transfer your personal data to locations in another country, provided such transfers are in accordance with the applicable laws in your jurisdiction. It's important to note that there are inherent risks associated with such transfers. In cases of international transfers involving your personal data, we will implement necessary safeguards to safeguard your data and maintain a level of protection equivalent to that provided in the country where the data originated. We remain committed to upholding your legal rights as outlined in this Privacy Notice and in accordance with the relevant laws in your location.''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '9. DATA RETENTION',
                    body:
                        '''We are committed to taking all reasonable measures to ensure that your personal data is processed for the shortest necessary duration in line with the purposes outlined in this Privacy Notice. Your personal data may be preserved in an identifiable format for as long as A. We maintain an ongoing relationship with you to enhance your overall experience with our services and to ensure that you continue to receive communications from us. B. Your Personal Data is essential for the purposes outlined in this Privacy Notice, and we possess a valid legal basis for its processing. C. We will retain your data for the duration of any applicable limitation period, which refers to the period during which legal claims against us could potentially be brought. We actively monitor the personal data we hold and securely delete it, or in some cases, anonymize it, when it is no longer required for legal, business, or consumer purposes.''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '10. DATA SECURITY',
                    body:
                        '''We have implemented comprehensive security measures designed to prevent the accidental loss, unauthorized access, misuse, alteration, or disclosure of your personal data. Furthermore, access to your personal data is restricted to individuals such as employees, agents, contractors, and other third parties who have a legitimate business need to access it. These individuals will only process your personal data based on our explicit instructions and are bound by strict confidentiality obligations. In the event of any suspected personal data breach, we have established protocols to address such situations. We will promptly inform you and, where legally mandated, notify the relevant regulatory authorities of any breaches.''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '11. YOUR LEGAL RIGHTS',
                    body:
                        '''A. Maintaining the accuracy and currency of the personal data we hold about you is crucial. Please inform us promptly if there are any changes to your personal data during your engagement with us. B. You have specific rights under data protection laws concerning your personal data, including the right to access, rectify, or erase your personal data, object to or restrict its processing, request the transfer of your personal data to a third party, and unsubscribe from our emails and newsletters. C. Should you wish to permanently remove your data from our website and other applications, you can opt to close your account. To initiate this process, please click on this link and follow the provided instructions. Once your account is closed, you will no longer have access to the products and services associated with it. D. We reserve the right to decline your request if it is deemed unreasonable or if you have not provided the necessary additional information to verify your identity.''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '12. DATA CONTROLLERS & CONTACT',
                    body:
                        '''If you have any inquiries or concerns regarding Benji's Privacy Notice, or if you require further details about how we handle your personal data, or wish to exercise your legal rights related to your personal data, please do not hesitate to get in touch with our Data Privacy Officer via email at Support@benjiexpress.com. We will investigate any complaint about the way we manage Personal Data and ensure that we respond to all substantiated complaints within prescribed timelines.''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '13. Related Practices and Information',
                    body: '''A. Cookie Notice BENJI COOKIE NOTICE 
                
1. About this Notice This Cookie Notice offers insights into how Benji employs cookies when you visit our website or use our mobile applications. Please note that any Personal Data obtained by Benji through cookies and similar tracking technologies is under the control of Benji. We encourage you to become acquainted with our cookie-related practices. 
                
2. Cookies and how we use them A cookie is a small file of letters and numbers that websites send to the browser which are stored in the User terminal, which might be our computer, phones or applications, your personal computer, a mobile phone, a tablet, or any other device. Cookies enable us to differentiate you from other visitors to our website and mobile applications, thus enhancing your browsing experience. For instance, we utilize cookies for the following purposes: • Identifying and tallying the number of visitors and tracking their navigation within our websites, mobile apps, and app (these aids in enhancing the functionality of our website, such as ensuring users can easily locate the information they seek) • Recognizing your preferences and subscriptions, such as language settings, saved items, items stored in your shopping basket, and Prime membership status; and • Sending you newsletters and commercial/advertising messages tailored to your interests. Third-party entities that have been authorized by us may also establish cookies while you use our marketplace. These third parties encompass search engines, providers of measurement and analytics services, social media networks, and advertising companies. 2. Cookie Preferences We use technology such as “cookies” to collect information and store your online preferences. By managing your cookie preference, you enable or disable a specific set of cookies based on predefined categorization: Strictly Necessary Cookies: These cookies are essential for website functionality and are automatically enabled when you use the site. They are crucial for processes like making purchases and checking out, and you cannot disable them. Analytics Cookies: These cookies help the website understand how efficiently users navigate it and which features they use. The data collected through these cookies is used to improve the site and enhance the user experience. Functional Cookies: Functionality cookies remember your choices and provide enhanced personal features. They collect anonymized information and do not track your browsing activity on the site. Targeting Cookies: These cookies track your visits to the site, the frequency of visits, and the specific parts of the site you use. This information is used to tailor the site and advertisements to your interests. Some data from targeting cookies may be shared with third parties. Persistent Cookies: These cookies remain on your device for a predefined period and are activated each time you visit the site. Session Cookies: Session cookies are temporary and only active from the moment you visit the site until you close your browser. They are deleted when you close your browser. For additional information on the personal data collection, data protection measures, your legal rights, and the website's legal obligations, you can refer to the provided Privacy Notice. 
                
3. Consent Before Cookies are placed on your computer or device, you will be presented with a prompt requesting your consent to set these Cookies. Granting your consent for the placement of Cookies enables us to offer you the best possible experience and service. You have the option to deny consent for the placement of Cookies (except for those that are strictly necessary). However, please note that certain features of our website may not function fully or as intended if you choose to deny consent. You will have the opportunity to allow or deny different categories of Cookies that we use. In addition to the controls we offer, you can also choose to enable or disable Cookies in your internet browser. Most internet browsers allow you to decide whether to disable all Cookies or only third-party Cookies. By default, most internet browsers accept Cookies, but you can change this setting. For more information, please refer to the help menu in your internet browser or consult the documentation that came with your device. Below, you will find links that provide instructions on how to manage Cookies in popular web browsers: Google Chrome Microsoft Internet Explorer Microsoft Edge (Please note that there are no specific instructions at this time, but Microsoft support will be able to assist) Safari (macOS) Safari (iOS) Mozilla Firefox Android (Please refer to your device’s documentation for manufacturers’ own browsers) 
                
4. Changes to this Cookie Policy We reserve the right to modify this Cookie Policy at any time. If we make changes, the details of these changes will be prominently displayed at the top of this page. Such changes will become effective for you upon your initial use of our website following the modifications. Therefore, we recommend checking this page periodically. In the event of any discrepancies between the current version of this Cookie Policy and any prior versions, the provisions of the current and effective version shall take precedence unless explicitly stated otherwise. 
                
5. Further Information If you seek additional information regarding how we handle your personal data or wish to exercise your legal rights related to your personal data, please do not hesitate to contact us via email at support@benjiexpress.com B. Terms and Conditions''',
                  ),
                  kSizedBox,
                  kSizedBox,
                  kSizedBox,
                  kSizedBox,
                  Footer(),
                ],
              ),
            ),
          ],
        ),
      ),
      endDrawer: const MyDrawer(),
      floatingActionButton: _showBackToTopButton == false
          ? null
          : OutlinedButton(
              style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(0),
                  minimumSize: const Size(45, 45),
                  foregroundColor: kAccentColor,
                  side: BorderSide(color: kAccentColor)),
              onPressed: _scrollToTop,
              child: const Icon(
                Icons.arrow_upward,
                size: 20,
                // color: Colors.white,
              ),
            ),
    );
  }
}
