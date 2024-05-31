import 'package:benji/src/components/appbar/my_appbar.dart';
import 'package:benji/src/providers/constants.dart';
import 'package:benji/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AssignRider extends StatefulWidget {
  const AssignRider({
    super.key,
  });

  @override
  State<AssignRider> createState() => _AssignRiderState();
}

class _AssignRiderState extends State<AssignRider> {
  //================================================= INITIAL STATE AND DISPOSE =====================================================\\

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: MyAppBar(
        title: "Available Riders",
        elevation: 0,
        actions: const [],
        backgroundColor: kPrimaryColor,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Scrollbar(
          child: ListView.separated(
            itemCount: 40,
            separatorBuilder: (context, index) => kSizedBox,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) => Card(
              elevation: 5,
              child: Container(
                decoration: ShapeDecoration(shape: RoundedRectangleBorder()),
                child: ListTile(
                  tileColor: kTextWhiteColor,
                  leading: Stack(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/products/okpa.jpeg',
                            fit: BoxFit.cover,
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 30,
                        child: Container(
                          height: 10,
                          width: 10,
                          decoration: const ShapeDecoration(
                              color: kSuccessColor,
                              shape: OvalBorder(
                                  side: BorderSide(
                                      color: kTextWhiteColor, width: 1))),
                        ),
                      ),
                    ],
                  ),
                  title: const Text(
                    'Jerry Emmanuel',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.locationDot,
                        color: kAccentColor,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        'Achara Layout',
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  trailing: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        foregroundColor: kAccentColor,
                        side: BorderSide(color: kAccentColor)),
                    onPressed: () {},
                    child: Text("Assign"),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
