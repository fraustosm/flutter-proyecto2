import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/unsplash_service.dart';
import '../../data/repositories/gallery_repository_impl.dart';
import 'gallery_state.dart';
import '../../data/models/image_model.dart';

final galleryProvider =
    StateNotifierProvider<GalleryNotifier, GalleryState>((ref) {
  return GalleryNotifier();
});

class GalleryNotifier extends StateNotifier<GalleryState> {
  GalleryNotifier()
      : super(
          GalleryState.initial(),
        ) {
    loadImages();
  }

  final repository = GalleryRepositoryImpl(
    UnsplashService(),
  );

  Future<void> loadImages() async {
    try {
      state = state.copyWith(
        isLoading: true,
        error: null,
      );

      final images = await repository.getPhotos(
        page: 1,
      );

      state = state.copyWith(
        images: images,
        isLoading: false,
        page: 1,
        query: '',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> searchImages(
    String query,
  ) async {
    try {
      state = state.copyWith(
        isLoading: true,
        query: query,
        error: null,
      );

      final images =
          await repository.searchPhotos(
        query: query,
        page: 1,
      );

      state = state.copyWith(
        images: images,
        isLoading: false,
        page: 1,
        query: query,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> loadMore() async {
    try {
      final nextPage = state.page + 1;

      List<ImageModel> newImages;

      if (state.query.isNotEmpty) {
        newImages =
            await repository.searchPhotos(
          query: state.query,
          page: nextPage,
        );
      } else {
        newImages =
            await repository.getPhotos(
          page: nextPage,
        );
      }

      state = state.copyWith(
        page: nextPage,
        images: [
          ...state.images,
          ...newImages,
        ],
      );
    } catch (_) {}
  }
}







































































