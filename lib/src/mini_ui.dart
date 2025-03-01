import 'package:web/web.dart';

void addButton(String text, void Function() onClick) {
  final button = HTMLButtonElement();
  button.textContent = text;
  button.onClick.listen((event) {
    onClick();
  });
  document.body!.append(button);
}
