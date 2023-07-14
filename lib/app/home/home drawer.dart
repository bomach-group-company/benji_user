import 'package:flutter/material.dart';

import '../../providers/constants.dart';
import '../../reusable widgets/my appbar.dart';
import '../../theme/colors.dart';

class HomeDrawer extends StatefulWidget {
  final Function() toEditProfilePage;
  final Function() copyUserIdToClipBoard;
  final Function() toInvitesPage;
  final Function() toFavoritesPage;
  final Function() toOrdersPage;
  final Function() toAddressesPage;
  final Function() logOut;

  final String userID;
  const HomeDrawer({
    super.key,
    required this.copyUserIdToClipBoard,
    required this.userID,
    required this.toOrdersPage,
    required this.toInvitesPage,
    required this.toAddressesPage,
    required this.logOut,
    required this.toFavoritesPage,
    required this.toEditProfilePage,
  });

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kPrimaryColor,
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          5.0,
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      child: ListView(
        children: [
          MyAppBar(
            elevation: 0.0,
            title: "Profile",
            toolbarHeight: 80,
            backgroundColor: kPrimaryColor,
            actions: [],
          ),
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(
                "assets/images/profile/super-maria.png",
              ),
            ),
            title: Text(
              'Super Maria',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Color(
                  0xFF4C4C4C,
                ),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            subtitle: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'supermaria@gmail.com',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(
                        0xFF4C4C4C,
                      ),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        widget.userID,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(
                            0xFF4C4C4C,
                          ),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      kWidthSizedBox,
                      IconButton(
                        onPressed: widget.copyUserIdToClipBoard,
                        icon: Icon(
                          Icons.content_copy_rounded,
                          size: 14,
                          color: kAccentColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          kHalfSizedBox,
          Divider(
            color: Color(
              0xFF4C4C4C,
            ),
          ),
          kHalfSizedBox,
          ListTile(
            onTap: widget.toEditProfilePage,
            leading: Icon(
              Icons.person_rounded,
              color: kAccentColor,
            ),
            title: Text(
              'Profile Settings',
              style: TextStyle(
                color: Color(
                  0xFF334A66,
                ),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Color(
                0xFF4C4C4C,
              ),
            ),
          ),
          ListTile(
            onTap: widget.toAddressesPage,
            leading: Icon(
              Icons.location_on_rounded,
              color: kAccentColor,
            ),
            title: Text(
              'Addresses',
              style: TextStyle(
                color: Color(
                  0xFF334A66,
                ),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Color(
                0xFF4C4C4C,
              ),
            ),
          ),
          ListTile(
            onTap: widget.toFavoritesPage,
            leading: Icon(
              Icons.favorite_rounded,
              color: kAccentColor,
            ),
            title: Text(
              'Favorites',
              style: TextStyle(
                color: Color(
                  0xFF334A66,
                ),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Color(
                0xFF4C4C4C,
              ),
            ),
          ),
          ListTile(
            onTap: widget.toOrdersPage,
            leading: Icon(
              Icons.receipt_long,
              color: kAccentColor,
            ),
            title: Text(
              'Orders',
              style: TextStyle(
                color: Color(
                  0xFF334A66,
                ),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Color(
                0xFF4C4C4C,
              ),
            ),
          ),
          ListTile(
            onTap: widget.toInvitesPage,
            leading: Icon(
              Icons.person_add_alt_1_rounded,
              color: kAccentColor,
            ),
            title: Text(
              'Invites',
              style: TextStyle(
                color: Color(
                  0xFF334A66,
                ),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Color(
                0xFF4C4C4C,
              ),
            ),
          ),
          ListTile(
            onTap: widget.logOut,
            leading: Icon(
              Icons.logout_rounded,
              color: kAccentColor,
            ),
            title: Text(
              'Logout',
              style: TextStyle(
                color: Color(
                  0xFF334A66,
                ),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Color(
                0xFF4C4C4C,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
