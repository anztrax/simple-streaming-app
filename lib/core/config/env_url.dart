class EnvUrl{
  final String baseUrl;

  EnvUrl({
    this.baseUrl
  });

  factory EnvUrl.isProd(){
    return EnvUrl(
      baseUrl: 'https://itunes.apple.com',
    );
  }

  factory EnvUrl.isStaging(){
    return EnvUrl(
      baseUrl: 'https://itunes.apple.com',
    );
  }

  factory EnvUrl.isDevelopment(){
    return EnvUrl(
      baseUrl: 'https://itunes.apple.com',
    );
  }
}