import 'package:flutter/material.dart';

import '../../resources/resources.dart';

class ItemMovieInformation extends StatelessWidget {
  final String title;
  final String rate;
  final String type;
  final String releaseDate;
  final String duration;
  final String imageUrl;

  final Function()? onTap;

  const ItemMovieInformation(
      {required this.title,
      required this.rate,
      required this.type,
      required this.releaseDate,
      required this.duration,
      required this.imageUrl,
      this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Sizes.size16),
            child: FadeInImage.assetNetwork(
              placeholder: "assets/images/img_placeholder.png",
              image: imageUrl,
              width: 95,
              height: 120,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: Sizes.size12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: const TextStyle(fontSize: 16),
                  child: Text(title),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/ic_star.png",
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: Sizes.size4),
                        DefaultTextStyle(
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColor.orangeFF8700,
                            fontWeight: FontWeight.bold,
                          ),
                          child: Text(rate),
                        ),
                      ],
                    ),
                    const SizedBox(height: Sizes.size4),
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/ic_ticket.png",
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: Sizes.size4),
                        DefaultTextStyle(
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                          child: Text(type),
                        ),
                      ],
                    ),
                    const SizedBox(height: Sizes.size4),
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/ic_calendar_blank.png",
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: Sizes.size4),
                        DefaultTextStyle(
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                          child: Text(releaseDate),
                        ),
                      ],
                    ),
                    const SizedBox(height: Sizes.size4),
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/ic_clock.png",
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: Sizes.size4),
                        DefaultTextStyle(
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                          child: Text("$duration minutes"),
                        ),
                      ],
                    ),
                    const SizedBox(height: Sizes.size4),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
