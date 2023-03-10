final String _base_url = "https://www.cherngtalaymuni.go.th/onestopservice/";
final String _base_url_api = "https://www.cherngtalaymuni.go.th/onestopservice/app_api_v1";
final String _base_url_api_v2 = "https://www.cherngtalaymuni.go.th/onestopservice/app_api_v2";

class Info {
  String baseUrl = _base_url;
  //CheckVersion APP
  String checkversion = _base_url_api + '/checkAppVersion';
  String checkisPrivate = _base_url_api + '/isPrivate';
  //pity
  String newsList = _base_url_api + '/newsList';
  String newsDetail = _base_url_api + '/newsDetail';
  String galleryList = _base_url_api + '/galleryList';
  String galleryDetail = _base_url_api + '/galleryDetail';
  String ExerList = _base_url_api + '/exerciseList';
  String ExerDetail = _base_url_api + '/exerciseDetail';
  String videoList = _base_url_api + '/videoList';
  String videoDetail = _base_url_api + '/videoDetail'; //Hit
  String ebookList = _base_url_api + '/ebookList';
  String ebookDetail = _base_url_api + '/ebookDetail'; //Hit
  String contactCity = _base_url_api + '/contactCity';
  String checkAppVersion = _base_url_api + '/checkAppVersion';
  String contactusAdd = _base_url_api + '/contactusAdd';
  String contactusList = _base_url_api + '/contactusList';
  String informList = _base_url_api + '/informList';
  String informDetail = _base_url_api + '/informDetail';
  String updateUserFullname = _base_url_api + '/updateUserFullname';
  String siteDetail = _base_url_api + '/siteDetail';
  String travelList = _base_url_api + '/travelList';
  String travelDetail = _base_url_api + '/travelDetail';
  String restList = _base_url_api + '/restList';
  String restDetail = _base_url_api + '/restDetail';
  String eatList = _base_url_api + '/eatList';
  String eatDetail = _base_url_api + '/eatDetail';
  String shopList = _base_url_api + '/shopList';
  String shopDetail = _base_url_api + '/shopDetail';
  String callCateList = _base_url_api + '/callCateList';
  String callList = _base_url_api + '/callList';
  String callDetail = _base_url_api + '/callDetail';
  String callEdit = _base_url_api + '/insertEditDetail';
  String serviceGuideCateList = _base_url_api + '/serviceGuideCateList';
  String serviceGuideList = _base_url_api + '/serviceGuideList';
  String serviceGuideDetail = _base_url_api + '/serviceGuideDetail';
  String newsDocumentList = _base_url_api + '/newsDocumentList';
  String newsDocumentDetail = _base_url_api + '/newsDocumentDetail';
  String cateList = _base_url_api + '/cateList'; //????????????????????????????????? cmd ??????
  String cateSubList = _base_url_api + '/cateSubList'; //????????????????????????????????? cmd ??????
  String cateAllList = _base_url_api + '/cateAllList'; //????????????????????????????????? cmd ??????
  String serviceDescription = _base_url_api + '/serviceDescription';
  String serviceSubject = _base_url_api + '/serviceSubject';
  String eventsList = _base_url_api + '/eventsList';
  String eventsDetail = _base_url_api + '/eventsDetail';
  String cateInformList = _base_url_api + '/cateInformList';
  String cateInformStatusList = _base_url_api + '/cateInformStatusList';
  String informAdd = _base_url_api + '/informAdd';
  String informUpdate = _base_url_api + '/informUpdate';
  String pollVote = _base_url_api + '/pollVote';

  String userLogin = _base_url_api + '/userLogin';
  String checkCitizenID = _base_url_api + '/checkCitizenID';
  String updateCitizenID = _base_url_api + '/updateCitizenID';
  String checkHavePhone = _base_url_api + '/checkHavePhone';
  String changePassword = _base_url_api + '/changePassword';
  String changePhone = _base_url_api + '/changePhone';
  String setOtp = _base_url_api + '/setOtp';
  String checkOtp = _base_url_api + '/checkOtp';
  String changePasswordOtp = _base_url_api + '/changePasswordOtp';
  String userRegistAdd = _base_url_api + '/userRegistAdd';
  String checkUserPhone = _base_url_api + '/checkUserPhone';
  String messageList = _base_url_api + '/messageList';
  String bannerList = _base_url_api + '/bannerList';
  String linkProvinceList = _base_url_api + '/linkProvinceList';
  String notiList = _base_url_api + '/notiList';
  String informFinishList = _base_url_api + '/informFinishList';
  String commentAdd = _base_url_api + '/commentAdd';
  String commentList = _base_url_api + '/commentList';
  String addLove = _base_url_api + '/addLove';
  String removeLove = _base_url_api + '/removeLove';
  String checkHasUser = _base_url_api + '/checkHasUser';
  String checkConnectedUser = _base_url_api + '/checkConnectedUser';
  String cancelContectUser = _base_url_api + '/cancelContectUser';
  String pm25 = _base_url_api + '/pm_data';
  String weatherApi = 'https://api.cityvariety.com/weather/json.php?id=1608133';
  String weatherListApi =
      'https://api.cityvariety.com/weather/json.php?type=forecast&fnList=tempList&id=1608133';

  String cateListPity = _base_url_api + '/cateListPity';
  String insertMarketAndProduct = _base_url_api + '/insertMarketAndProduct';
  String getShopDetail = _base_url_api + '/getShopDetail';
  String marketList = _base_url_api + '/marketList';
  String marketDetail = _base_url_api + '/marketDetail';
  String nearMe = _base_url_api + '/nearMe';

  //inform v2
  String informAdd2 = _base_url_api_v2 + '/informAdd';

  String contentPrivacyPolicy = _base_url_api + '/contentPrivacyPolicy';
  String getAcceptPrivacyPolicy = _base_url_api + '/getAcceptPrivacyPolicy';
  String setAcceptPrivacyPolicy = _base_url_api + '/setAcceptPrivacyPolicy';

  Info() : super();
}
