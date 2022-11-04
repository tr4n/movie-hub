import 'package:flutter/material.dart';

import '../../data/model/models.dart';
import '../../data/platform/network/api/urls.dart';
import '../../resources/resources.dart';

class ItemMovieInformation extends StatelessWidget {
  final Movie movie;
  final Function()? onTap;

  const ItemMovieInformation({required this.movie, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Sizes.size16),
              child: Image.network(
                movie.posterPath != null
                    ? "${Urls.w342ImagePath}${movie.posterPath}"
                    : "https://api.lorem.space/image/movie?w=95&h=120",
                width: 95,
                height: 120,
                fit: BoxFit.cover,
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
                    child: Text(movie.title ?? ""),
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
                            child: Text(movie.voteAverage.toString()),
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
                            child: Text(movie.allGenres),
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
                            child: Text(movie.releaseDate ?? ""),
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
                            child: Text("${movie.runtime ?? 0} minutes"),
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
      ),
    );
  }
}
