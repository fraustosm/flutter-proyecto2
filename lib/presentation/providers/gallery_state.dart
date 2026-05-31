import '../../data/models/image_model.dart';

class GalleryState {
  final List<ImageModel> images;
  final bool isLoading;
  final String? error;
  final int page;
  final String query;

  const GalleryState({
    required this.images,
    required this.isLoading,
    required this.error,
    required this.page,
    required this.query,
  });

  factory GalleryState.initial() {
    return const GalleryState(
      images: [],
      isLoading: false,
      error: null,
      page: 1,
      query: '',
    );
  }

  GalleryState copyWith({
    List<ImageModel>? images,
    bool? isLoading,
    String? error,
    int? page,
    String? query,
  }) {
    return GalleryState(
      images: images ?? this.images,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      page: page ?? this.page,
      query: query ?? this.query,
    );
  }
}