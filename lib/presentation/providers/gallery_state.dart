import '../../data/models/image_model.dart';

class GalleryState {
  final List<ImageModel> images;
  final bool isLoading;
  final String? error;
  final int page;
  final String query;
  final bool isOffline;

  const GalleryState({
    required this.images,
    required this.isLoading,
    required this.error,
    required this.page,
    required this.query,
    required this.isOffline,
  });

  factory GalleryState.initial() {
    return const GalleryState(
      images: [],
      isLoading: false,
      error: null,
      page: 1,
      query: '',
      isOffline: false,
    );
  }

  GalleryState copyWith({
    List<ImageModel>? images,
    bool? isLoading,
    String? error,
    int? page,
    String? query,
    bool? isOffline,
  }) {
    return GalleryState(
      images: images ?? this.images,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      page: page ?? this.page,
      query: query ?? this.query,
      isOffline: isOffline ?? this.isOffline,
    );
  }
}




































