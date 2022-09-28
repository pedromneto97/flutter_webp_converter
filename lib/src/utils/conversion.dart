extension ConvertByteToReadableFormat on int {
  String get byteToString {
    const byte = 1;
    const kiloByte = byte << 10;
    const megaByte = kiloByte << 10;
    const gigaByte = megaByte << 10;

    if (this > gigaByte) {
      return _formatSize(this, gigaByte, 'GB');
    }
    if (this > megaByte) {
      return _formatSize(this, megaByte, 'KB');
    }
    if (this > kiloByte) {
      return _formatSize(this, kiloByte, 'KB');
    }
    return _formatSize(this, byte, 'B');
  }
}

String _formatSize(int size, int divider, String unit) => '${(size / divider).toStringAsFixed(2)} $unit';
