import 'package:benji_user/src/frontend/widget/responsive/appbar/appbar.dart';
import 'package:benji_user/src/frontend/widget/section/breadcrumb.dart';
import 'package:benji_user/src/frontend/widget/section/title_body.dart';
import 'package:flutter/material.dart';

import '../../src/frontend/widget/drawer/drawer.dart';
import '../../src/frontend/widget/section/footer.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class TermConditionPage extends StatefulWidget {
  const TermConditionPage({super.key});

  @override
  State<TermConditionPage> createState() => _TermConditionPageState();
}

class _TermConditionPageState extends State<TermConditionPage> {
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
      drawerScrimColor: Colors.transparent,
      backgroundColor: const Color(0xfffafafc),
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
                  MyBreadcrumb(text: 'Terms & Conditions'),
                  kSizedBox,
                  TitleBody(
                    title: '1. Introduction',
                    body:
                        '''1.1 "Benji" represents the official trading name for the e-commerce platform developed by Bomach Group of  Company alongside allied services provided through its subsidiaries. Details can be found in Appendix 1. The  company and its subsidiaries, referred to as 'Benji' or 'we,' operates a single e-commerce platform, inclusive of a  website and a mobile application ('marketplace'). This platform is supported by robust IT logistics and payment  infrastructure, facilitating the sale and purchase of consumer products and services ('products') within designated  regions (known as territory) 
1.2 These general terms and conditions apply to both buyers and sellers on the marketplace and govern the  utilization of the marketplace and its related services. 
1.3 By using our marketplace, you accept these general terms and conditions in their entirety. If you disagree with any  part of these terms and conditions, you must refrain from using our marketplace. 
1.4 If you utilize our marketplace for business or organizational purposes, you confirm that you possess the  necessary authority to agree to these general terms and conditions, thereby binding both yourself and the relevant  entity to these terms. Furthermore, you agree that within these general terms and conditions, 'you' may reference  both the individual user and the pertinent company or legal entity, unless the context dictates otherwise. 
''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '2. Registration and Account ',
                    body:
                        '''2.1 You may not register on our marketplace if you are under 18 years of age (by using our marketplace or agreeing  to these general terms and conditions, you warrant and represent to us that you are at least 18 years old). 
2.2 When you register for an account on our marketplace, you will be required to provide an email address/user ID  and a password. You agree to: 
2.2.1 Keep your password confidential. 
2.2.2 Notify us in writing immediately (using our provided contact details in Appendix 1) if you become aware of any  unauthorized access to your password. 
2.2.3 Accept responsibility for any activity on our marketplace resulting from your failure to maintain password  confidentiality, and you may be held liable for any losses arising from such failure. 
2.2.4 Use your account exclusively and not transfer it to any third party. If you authorize a third party to manage your  account on your behalf, you do so at your own risk. 
2.2.5 We reserve the right to suspend or cancel your account, edit your account details, or cancel any products or  services you have paid for but not received, at any time in our sole discretion, without notice or explanation. However,  if we cancel products or services without you breaching these general terms and conditions, we will refund you  accordingly. 
2.3 You may cancel your account on our marketplace by contacting us. 
''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '3. Terms and Conditions of Sale ',
                    body: '''3.1 You acknowledge and agree that: 
3.1.1 The marketplace serves as an online platform for sellers to offer products and buyers to make purchases.
3.1.2 We act as a facilitator for binding sales on behalf of sellers but are not a party to the transaction between the  seller and the buyer. 
3.1.3 A contract for the sale and purchase of a product or products will come into effect between the buyer and  seller. Accordingly, you commit to buying or selling the relevant product or products upon the buyer's confirmation of  purchase via the marketplace. 
3.2 Subject to these general terms and conditions, the seller's terms of business will govern the contract for sale and  purchase between the buyer and the seller. Nevertheless, the following provisions will be integrated into the contract  of sale and purchase between the buyer and the seller: 
3.2.1 The price for a product will be as stated in the relevant product listing. 
3.2.2 The price for the product must include all taxes and comply with applicable laws. 
3.2.3 Delivery charges, packaging charges, handling charges, administrative charges, insurance costs, and other  ancillary costs and charges, where applicable, will only be payable by the buyer if expressly stated in the product  listing. Delivery of digital products may be made electronically. 
3.2.4 Products must be of satisfactory quality, fit for the specified purpose, and conform in all material respects to  the product listing and any other description of the products provided by the seller to the buyer. 
3.2.5 Regarding physical products, the seller warrants that they have good title to and are the sole legal and beneficial  owner of the products and/or have the right to supply the products under this agreement. The products are not  subject to any third-party rights or restrictions, including third-party intellectual property rights, criminal, insolvency, or  tax investigations or proceedings. In the case of digital products, the seller warrants they have the right to supply the  digital products to the buyer. 
''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '4. Returns and Refunds',
                    body: '''
4.1 Returns of products by buyers and acceptance of returned products by sellers will be managed by us in accordance with the returns page on the marketplace, subject to compliance with applicable laws in the territory.
4.2 Refunds for returned products will be managed in accordance with the refunds page on the marketplace, subject to applicable laws in the territory. We may offer refunds at our discretion:
4.2.1 In respect of the product price.
4.2.2 Local and/or international shipping fees (as stated on the refunds page).
4.2.3 By way of store credits, vouchers, mobile money transfer, bank transfers, or other methods as determined by us.
4.3 Returned products will be accepted, and refunds will be issued by Benji on behalf of the seller. However, in respect of digital products or services and fresh food, Benji will issue refunds only for delivery failures. Refunds for these products for other reasons will be subject to the seller's terms and conditions of sale.
4.4 Changes to our returns page or refunds page will apply to all purchases made from the date of the change's publication on our website.
                  ''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '5. Payments',
                    body: '''
5.1 You must make payments due under these general terms and conditions in accordance with the Payments Information and Guidelines on the marketplace.
                  ''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '6. Store Credit',
                    body: '''
6.1 Store Credits may be earned and managed following the Benji Store Credit Terms and Conditions, which may be amended from time to time. Benji reserves the right to cancel or withdraw Benji store credit rewards for any reason at its discretion, including suspicion of fraud or foul play.
                  ''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '7. Promotions',
                    body: '''
7.1 Promotions and competitions conducted by Benji and/or other promoters will be managed in accordance with the Promotions Terms and Conditions, which can be found on our website.
                  ''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '8. Rules about Your Content',
                    body: '''
8.1 In these general terms and conditions, "your content" refers to all materials submitted to us or our marketplace, including text, graphics, images, audio, video, scripts, software, and files, as well as communications on the marketplace, such as product reviews, feedback, and comments.
8.2 Your content and its use by us must be accurate, complete, and truthful.
8.3 Your content must be appropriate, civil, and tasteful, adhering to generally accepted standards of etiquette and behavior on the internet. Your content must not:
8.3.1 Be offensive, obscene, indecent, pornographic, lewd, suggestive, or sexually explicit.
8.3.2 Depict violence in an explicit, graphic, or gratuitous manner.
8.3.3 Be blasphemous, in breach of racial or religious hatred or discrimination legislation.
8.3.4 Be deceptive, fraudulent, threatening, abusive, harassing, anti-social, menacing, hateful, discriminatory, or inflammatory.
8.3.5 Cause annoyance, inconvenience, or needless anxiety to any person.
8.3.6 Constitute spam.
8.4 Your content must not be illegal or unlawful, infringe on any person's legal rights, or give rise to legal action against any person under any applicable law. Your content must not infringe or breach:
8.4.1 Any copyright, moral right, database right, trademark right, design right, right in passing off, or other intellectual property right.
8.4.2 Any right of confidence, right of privacy, or right under data protection legislation.
8.4.3 Any contractual obligation owed to any person.
8.4.4 Any court order.
8.5 You must not use our marketplace to link to any website or web page that, if posted on our marketplace, would breach these general terms and conditions.
8.6 You must not submit to our marketplace any material that has been the subject of any threatened or actual legal proceedings or other similar complaints.
8.7 The review function on the marketplace may be used to facilitate buyer reviews on products. You shall not use the review function or any other form of communication to provide inaccurate, inauthentic, or fake reviews.
8.8 You must not interfere with a transaction by:
8.8.1 Contacting another user to buy or sell an item listed on the marketplace outside of the marketplace.
8.8.2 Communicating with a user involved in an active or completed transaction to warn them away from a particular buyer, seller, or item.
8.8.3 Contacting another user with the intent to collect any payments.
8.9 You acknowledge that all users of the marketplace are solely responsible for interactions with other users, and you shall exercise caution and good judgment in your communication with users. You shall not send them personal information, including credit card details.
8.10 We may periodically review your content and reserve the right to remove any content at our discretion for any reason whatsoever.
8.11 If you learn of any unlawful material or activity on our marketplace or any material or activity that breaches these general terms and conditions, you may inform us by contacting us as provided in Appendix 1
                  ''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '9. Our Rights to Use Your Content',
                    body: '''
9.1 You grant us a worldwide, irrevocable, non-exclusive, royalty-free license to use, reproduce, store, adapt, publish, translate, distribute, and display your content on our marketplace and across our marketing channels and any existing or future media.
9.2 You grant us the right to sub-license the rights licensed under section 9.1.
9.3 You grant us the right to bring an action for infringement of the rights licensed under section 9.1.
9.4 You hereby waive all your moral rights in your content to the maximum extent permitted by applicable law, and you warrant and represent that all other moral rights in your content have been waived to the maximum extent permitted by applicable law.
9.5 Without prejudice to our other rights under these general terms and conditions, if you breach our rules on content in any way or if we reasonably suspect that you have breached our rules on content, we may delete, unpublish, or edit any or all of your content.
                  ''',
                  ),
                  kSizedBox,
                  kSizedBox,
                  TitleBody(
                    title: '10. Use of Website and Mobile Applications',
                    body: '''
10.1 You may:
10.1.1 View pages from our website in a web browser.
10.1.2 Download pages from our website for caching in a web browser.
10.1.3 Print pages from our website for your own personal and non-commercial use, provided that such printing is not systematic or excessive.
10.1.4 Stream audio and video files from our website using the media player on our website.
10.1.5 Use our marketplace services via a web browser, subject to the other provisions of these general terms and conditions.
10.3 Except as expressly permitted by section 10.1.2 or the other provisions of these general terms and conditions, you must not download any material from our website or save any such material to your computer.
10.4 You may only use our website for your own personal and business purposes in relation to selling or purchasing products on the marketplace.
10.5 Except as expressly permitted by these general terms and conditions, you must not edit or otherwise modify any material on our website.
10.6 Unless you own or control the relevant rights in the material, you must not:
10.6.1 Republish material from our website (including republication on another website).
10.6.2 Sell, rent, or sub-license material from our website.
10.6.3 Show any material from our website in public.
10.6.4 Exploit material from our website for a commercial purpose.
10.6.5 Redistribute material from our website.
10.7 Notwithstanding section 10.6, you may forward links to products on our website and redistribute our newsletter and promotional materials in print and electronic form to any person.
10.8 We reserve the right to restrict access to areas of our website, or indeed our whole website, at our discretion. You must not circumvent or bypass, or attempt to circumvent or bypass, any access restriction measures on our website.
10.9. You must not:
10.9.1. use our website in any way or take any action that causes or may cause damage to the website or impairment of the performance availability, accessibility, integrity or security of the website;
10.9.2. use our website in any way that is unethical unlawful illegal fraudulent or harmful or in connection with any unlawful illegal fraudulent or harmful purpose or activity;
10.9.3. hack or otherwise tamper with our website;
10.9.4. probe scan or test the vulnerability of our website without our permission;
10.9.5. circumvent any authentication or security systems or processes on or relating to our website;
10.9.6. use our website to copy store host transmit send use publish or distribute any material which consists of (or is linked to) any spyware computer virus Trojan horse worm keystroke logger rootkit or other malicious computer software;
10.9.7. impose an unreasonably large load on our website resources (including bandwidth storage capacity and processing capacity);
10.9.8. decrypt or decipher any communications sent by or to our website without our permission;
10.9.9. conduct any systematic or automated data collection activities (including without limitation scraping data mining data extraction and data harvesting) on or in relation to our website without our express written consent;
10.9.10. access or otherwise interact with our website using any robot spider or other automated means except for the purpose of search engine indexing;
10.9.11. use our website except by means of our public interfaces;
10.9.12. violate the directives set out in the robots.txt file for our website;
10.9.13. use data collected from our website for any direct marketing activity (including without limitation email marketing SMS marketing telemarketing and direct mailing); or
10.9.14. do anything that interferes with the normal use of our website.
                  ''',
                  ),
                  kSizedBox,
                  kSizedBox,
                  TitleBody(
                    title: '11. Copyright and Trademarks',
                    body: '''
11.1. Subject to the express provisions of these general terms and conditions:
11.1.1. we together with our licensors own and control all the copyright and other intellectual property rights in our website and the material on our website; and
11.1.2. all the copyright and other intellectual property rights in our website and the material on our website are reserved.
11.2. Benji’s logos and our other registered and unregistered trademarks are trademarks belonging to us; we give no permission for the use of these trademarks and such use may constitute an infringement of our rights.
11.3. The third party registered and unregistered trademarks or service marks on our website are the property of their respective owners and we do not endorse and are not affiliated with any of the holders of any such rights and as such we cannot grant any license to exercise such rights.
                  ''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '12. Data Privacy',
                    body: '''
12.1. Buyers agree to processing of their personal data in accordance with the terms of Benji’s Privacy and Cookie Notice.
12.2. Benji shall process all personal data obtained through the marketplace and related services in accordance with the terms of our Privacy and Cookie Notice and Privacy Policy.
12.3. Sellers shall be directly responsible to buyers for any misuse of their personal data and Benji shall bear no liability to buyers in respect of any misuse by sellers of their personal data.
''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '13. Due Diligence and Audit Rights',
                    body: '''
13.1. We operate an anti-fraud and anti-money laundering compliance program and reserve the right to perform due diligence checks on all users of the marketplace.
13.2. You agree to provide to us all such information documentation and access to your business premises as we may require:
13.2.1. in order to verify your adherence to and performance of your obligations under these terms and conditions;
13.2.2. for the purpose of disclosures pursuant to a valid order by a court or other governmental body; or
13.2.3. as otherwise required by law or applicable regulation.
''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '14. Benji’s Role as a Marketplace',
                    body: '''
14.1. You acknowledge that:
14.1.1. Benji facilitates a marketplace for buyers and third-party sellers or Benji where Benji is the seller of a product;
14.1.2. the relevant seller of the product (whether Benji is the seller or whether it is a third-party seller) shall at all times remain exclusively liable for the products they sell on the marketplace; and
14.1.3. in the event that there is an issue arising from the purchase of a product on the marketplace, the buyer should seek recourse from the relevant seller of the product by following the process set out in BENJI'S DISPUTE RESOLUTION POLICY
14.2. We commit to ensure that Benji or third-party sellers as applicable submit information relating to their products on the marketplace that is complete, accurate, and up to date, and pursuant thereto:
14.2.1. the relevant seller warrants and represents the completeness and accuracy of their information published on our marketplace relating to their products;
14.2.2. the relevant seller warrants and represents that the material on the marketplace is up to date; and
14.2.3. if a buyer has a complaint relating to the accuracy or completeness of the product information received from a seller (including where Benji is the seller), the buyer can seek recourse from the relevant seller by following the process set out in BENJI'S DISPUTE RESOLUTION POLICY.
14.3. We do not warrant or represent that the marketplace will operate without fault; or that the marketplace or any service on the marketplace will remain available during the occurrence of events beyond Benji’s control (force majeure events) which include but are not limited to; flood, drought, earthquake, or other natural disasters; hacking, viruses, malware, or other malicious software attacks on the marketplace; terrorist attacks, civil war, civil commotion, or riots; war, threat of or preparation for war; epidemics or pandemics; or extra-constitutional events or circumstances which materially and adversely affect the political or macro-economic stability of the territory as a whole.
14.4. We reserve the right to discontinue or alter any or all of our marketplace services and to stop publishing our marketplace at any time in our sole discretion without notice or explanation; and you will not be entitled to any compensation or other payment upon the discontinuance or alteration of any marketplace services or if we stop publishing the marketplace. This is without prejudice to your rights in respect of any unfulfilled orders or other existing liabilities of Benji.
14.5. If we discontinue or alter any or all of our marketplace in circumstances not relating to force majeure, we will provide prior notice to the buyers and sellers of not less than fifteen (15) days with clear guidance on the way forward for the pending transactions or other existing liabilities of Benji.
14.6. We do not guarantee any commercial results concerning the use of the marketplace. To the maximum extent permitted by applicable law and subject to section 15.1 below, we exclude all representations and warranties relating to the subject matter of these general terms and conditions, our marketplace, and the use of our marketplace.
''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '15. Limitations and Exclusions of Liability',
                    body: '''
15.1. Nothing in these general terms and conditions will:
15.1.1. limit any liabilities in any way that is not permitted under applicable law; or
15.1.2. exclude any liabilities or statutory rights that may not be excluded under applicable law.
15.2. The limitations and exclusions of liability set out in this section 15 and elsewhere in these general terms and conditions:
15.2.1. are subject to section 15.1; and
15.2.2. govern all liabilities arising under these general terms and conditions or relating to the subject matter of these general terms and conditions, including liabilities arising in contract, in tort (including negligence), and for breach of statutory duty, except to the extent expressly provided otherwise in these general terms and conditions.
15.3. In respect of the services offered to you free of charge, we will not be liable to you for any loss or damage of any nature whatsoever.
15.4. Our aggregate liability to you in respect of any contract to provide services to you under these general terms and conditions shall not exceed the total amount paid and payable to us under the contract. Each separate transaction on the marketplace shall constitute a separate contract for the purpose of this section 15.
15.5. Notwithstanding section 15.4 above, we will not be liable to you for any loss or damage of any nature, including in respect of:
15.5.1. any losses occasioned by any interruption or dysfunction to the website;
15.5.2. any losses arising out of any event or events beyond our reasonable control;
15.5.3. any business losses, including (without limitation) loss of or damage to profits, income, revenue, use, production, anticipated savings, business contracts, commercial opportunities, or goodwill;
15.5.4. any loss or corruption of any data, database, or software; or
15.5.5. any special, indirect, or consequential loss or damage.
15.6. We accept that we have an interest in limiting the personal liability of our officers and employees and having regard to that interest, you acknowledge that we are a limited liability entity; you agree that you will not bring any claim personally against our officers or employees in respect of any losses you suffer in connection with the marketplace or these general terms and conditions (this will not limit or exclude the liability of the limited liability entity itself for the acts and omissions of our officers and employees).
15.7. Our marketplace includes hyperlinks to other websites owned and operated by third parties; such hyperlinks are not recommendations. We have no control over third party websites and their contents, and we accept no responsibility for them or for any loss or damage that may arise from your use of them.
''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '16. Indemnification',
                    body: '''
16.1. You hereby indemnify us and undertake to keep us indemnified against:
16.1.1. any and all losses, damages, costs, liabilities, and expenses (including, without limitation, legal expenses and any amounts paid by us to any third party in settlement of a claim or dispute) incurred or suffered by us and arising directly or indirectly out of your use of our marketplace or any breach by you of any provision of these general terms and conditions or the Benji codes, policies, or guidelines; and
16.1.2. any VAT liability or other tax liability that we may incur in relation to any sale, supply, or purchase made through our marketplace where that liability arises out of your failure to pay, withhold, declare, or register to pay any VAT or other tax properly due in any jurisdiction.
''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '17. Breaches of These General Terms and Conditions',
                    body: '''
17.1. If we permit the registration of an account on our marketplace, it will remain open indefinitely subject to these general terms and conditions.
17.2. If you breach these general terms and conditions or if we reasonably suspect that you have breached these general terms and conditions or any Benji codes, policies, or guidelines in any way, we may:
17.2.1. temporarily suspend your access to our marketplace;
17.2.2. permanently prohibit you from accessing our marketplace;
17.2.3. block computers using your IP address from accessing our marketplace;
17.2.4. contact any or all of your internet service providers and request that they block your access to our marketplace;
17.2.5. suspend or delete your account on our marketplace; and/or
17.2.6. commence legal action against you, whether for breach of contract or otherwise.
17.3. Where we suspend, prohibit, or block your access to our marketplace or a part of our marketplace, you must not take any action to circumvent such suspension or prohibition or blocking (including, without limitation, creating and/or using a different account).
''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '18. Entire Agreement',
                    body: '''
18.1. These general terms and conditions and the Benji codes, policies, and guidelines (and in respect of sellers, the seller terms and conditions) shall constitute the entire agreement between you and us in relation to your use of our marketplace and shall supersede all previous agreements between you and us in relation to your use of our marketplace.
''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '19. Hierarchy',
                    body: '''
19.1. Should these general terms and conditions, the seller terms and conditions, and the Benji codes, policies, and guidelines be in conflict, these terms and conditions, the seller terms and conditions, and the Benji codes, policies, and guidelines shall prevail in the order here stated.
''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '20. Variation',
                    body: '''
20.1. We may revise these general terms and conditions, the seller terms and conditions, and the Benji codes, policies, and guidelines from time to time.
20.2. The revised general terms and conditions shall apply from the date of publication on the marketplace.
''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '21. No Waiver',
                    body: '''
21.1. No waiver of any breach of any provision of these general terms and conditions shall be construed as a further or continuing waiver of any other breach of that provision or any breach of any other provision of these general terms and conditions.
''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '22. Severability',
                    body: '''
22.1. If a provision of these general terms and conditions is determined by any court or other competent authority to be unlawful and/or unenforceable, the other provisions will continue in effect.
22.2. If any unlawful and/or unenforceable provision of these general terms and conditions would be lawful or enforceable if part of it were deleted, that part will be deemed to be deleted and the rest of the provision will continue in effect.
''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '23. Assignment',
                    body: '''
23.1. You hereby agree that we may assign, transfer, sub-contract, or otherwise deal with our rights and/or obligations under these general terms and conditions.
23.2. You may not, without our prior written consent, assign, transfer, sub-contract, or otherwise deal with any of your rights and/or obligations under these general terms and conditions.
''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '24. Third Party Rights',
                    body: '''
24.1. A contract under these general terms and conditions is for our benefit and your benefit and is not intended to benefit or be enforceable by any third party.
24.2. The exercise of the parties' rights under a contract under these general terms and conditions is not subject to the consent of any third party.
''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '25. Law and Jurisdiction',
                    body: '''
25.1. These general terms and conditions shall be governed by and construed in accordance with the laws of the territory.
25.2. Any disputes relating to these general terms and conditions shall be subject to the exclusive jurisdiction of the courts of the territory.
''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '26. Our Company Details and Notices',
                    body: '''
26.1. You can contact us by using the contact details listed in Appendix 1.
26.2. You may contact our sellers for after-sales queries, including any disputes, by requesting their contact details from the Benji in accordance with the DISPUTE RESOLUTION POLICY, pursuant to which Benji shall be obliged to ensure that the seller is clearly identifiable.
26.3. You consent to receive notices electronically from us. We may provide all communications and information related to your use of the marketplace in electronic format, either by posting to our website or application or by email to the email address on your account. All such communications will be deemed to be notices in writing and received by and properly given to you.
''',
                  ),
                  kSizedBox,
                  TitleBody(
                    title: '27. Appendix 1',
                    body: '''
Bomach Group of Company
450 Ogui Road, Enugu State, Nigeria
support@benjiexpress.com
Alpha Logistics and Courier Services Ltd
''',
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
