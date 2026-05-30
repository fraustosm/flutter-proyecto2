import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/unsplash_service.dart';
import '../../data/repositories/gallery_repository_impl.dart';
import 'gallery_state.dart';

final galleryProvider =
    StateNotifierProvider<
        GalleryNotifier,
        GalleryState>((ref) {
  return GalleryNotifier();
});

class GalleryNotifier
    extends StateNotifier<GalleryState> {

  GalleryNotifier()
      : super(
          GalleryState.initial(),
        );

}

