import 'dart:io';

void main() async {
  final f1 = File('assets/images/char/Idle/1.png');
  // Just checking file sizes as a proxy, wait we can't easily parse headers in raw dart without a lib unless we use basic byte parsing for PNG.
  // PNG dimensions: bytes 16-23 are width and height.
  if (f1.existsSync()) {
    final bytes = await f1.readAsBytes();
    if (bytes.length > 24 && bytes[0] == 0x89 && bytes[1] == 0x50 && bytes[2] == 0x4E && bytes[3] == 0x47) {
      final width = (bytes[16] << 24) | (bytes[17] << 16) | (bytes[18] << 8) | bytes[19];
      final height = (bytes[20] << 24) | (bytes[21] << 16) | (bytes[22] << 8) | bytes[23];
      print('Idle/1.png dimensions: $width x $height');
    }
  }

  final f2 = File('assets/images/char/Pink_Monster_Idle_4.png');
  if (f2.existsSync()) {
    final bytes = await f2.readAsBytes();
    if (bytes.length > 24 && bytes[0] == 0x89) {
      final width = (bytes[16] << 24) | (bytes[17] << 16) | (bytes[18] << 8) | bytes[19];
      final height = (bytes[20] << 24) | (bytes[21] << 16) | (bytes[22] << 8) | bytes[23];
      print('Pink_Monster_Idle_4.png dimensions: $width x $height');
    }
  }
}
