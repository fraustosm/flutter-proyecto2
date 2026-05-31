import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/unsplash_service.dart';
import '../../data/repositories/gallery_repository_impl.dart';
import 'gallery_state.dart';
import '../../data/models/image_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

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

  Future<bool> hasConnection() async {
    final connectivityResult =
        await Connectivity().checkConnectivity();

    return connectivityResult !=
        ConnectivityResult.none;
  }

  Future<void> loadImages() async {
    try {
      final connected =
          await hasConnection();

      if (!connected) {
        state = state.copyWith(
          isOffline: true,
          isLoading: false,
        );

        return;
      }

      state = state.copyWith(
        isLoading: true,
        error: null,
        isOffline: false,
      );

      final images =
          await repository.getPhotos(
        page: 1,
      );

      state = state.copyWith(
        images: images,
        isLoading: false,
        page: 1,
        query: '',
      );
     } on DioException catch (_) {

  state = state.copyWith(
    isLoading: false,
    error: 'No se puede conectar a Unsplash',
  );

} catch (_) {

  state = state.copyWith(
    isLoading: false,
    error: 'Un error inesperado ocurrió',
  );
} 
  }

  Future<void> searchImages(
    String query,
  ) async {
    try {
      final connected =
          await hasConnection();

      if (!connected) {
        state = state.copyWith(
          isOffline: true,
          isLoading: false,
        );

        return;
      }

      state = state.copyWith(
        isLoading: true,
        query: query,
        error: null,
        isOffline: false,
      );

      final images =
          await repository.searchPhotos(
        query: query,
        page: 1,
      );

      if (images.isEmpty) {

  state = state.copyWith(
    images: [],
    isLoading: false,
    error: 'No images found',
  );

  return;
}

      state = state.copyWith(
        images: images,
        isLoading: false,
        page: 1,
        query: query,
      );
    } on DioException catch (_) {
      state = state.copyWith(
        isLoading: false,
        error: 'No se puede conectar a Unsplash',
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        error: 'Un error inesperado ocurrió',
      );
    }
  }

  Future<void> loadMore() async {
    try {
      final connected =
          await hasConnection();

      if (!connected) {
        return;
      }

      final nextPage =
          state.page + 1;

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