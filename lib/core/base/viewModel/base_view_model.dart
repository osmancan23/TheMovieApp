import 'package:flutter/material.dart';

/// Tüm view model'lar için temel sınıf
/// Bu sınıf, ortak özellikleri ve metodları içerir
abstract class IBaseViewModel extends ChangeNotifier {
  IBaseViewModel() {
    _init();
  }

  /// MARK: Viewmodel içerisindeki context kullanmamız gereken durumlarda
  BuildContext? context;
  // ignore: public_member_api_docs, use_setters_to_change_properties
  void setContext(BuildContext context) => this.context = context;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// View model başlatıldığında çalışır
  void _init() {
    onInit();
  }

  /// View model başlatıldığında çalışacak metod
  /// Alt sınıflar bu metodu override edebilir

  void onInit() {}

  /// Hata mesajını gösterir
  void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  /// Başarı mesajını gösterir
  void showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  /// Bilgi mesajını gösterir
  void showInfo(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blue,
      ),
    );
  }

  /// View model dispose edildiğinde çalışır
  @override
  void dispose() {
    onDispose();
    super.dispose();
  }

  /// View model dispose edildiğinde çalışacak metod
  /// Alt sınıflar bu metodu override edebilir
  void onDispose() {}
}
