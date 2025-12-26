class Api {
  static const baseURL = "https://sea-turtle-app-qjo2r.ondigitalocean.app/api";
}

final Map<String, String> headersNoToken = {
  'Content-Type': 'application/json',
};

Map<String, String> headerWithToken(String token) {
  return {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
}
