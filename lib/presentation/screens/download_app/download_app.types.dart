class DownloadAppViewModel {
  DownloadAppViewModel({
    required this.appList,
    required this.onNavigateDownloadAndroid,
    required this.onNavigateDownloadIOs,
  });

  List<DownloadApp> appList;
  Function(String appPackageName) onNavigateDownloadAndroid;
  Function(String appPackageName) onNavigateDownloadIOs;
}

class DownloadApp {
  DownloadApp({
    required this.title,
    required this.urlImage,
    required this.iOSId,
    required this.AndroidId,
    required this.messageDownload,
  });

  String title;
  String urlImage;
  String iOSId;
  String AndroidId;
  String messageDownload;
}
