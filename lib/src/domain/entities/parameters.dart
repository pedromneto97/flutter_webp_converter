class Parameters {
  final bool multiThreading;
  final bool lossless;
  final int compressionMethod;
  final int quality;
  final String outputFolder;

  const Parameters({
    required this.outputFolder,
    this.multiThreading = true,
    this.lossless = false,
    this.compressionMethod = 6,
    this.quality = 75,
  })  : assert(compressionMethod >= 1 && compressionMethod <= 6),
        assert(quality >= 0 && quality <= 100);

  Parameters copyWith({
    bool? multiThreading,
    bool? lossless,
    int? compressionMethod,
    int? quality,
    String? outputFolder,
  }) =>
      Parameters(
        multiThreading: multiThreading ?? this.multiThreading,
        lossless: lossless ?? this.lossless,
        compressionMethod: compressionMethod ?? this.compressionMethod,
        quality: quality ?? this.quality,
        outputFolder: outputFolder ?? this.outputFolder,
      );
}
