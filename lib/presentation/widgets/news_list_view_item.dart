import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../data/DTO/news.dart';
import '../../data/cache/cache_manager.dart';

class NewsItem extends StatelessWidget {
  final News news;
  const NewsItem(this.news, {super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: 180,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: news.imageUrl.toString(),
                      cacheManager: CustomCacheManager.instance,
                      placeholder: (context, url) => const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 15,
                bottom: 5,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {},
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: Image.asset(
                        'assets/images/save.png',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  news.title.toString(),
                  style: const TextStyle(
                    color: Color(0xff1D1A61),
                    fontSize: 16,
                    fontFamily: 'openSans',
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 3,
                ),
                Text(
                  news.summary.toString(),
                  style: const TextStyle(
                    fontFamily: 'openSans',
                    fontSize: 14,
                    color: Color(0xff1D1A61),
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    DateFormat('MMM dd, yyyy').format(news.modifiedAt),
                    style: const TextStyle(
                      fontFamily: 'openSans',
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff1D1A61),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
