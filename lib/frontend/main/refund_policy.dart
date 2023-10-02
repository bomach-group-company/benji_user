import 'package:benji_user/src/frontend/widget/responsive/appbar/appbar.dart';
import 'package:benji_user/src/frontend/widget/section/breadcrumb.dart';
import 'package:benji_user/src/frontend/widget/section/title_body.dart';
import 'package:flutter/material.dart';

import '../../src/frontend/widget/drawer/drawer.dart';
import '../../src/frontend/widget/section/footer.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class RefundPolicyPage extends StatefulWidget {
  const RefundPolicyPage({super.key});

  @override
  State<RefundPolicyPage> createState() => _RefundPolicyPageState();
}

class _RefundPolicyPageState extends State<RefundPolicyPage> {
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
    final media = MediaQuery.of(context).size;

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
                children: const [
                  MyBreadcrumb(text: 'Refund Policy'),
                  kSizedBox,
                  TitleBody(
                    title: 'Returns and Refunds',
                    body: '''
Returns of products by buyers and acceptance of returned products by sellers will be managed by us in accordance with the returns page on the marketplace, subject to compliance with applicable laws in the territory.

Refunds for returned products will be managed in accordance with the refunds page on the marketplace, subject to applicable laws in the territory. We may offer refunds at our discretion: In respect of the product price.

Local and/or international shipping fees (as stated on the refunds page).

By way of store credits, vouchers, mobile money transfer, bank transfers, or other methods as determined by us.

Returned products will be accepted, and refunds will be issued by Benji on behalf of the seller. However, in respect of digital products or services and fresh food, Benji will issue refunds only for delivery failures. Refunds for these products for other reasons will be subject to the seller's terms and conditions of sale.

Changes to our returns page or refunds page will apply to all purchases made from the date of the change's publication on our website.
                  ''',
                  ),
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
