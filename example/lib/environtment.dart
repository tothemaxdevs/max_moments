class Environment {
  static String blogUrl = 'https://$env.orderia.id/blog';
  static const String tosUrl = 'http://192.168.1.48:3002/modules/term/pages';
  static String helpCenter = 'https://$env.orderia.id/modules/helper/pages';
  static const String apikey = '0f99beea-bfbf-11ec-9708-ef87d9a9c4d9';

  //lokal
  // static const String endpointApi =
  //     'https://zpr3lc4k-8082.asse.devtunnels.ms/api/';
  // static const String endpointApiPayment =
  //     'https://zpr3lc4k-8084.asse.devtunnels.ms/api/';

  static bool isDev = false;

  static String env = isDev ? 'dev' : 'stg';

  // server
  static String endpointApi = 'https://customer.backend.$env.orderia.id/api/';
  static String endpointApiPayment = 'https://payment.$env.orderia.id/api/v1/';
  static String messageGateWay = 'https://message.$env.orderia.id';
  static String linkGateWay = 'https://link.backend.$env.orderia.id/api/v1/';
  static String authGateWay = 'https://auth.backend.$env.orderia.id/api/v1/';
  static String contentGateWay = 'https://content.$env.orderia.id/api/';

  static String svgAssets = 'assets/';
  static String imgAssets = 'assets/images/';
  static String geoApiKey = 'AIzaSyCbo7jjDTdFANGzFcWCc9MwXsmID-OXgiQ';
  static String fileGateWay =
      'https://file.$env.orderia.id/api/v1/file-gateway';
  static String fileGateWay2 = 'https://file.$env.orderia.id/api/v1/';
}
