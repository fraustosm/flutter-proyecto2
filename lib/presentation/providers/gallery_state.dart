import '../../data/models/image_model.dart';

class GalleryState {
  final List<ImageModel> images;
  final bool isLoading;
  final String? error;

  const GalleryState({
    required this.images,
    required this.isLoading,
    this.error,
  });

  factory GalleryState.initial() {
    return const GalleryState(
      images: [],
      isLoading: false,
      error: null,
    );
  }

  GalleryState copyWith({
    List<ImageModel>? images,
    bool? isLoading,
    String? error,
  }) {
    return GalleryState(
      images: images ?? this.images,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}