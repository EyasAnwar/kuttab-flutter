class ApiSettings {

  //Auth Request
  static const String BASE_URL = 'https://kuttab.sirius-it.dev/';
  static const String LOGIN = BASE_URL + "api/v1/auth/user/login";
  static const String TEACHER_STUDENT = BASE_URL + "api/v1/teacher/2/students";
  static const String LOGOUT = BASE_URL + "api/v1/auth/logout";
  static const String PARENT_CHILDREN = BASE_URL + "api/v1/parent/1/children";
  static const String ATTENDANCE = BASE_URL + "api/v1/attendance";
  static const String SEARCH = BASE_URL + "api/v1/student/search/byUsername";
  static const String DAILY_RECORD = BASE_URL + "api/v1/dailyRecord";
  static const String RESONE = BASE_URL + "api/v1/attendanceReasons";


  //Cities Request
  static const String CITIES = BASE_URL + "cities";

  //category Req && sub category
  static const String CATEGORY = BASE_URL + "categories";

  //product re
  static const String PRODUCT = BASE_URL + "sub-categories";
  static const String PRODUCT_DETAILS = BASE_URL + "products";
  static const String FAVORITE_PRODUCT = BASE_URL + "favorite-products";
  static const String RATTING_PRODUCT = BASE_URL + "products/rate";
  //order
  static const String ORDER = BASE_URL + "orders";




  //card
  static const String CARD = BASE_URL + "payment-cards";

//address

  static const String ADDRESS = BASE_URL + "addresses";
}