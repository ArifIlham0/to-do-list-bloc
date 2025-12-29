class Api {
  static const baseURL = "https://fb87e27a568f.ngrok-free.app/api/to-do-list-django/v1";
}

final Map<String, String> headersNoToken = {
  'Content-Type': 'application/json',
};

final Map<String, String> headersFormDataNoToken = {
  'Content-Type': 'multipart/form-data',
};

Map<String, String> headersWithToken(String token) {
  return {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
}

Map<String, String> headersFormDataWithToken(String token) {
  return {
    'Content-Type': 'multipart/form-data',
    'Authorization': 'Bearer $token',
  };
}