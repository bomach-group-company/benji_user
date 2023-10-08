import 'package:benji/frontend/main/blog_detail.dart';
import 'package:benji/src/frontend/widget/clickable.dart';
import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';
import '../../../providers/constants.dart';

class MyBlogCard extends StatefulWidget {
  final String image;
  final String date;
  final String from;
  final String title;
  final String description;
  final Widget navigate;
  const MyBlogCard({
    super.key,
    required this.image,
    required this.date,
    required this.from,
    required this.title,
    required this.description,
    this.navigate = const BlogDetailsPage(),
  });

  @override
  State<MyBlogCard> createState() => _MyBlogCardState();
}

class _MyBlogCardState extends State<MyBlogCard> {
  double blurRadius = 2;
  double margin = 10;
  double padding = 22;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          blurRadius = 20;
          margin = 10;
          padding = 27;
        });
      },
      onExit: (event) {
        setState(() {
          blurRadius = 2;
          margin = 15;
          padding = 22;
        });
      },
      child: AnimatedContainer(
        curve: Curves.bounceInOut,
        margin: EdgeInsets.all(margin),
        duration: const Duration(microseconds: 200000),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          border: const Border.fromBorderSide(
            BorderSide(
              width: 1,
              color: Colors.black12,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: blurRadius,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: MyClickable(
          navigate: widget.navigate,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      image: AssetImage(widget.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: double.infinity,
                ),
              ),
              kSizedBox,
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.date),
                          Expanded(
                            child: Text(
                              'Post by: ${widget.from}',
                              textAlign: TextAlign.end,
                              softWrap: false,
                              maxLines: 3,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      kHalfSizedBox,
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          widget.title,
                          softWrap: false,
                          maxLines: 2,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      kSizedBox,
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          widget.description,
                          softWrap: false,
                          maxLines: 5,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      kSizedBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kAccentColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 15,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => widget.navigate,
                                ),
                              );
                            },
                            child: const Text(
                              'Read More',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      kSizedBox,
                    ],
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
