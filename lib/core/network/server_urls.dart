enum ServerUrls {
  base(null),
  companies(null),
  locations('/locations'),
  assets('/assets');

  const ServerUrls(this._path) : _baseUrl = _ServerInstance.baseUrl;

  final String _baseUrl;
  final String? _path;

  String get path => _path ?? '';
  String get url => '$_baseUrl$path';
  String idUrl(String id) => '$_baseUrl/$id$path';  
}


final class _ServerInstance {
  static const dev = 'https://fake-api.tractian.com/companies';

  static const baseUrl = dev;
}
