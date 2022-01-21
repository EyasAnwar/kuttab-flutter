class ApiSettings {

  //Auth Request
  static const String _BASE_URL = 'https://www.demo.com';
  static const String LOGIN = _BASE_URL + "auth/login";
  static const String LOGOUT = _BASE_URL + "auth/logout";
  static const String REGISTER = _BASE_URL + "auth/register";
  static const String RESET_PASSWORD = _BASE_URL + "auth/reset-password";
  static const String FORGET_PASSWORD = _BASE_URL + "auth/forget-password";
  static const String ACTIVATE_ACCOUNT = _BASE_URL + "auth/activate";
  static const String CHANGE_PASSWORD = _BASE_URL + "auth/change-password";
  static const String CONTACT_US = _BASE_URL + "contact-requests";
  static const String UPDATE_PROFILE = _BASE_URL + "auth/update-profile";
  static const String HOME = _BASE_URL + "home";
  static const String REFRESHFCMTOKEN = _BASE_URL + "/auth/refresh-fcm-token";
  static const String NOTIFICATION = _BASE_URL + "notifications";


  //Cities Request
  static const String CITIES = _BASE_URL + "cities";

  //category Req && sub category
  static const String CATEGORY = _BASE_URL + "categories";

  //product re
  static const String PRODUCT = _BASE_URL + "sub-categories";
  static const String PRODUCT_DETAILS = _BASE_URL + "products";
  static const String FAVORITE_PRODUCT = _BASE_URL + "favorite-products";
  static const String RATTING_PRODUCT = _BASE_URL + "products/rate";
  //order
  static const String ORDER = _BASE_URL + "orders";




  //card
  static const String CARD = _BASE_URL + "payment-cards";

//address

  static const String ADDRESS = _BASE_URL + "addresses";
}