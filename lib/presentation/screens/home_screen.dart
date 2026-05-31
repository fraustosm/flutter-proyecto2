import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/theme_provider.dart';
import '../providers/gallery.provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends ConsumerState<HomeScreen> {

  final ScrollController _scrollController =
      ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {

      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {

        ref
            .read(
              galleryProvider.notifier,
            )
            .loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final isDarkMode =
        ref.watch(themeProvider);

    final galleryState =
        ref.watch(galleryProvider);

    final width =
        MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Gallery',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ref
                  .read(
                    themeProvider.notifier,
                  )
                  .toggleTheme();
            },
            icon: Icon(
              isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),
        ],
      ),

      body: Column(
        children: [

          Padding(
            padding:
                const EdgeInsets.all(16),
            child: TextField(
              onSubmitted: (value) {

                if (value.trim().isEmpty) {
                  return;
                }

                ref
                    .read(
                      galleryProvider.notifier,
                    )
                    .searchImages(value);
              },

              decoration: InputDecoration(
                hintText:
                    'Search images...',
                prefixIcon:
                    const Icon(Icons.search),

                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                ),
              ),
            ),
          ),

          if (galleryState.isLoading &&
              galleryState.images.isEmpty)

            const Expanded(
              child: Center(
                child:
                    CircularProgressIndicator(),
              ),
            )

          else if (galleryState.error !=
              null)

            Expanded(
              child: Center(
                child: Text(
                  galleryState.error!,
                ),
              ),
            )

          else

            Expanded(
              child: GridView.builder(
                controller:
                    _scrollController,

                padding:
                    const EdgeInsets.all(
                  12,
                ),

                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      width < 600
                          ? 2
                          : 4,

                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),

                itemCount:
                    galleryState.images.length,

                itemBuilder:
                    (context, index) {

                  final image =
                      galleryState
                          .images[index];

                  return Card(
                    clipBehavior:
                        Clip.antiAlias,

                    child: Image.network(
                      image.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

























































































































































