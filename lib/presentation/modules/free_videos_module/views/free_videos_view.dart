import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shabakahub2025/presentation/widgets/app_bar/custom_app_bar.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../../../data/models/free_videos_model.dart';
import '../controllers/free_videos_controller.dart';

class FreeVideosListView extends GetView<FreeVideosListController> {
  const FreeVideosListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FreeVideosListController>();
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      appBar: CustomAppBar(
        titleText: controller.categoryName ?? 'Free Videos',
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.hasError) {
        //  return _buildErrorWidget(controller);
        }
        if (controller.isEmpty) {
         // return _buildEmptyWidget();
        }

        return RefreshIndicator(
          onRefresh: () async {
            if (controller.freecategoryId != null) {
              await controller.fetchFreeVideosByCategoryId(
                controller.freecategoryId!,
              );
            }
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  height: Get.height * 0.50, // Slightly smaller player
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: YoutubePlayerScaffold(
                      controller: controller.youtubeController,
                      aspectRatio: 16/ 9,
                      builder: (context, player) {
                        return player;
                      },
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isMobile ? 2 : 3,
                    crossAxisSpacing: 4, // Reduced spacing
                    mainAxisSpacing: 6, // Reduced spacing
                    childAspectRatio: 0.7, // More compact aspect ratio
                    mainAxisExtent: 180, // Fixed height for items
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final video = controller.freeVideos[index];
                      return _buildVideoItem(video, controller);
                    },
                    childCount: controller.freeVideos.length,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildVideoItem(FreeVideoModel video, FreeVideosListController controller) {
    return InkWell(
      onTap: () => controller.playVideo(video.videoUrl),
      borderRadius: BorderRadius.circular(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Smaller thumbnail container
          Container(
            height: 120,
            // Fixed smaller height
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: video.thumbnailUrl,
                    fit: BoxFit.cover,
                    width: double.infinity*.2,
                    height: double.infinity*.2,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[200],
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.videocam_off,
                        size: 24,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                  const Icon(
                    Icons.play_circle_fill,
                    color: Colors.white,
                    size: 36, // Smaller play button
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          // Title and duration
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  video.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Get.textTheme.bodyMedium?.copyWith(
                    fontSize: 13, // Smaller font size
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // if (video.duration != null)
                //   Text(
                //     video.duration!,
                //     style: Get.textTheme.bodySmall?.copyWith(
                //       fontSize: 11, // Smaller font size
                //       color: Colors.grey[600],
                //     ),
                //   ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// ... (keep the existing _buildErrorWidget and _buildEmptyWidget methods)
}