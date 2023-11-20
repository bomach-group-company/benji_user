import 'package:benji/src/repo/controller/address_controller.dart';
import 'package:benji/src/repo/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../src/components/appbar/my_appbar.dart';
import '../../src/components/others/empty.dart';
import '../../src/providers/constants.dart';
import '../../theme/colors.dart';

class MyCarts extends StatefulWidget {
  const MyCarts({super.key});

  @override
  State<MyCarts> createState() => _MyCartsState();
}

class _MyCartsState extends State<MyCarts> {
  @override
  void initState() {
    super.initState();
    checkAuth(context);
  }

  //==================================================== CONTROLLERS ======================================================\\
  final ScrollController _scrollController = ScrollController();

  Future<void> _handleRefresh() async {}

  //========================================================================\\

  //======================================= Navigation ==========================================\\

  void _pickOption() {}

  @override
  Widget build(BuildContext context) {
    // double mediaHeight = MediaQuery.of(context).size.height;
    double mediaWidth = MediaQuery.of(context).size.width;
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      color: kAccentColor,
      edgeOffset: 0,
      displacement: kDefaultPadding,
      semanticsLabel: "Pull to refresh",
      strokeWidth: 4,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: MyAppBar(
          elevation: 0.0,
          title: "My Carts",
          backgroundColor: kPrimaryColor,
          actions: const [],
        ),
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: GetBuilder<AddressController>(
              initState: (state) => AddressController.instance.getAdresses(),
              builder: (controller) {
                if (controller.isLoad.value && controller.addresses.isEmpty) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: kAccentColor,
                    ),
                  );
                }
                return Scrollbar(
                  controller: _scrollController,
                  radius: const Radius.circular(10),
                  scrollbarOrientation: ScrollbarOrientation.right,
                  child: controller.addresses.isEmpty
                      ? const EmptyCard(removeButton: true)
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount: controller.addresses.length,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: const EdgeInsetsDirectional.symmetric(
                                vertical: kDefaultPadding / 2,
                              ),
                              child: ListTile(
                                onTap: () => _pickOption(),
                                enableFeedback: true,
                                trailing: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 16,
                                  color: kAccentColor,
                                ),
                                title: SizedBox(
                                  width: mediaWidth - 100,
                                  child: Text(
                                    'Cart ${index + 1}',
                                    style: const TextStyle(
                                      color: kTextBlackColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                );
              }),
        ),
      ),
    );
  }
}
