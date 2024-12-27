class Parameters {
  const Parameters({
    required this.outputFolder,
    this.multiThreading = true,
    this.lossless = false,
    this.compressionMethod = 6,
    this.quality = 75,
  })  : assert(
          compressionMethod >= 1 && compressionMethod <= 6,
          'Compression method must be between 1 and 6',
        ),
        assert(
          quality >= 0 && quality <= 100,
          'Quality must be between 0 and 100',
        );

  final bool multiThreading;
  final bool lossless;
  final int compressionMethod;
  final int quality;
  final String outputFolder;

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
