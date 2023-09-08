import 'package:benji_user/src/common_widgets/appbar/my_appbar.dart';
import 'package:benji_user/theme/colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';

import '../../src/providers/constants.dart';
import 'report_package.dart';

class ViewPackage extends StatefulWidget {
  final String packageIcon;
  final bool isDelivered;
  const ViewPackage({
    super.key,
    required this.packageIcon,
    this.isDelivered = false,
  });

  @override
  State<ViewPackage> createState() => _ViewPackageState();
}

class _ViewPackageState extends State<ViewPackage> {
  //================================================= INITIAL STATE AND DISPOSE =====================================================\\
  @override
  void initState() {
    super.initState();
    _packageData = <String>[
      widget.isDelivered ? "Completed" : "Pending",
      "Sender",
      "07036485732",
      "Ogui, Enugu",
      "Receiver",
      "08136362859",
      "Nsukka, Enugu",
      "Important Documents",
      "${formattedText(10)}",
      "KG - KG",
      "₦ ${formattedText(4800)}",
      "₦ ${formattedText(2500)}",
    ];
  }

  //================================================= ALL VARIABLES =====================================================\\
  List<String> _titles = <String>[
    "Status",
    "Sender's name",
    "Sender's phone number",
    "Sender's location",
    "Receiver's name",
    "Receiver's phone number",
    "Receiver's location",
    "Item name",
    "Item quantity",
    "Item weight",
    "Item value",
    "Price",
  ];

  List<String>? _packageData;
  //=================================================  CONTROLLERS =====================================================\\
  final _scrollController = ScrollController();

  //=================================================  Navigation =====================================================\\
  void _toReportPackage() => Get.to(
        () => ReportPackage(),
        routeName: 'ReportPackage',
        duration: const Duration(milliseconds: 300),
        fullscreenDialog: true,
        curve: Curves.easeIn,
        preventDuplicates: true,
        popGesture: true,
        transition: Transition.rightToLeft,
      );

  void _toSharePackage() {}

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: MyAppBar(
        title: "View Package",
        elevation: 0,
        actions: [],
        backgroundColor: kPrimaryColor,
        toolbarHeight: kToolbarHeight,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Scrollbar(
          controller: _scrollController,
          child: ListView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(10),
            children: [
              Center(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage('assets/icons/${widget.packageIcon}.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              kSizedBox,
              DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(12),
                strokeCap: StrokeCap.round,
                dashPattern: [2],
                padding: EdgeInsets.all(6),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: ListView.separated(
                    itemCount: _titles.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                      height: 1,
                      color: kGreyColor,
                    ),
                    itemBuilder: (BuildContext context, int index) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        height: 100,
                        width: mediaWidth / 3,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: kLightGreyColor),
                        child: Text(
                          _titles[index],
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            color: kTextBlackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      trailing: Container(
                        width: mediaWidth / 2,
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          _packageData![index],
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            color: widget.isDelivered
                                ? kSuccessColor
                                : kSecondaryColor,
                            fontSize: 14,
                            fontFamily: 'sen',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              kSizedBox,
              widget.isDelivered
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: _toReportPackage,
                          style: OutlinedButton.styleFrom(
                              enableFeedback: true,
                              backgroundColor: kPrimaryColor,
                              padding: EdgeInsets.all(kDefaultPadding)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.solidFlag,
                                color: kAccentColor,
                                size: 16,
                              ),
                              kWidthSizedBox,
                              Center(
                                child: Text(
                                  "Report",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: kAccentColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        kWidthSizedBox,
                        ElevatedButton(
                          onPressed: _toSharePackage,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kAccentColor,
                              padding: EdgeInsets.all(kDefaultPadding)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.shareNodes,
                                color: kPrimaryColor,
                                size: 18,
                              ),
                              kWidthSizedBox,
                              SizedBox(
                                child: Text(
                                  "Share",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : OutlinedButton(
                      onPressed: _toReportPackage,
                      style: OutlinedButton.styleFrom(
                          enableFeedback: true,
                          backgroundColor: kPrimaryColor,
                          padding: EdgeInsets.all(kDefaultPadding)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.solidFlag,
                            color: kAccentColor,
                            size: 16,
                          ),
                          kWidthSizedBox,
                          SizedBox(
                            child: Text(
                              "Report",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kAccentColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              kSizedBox,
            ],
          ),
        ),
      ),
    );
  }
}
