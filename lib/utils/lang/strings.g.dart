/// Generated file. Do not edit.
///
/// Original: lib/utils/lang
/// To regenerate, run: `dart run slang`
///
/// Locales: 2
/// Strings: 296 (148 per locale)
///
/// Built on 2024-06-25 at 21:22 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
	en(languageCode: 'en', build: Translations.build),
	tr(languageCode: 'tr', build: _StringsTr.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, Translations> build;

	/// Gets current instance managed by [LocaleSettings].
	Translations get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
Translations get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class TranslationProvider extends BaseTranslationProvider<AppLocale, Translations> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, Translations> of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	Translations get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, Translations> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	String hello({required Object name}) => 'Hello ${name}';
	String get login => 'Login';
	late final _StringsLoginStateEn loginState = _StringsLoginStateEn._(_root);
	String get logout => 'Logout';
	String get getStarted => 'Get Started';
	String get email => 'Email';
	String get password => 'Password';
	String get forgotPw => 'Forgot Password';
	String get appIntro => 'intro about the app xxxx xxx xx xxxxx include by mentioning the name of the app';
	String get save => 'Save';
	String get dontHaveAccount => 'Don’t have an account?';
	String get register => 'Sign Up';
	String get yourAccountDeleted => 'Your Account Successfully Deleted';
	String get privacyPolicy => 'Privacy Policy';
	String get termsOfUse => 'Terms of Use';
	String get notification => 'Notification';
	String get sound => 'Sound';
	String get vibration => 'Vibration';
	String get willBeImplemented => 'Will Be Implemented Soon';
	String get chatHistory => 'Chat History';
	String get deleteAccount => 'Delete Account';
	String get helpCenter => 'Help Center';
	String get aboutLoveLens => 'About (Love Lens)';
	String get name => 'Name';
	String get lastName => 'Last Name';
	String get about => 'About';
	String get birthDate => 'Birth Date';
	String get location => 'Location';
	String get next => 'Next';
	String get done => 'Done';
	String get noFaceDetected => 'No face detected in the image. Try Again';
	String get above18 => 'You need to be above 18.';
	String get validationProfile => 'Picture, Name, Last Name and Birth Date are required.';
	String get infoAboutYou => 'Info About Yourself';
	String get gender => 'Gender';
	List<String> get genderList => [
		'Male',
		'Female',
	];
	String get hobbies => 'Hobbies & Interests';
	List<String> get hobbyList => [
		'Wrestling',
		'Sailing',
		'Triathlon',
		'Sauna',
		'Comedy',
		'Gym & Fitness',
		'Gaming',
		'Book',
		'Cripto',
		'NFT',
		'Football',
		'Basketball',
		'Volleyball',
		'Gliding',
		'Climbing',
		'Diving',
		'Movies',
		'Tv Shows',
		'Anime',
		'Technology',
		'Music',
		'Traveling',
		'Cooking',
		'Meditation',
		'Hunting',
		'Swimming',
	];
	String get interestedGender => 'Interested Gender';
	String get sexualOrientation => 'Sexual Orientation';
	List<String> get sexualOrientationList => [
		'Straight',
		'Gay',
		'Lesbian',
		'Bisexual',
		'Asexual',
		'Demisexual',
		'Pansexual',
		'Bicurious',
		'Queer',
	];
	String get lookingFor => 'Looking For';
	List<String> get lookingForList => [
		'Long-term Partner',
		'Short-term Partner',
		'Long-term Open Relationship',
		'Short-term Open Relationship',
		'New Friens',
		'Still Figuring It Out',
	];
	String get discover => 'Discover';
	String get profile => 'Profile';
	String get updateProfile => 'Update Profile';
	String get likes => 'Likes';
	String get messages => 'Messages';
	String get chat => 'Chat';
	String get room => 'Room';
	String get error => 'Error';
	String get checkYourEmail => 'Please Check Your Email!';
	String get loginFailed => 'Login Failed';
	String get close => 'Close';
	String get registerFailed => 'Register Failed';
	String get microphonePermissionNotGranted => 'Microphone permission not granted';
	String get errorUploadingImage => 'Error uploading image';
	String get cantSendImage => 'You can\'t Send Image';
	String get userCantRecieveImages => 'The other user can\'t receive images.';
	String get ok => 'Okay';
	String get recieveImageTitle => 'Do You Want To Recieve Image';
	String recieveImageBody({required Object firstName}) => '${firstName} wants to send image.Go ahead and open it on your settings';
	String get errorUploadingVideo => 'Error uploading video';
	String get cantSendVideo => 'You can\'t Send Video';
	String get userCantRecieveVideos => 'The other user can\'t receive videos.';
	String get recieveVideoTitle => 'Do You Want To Recieve Video';
	String recieveVideoBody({required Object firstName}) => '${firstName} wants to send video.Go ahead and open it on your settings';
	String get errorUploadingAudio => 'Error uploading audio';
	String get cantSendAudio => 'You can\'t Send Audio';
	String get userCantRecieveAudios => 'The other user can\'t receive audios.';
	String get recieveAudioTitle => 'Do You Want To Recieve Audio';
	String recieveAudioBody({required Object firstName}) => '${firstName} wants to send audio.Go ahead and open it on your settings';
	String get requestSended => 'Your request has been send';
	String get sendRequest => 'Send Request';
	String get cancel => 'Cancel';
	String get photo => 'Photo';
	String get audio => 'Audio';
	String get video => 'Video';
	String get recording => 'Recording...';
	String get recordingInProgress => 'Recording in progress...';
	String get stopRecording => 'Stop Recording';
	String get filter => 'Filter';
	String get noDataAvailable => 'No Data Available';
	String get noRooms => 'No rooms';
	String get cantFindRoom => 'Chat room can\'t be found';
	String get yearsOld => 'years old';
	String get recievingSettings => 'Recieving Image/Audio/Video';
	String get verification => 'Verification';
	String get kmAway => 'Km Away';
	String get resend => 'Resend';
	String get noProfile => 'Hi unfortunately there isn\'t any cool person in here yet, check later on';
	String get checkYourMail => 'Check your Email';
	String sendedMail({required Object email}) => 'We have sent you a mail on ${email}';
	String get verifyingEmail => 'Verifying email..';
	String get emailVerified => 'Email Verified';
	String get recieveSettings => 'Recieving Image/Audio/Video Settings';
	String get recieveImage => 'Receive Images';
	String get recieveAudio => 'Receive Audios';
	String get recieveVideo => 'Receive Videos';
	String get accountVerified => 'Your account is verified succesfully';
	String get matches => 'Matches';
	String get likesYou => 'Likes You';
	String get yourLikes => 'Your Likes';
	String get yourMatches => 'Your Matches';
	String get subscriptionToSeeTitle => 'To See This Profile';
	String get subscriptionToSeeBody => 'You Need to Subscribe';
	String get readyToRecord => 'Ready to Record';
	String get startRecording => 'Start Recording';
}

// Path: loginState
class _StringsLoginStateEn {
	_StringsLoginStateEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get success => 'Logged in successfully';
	String get fail => 'Logged in failed';
}

// Path: <root>
class _StringsTr implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsTr.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.tr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <tr>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _StringsTr _root = this; // ignore: unused_field

	// Translations
	@override String hello({required Object name}) => 'Merhaba ${name}';
	@override String get login => 'Giriş';
	@override late final _StringsLoginStateTr loginState = _StringsLoginStateTr._(_root);
	@override String get logout => 'Çıkış';
	@override String get getStarted => 'Başlayalım';
	@override String get email => 'E-posta';
	@override String get password => 'Şifre';
	@override String get forgotPw => 'Şifremi Unuttum';
	@override String get appIntro => 'Uygulama hakkında giriş metni xxxx xxx xx xxxxx uygulama adını belirterek dahil edin';
	@override String get save => 'Kaydet';
	@override String get dontHaveAccount => 'Hesabınız yok mu?';
	@override String get register => 'Kayıt Ol';
	@override String get name => 'İsim';
	@override String get lastName => 'Soyadı';
	@override String get about => 'Hakkında';
	@override String get birthDate => 'Doğum Tarihi';
	@override String get location => 'Konum';
	@override String get next => 'İleri';
	@override String get done => 'Tamam';
	@override String get noFaceDetected => 'Yüzünüz tespit edilemedi. Tekrar Deneyin';
	@override String get above18 => '18 yaşından büyük olmalısın.';
	@override String get validationProfile => 'Fotoğraf, İsim, Soyisim ve Doğum Tarihi alanları zorunludur.';
	@override String get infoAboutYou => 'Hakkındaki Bilgiler';
	@override String get privacyPolicy => 'Gizlilik Politikası';
	@override String get termsOfUse => 'Kullanım Koşulları';
	@override String get notification => 'Bildirim';
	@override String get yourAccountDeleted => 'Hesabınız Başarıyla Silindi.';
	@override String get sound => 'Ses';
	@override String get vibration => 'Titreşim';
	@override String get willBeImplemented => 'Yakında Uygulanacak';
	@override String get chatHistory => 'Sohbet Geçmişi';
	@override String get deleteAccount => 'Hesabı Sil';
	@override String get helpCenter => 'Yardım Merkezi';
	@override String get aboutLoveLens => 'Hakkında (Love Lens)';
	@override String get gender => 'Cinsiyet';
	@override List<String> get genderList => [
		'Erkek',
		'Kadın',
	];
	@override String get hobbies => 'Hobiler & İlgi Alanları';
	@override List<String> get hobbyList => [
		'Güreş',
		'Yelkencilik',
		'Triatlon',
		'Sauna',
		'Komedi',
		'Spor Salonu & Fitness',
		'Oyun',
		'Kitap',
		'Kripto',
		'NFT',
		'Futbol',
		'Basketbol',
		'Voleybol',
		'Planörle Uçuş',
		'Dağcılık',
		'Dalış',
		'Filmler',
		'TV Programları',
		'Anime',
		'Teknoloji',
		'Müzik',
		'Seyahat',
		'Yemek Pişirme',
		'Meditasyon',
		'Avcılık',
		'Yüzme',
	];
	@override String get interestedGender => 'İlgilenilen Cinsiyet';
	@override String get sexualOrientation => 'Cinsel Yönelim';
	@override List<String> get sexualOrientationList => [
		'Heteroseksüel',
		'Eşcinsel',
		'Lezbiyen',
		'Biseksüel',
		'Aseksüel',
		'Demiseksüel',
		'Panseksüel',
		'Bikürsüel',
		'Queer',
	];
	@override String get lookingFor => 'Aranan';
	@override List<String> get lookingForList => [
		'Uzun Vadeli Partner',
		'Kısa Vadeli Partner',
		'Uzun Vadeli Açık İlişki',
		'Kısa Vadeli Açık İlişki',
		'Yeni Arkadaşlar',
		'Hala Anlamaya Çalışıyorum',
	];
	@override String get discover => 'Keşfet';
	@override String get profile => 'Profil';
	@override String get updateProfile => 'Profil Güncelle';
	@override String get likes => 'Beğeniler';
	@override String get messages => 'Mesajlar';
	@override String get chat => 'Sohbet';
	@override String get room => 'Oda';
	@override String get error => 'Hata';
	@override String get checkYourEmail => 'Lütfen Mail Adresinizi Kontrol Edin!';
	@override String get loginFailed => 'Girişte bir hata ile karşılaşıldı';
	@override String get close => 'Kapat';
	@override String get registerFailed => 'Kayıtta bir hata ile karşılaşıldı';
	@override String get microphonePermissionNotGranted => 'Mikrofon izni verilmedi.';
	@override String get errorUploadingImage => 'Resim yüklenirken bir hata ile karşılaşıldı';
	@override String get cantSendImage => 'Resim Gönderemezsin';
	@override String get userCantRecieveImages => 'Diğer kullanıcıya resim gönderemezsin';
	@override String get ok => 'Tamam';
	@override String get recieveImageTitle => 'Görüntü Almak İster Misiniz?';
	@override String recieveImageBody({required Object firstName}) => '${firstName} görüntü göndermek istiyor. Ayarlarınızda açabilirsiniz.';
	@override String get errorUploadingVideo => 'Video yüklenirken hata oluştu.';
	@override String get cantSendVideo => 'Video gönderemezsiniz.';
	@override String get userCantRecieveVideos => 'Diğer kullanıcı videoları alamaz.';
	@override String get recieveVideoTitle => 'Video Almak İster Misiniz?';
	@override String recieveVideoBody({required Object firstName}) => '${firstName} video göndermek istiyor. Ayarlarınızda açabilirsiniz.';
	@override String get errorUploadingAudio => 'Ses yüklenirken hata oluştu.';
	@override String get cantSendAudio => 'Ses gönderemezsiniz.';
	@override String get userCantRecieveAudios => 'Diğer kullanıcı sesleri alamaz.';
	@override String get recieveAudioTitle => 'Ses Almak İster Misiniz?';
	@override String recieveAudioBody({required Object firstName}) => '${firstName} ses göndermek istiyor. Ayarlarınızda açabilirsiniz.';
	@override String get requestSended => 'İsteğiniz gönderildi.';
	@override String get sendRequest => 'İsteği Gönder';
	@override String get cancel => 'İptal';
	@override String get photo => 'Fotoğraf';
	@override String get audio => 'Ses';
	@override String get video => 'Video';
	@override String get recording => 'Kaydediliyor...';
	@override String get recordingInProgress => 'Kayıt yapılıyor...';
	@override String get stopRecording => 'Kaydı Durdur';
	@override String get filter => 'Filtre';
	@override String get noDataAvailable => 'Gösterebileceğimiz bir değer yok';
	@override String get noRooms => 'Oda yok';
	@override String get cantFindRoom => 'Oda bulunamıyor';
	@override String get yearsOld => 'Yaşında';
	@override String get kmAway => 'Km Uzaklıkta';
	@override String get resend => 'Yeniden Gönder';
	@override String get noProfile => 'Maalesef burada henüz harika bir kişi yok, daha sonra kontrol edin.';
	@override String get checkYourMail => 'E-postanızı kontrol edin';
	@override String sendedMail({required Object email}) => 'Size ${email} adresine bir e-posta gönderdik.';
	@override String get verifyingEmail => 'E-posta doğrulanıyor...';
	@override String get emailVerified => 'E-posta doğrulandı.';
	@override String get verification => 'Doğrulama';
	@override String get recievingSettings => 'Fotoğraf/Ses/Video Alımı';
	@override String get recieveSettings => 'Fotoğraf/Ses/Video Ayarlarını Al';
	@override String get recieveImage => 'Resimleri Al';
	@override String get recieveAudio => 'Sesleri Al';
	@override String get recieveVideo => 'Videoları Al';
	@override String get accountVerified => 'Hesabınız başarıyla doğrulandı.';
	@override String get matches => 'Eşleşmeler';
	@override String get likesYou => 'Seni Beğenenler';
	@override String get yourLikes => 'Beğendiklerin';
	@override String get yourMatches => 'Eşleşmelerin';
	@override String get subscriptionToSeeTitle => 'Bu Profili Görmek İçin';
	@override String get subscriptionToSeeBody => 'Abone Olmanız Gerekiyor';
	@override String get readyToRecord => 'Kayda Hazır';
	@override String get startRecording => 'Kayıtı Başlat';
}

// Path: loginState
class _StringsLoginStateTr implements _StringsLoginStateEn {
	_StringsLoginStateTr._(this._root);

	@override final _StringsTr _root; // ignore: unused_field

	// Translations
	@override String get success => 'Başarıyla giriş yapıldı';
	@override String get fail => 'Giriş başarısız';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'hello': return ({required Object name}) => 'Hello ${name}';
			case 'login': return 'Login';
			case 'loginState.success': return 'Logged in successfully';
			case 'loginState.fail': return 'Logged in failed';
			case 'logout': return 'Logout';
			case 'getStarted': return 'Get Started';
			case 'email': return 'Email';
			case 'password': return 'Password';
			case 'forgotPw': return 'Forgot Password';
			case 'appIntro': return 'intro about the app xxxx xxx xx xxxxx include by mentioning the name of the app';
			case 'save': return 'Save';
			case 'dontHaveAccount': return 'Don’t have an account?';
			case 'register': return 'Sign Up';
			case 'yourAccountDeleted': return 'Your Account Successfully Deleted';
			case 'privacyPolicy': return 'Privacy Policy';
			case 'termsOfUse': return 'Terms of Use';
			case 'notification': return 'Notification';
			case 'sound': return 'Sound';
			case 'vibration': return 'Vibration';
			case 'willBeImplemented': return 'Will Be Implemented Soon';
			case 'chatHistory': return 'Chat History';
			case 'deleteAccount': return 'Delete Account';
			case 'helpCenter': return 'Help Center';
			case 'aboutLoveLens': return 'About (Love Lens)';
			case 'name': return 'Name';
			case 'lastName': return 'Last Name';
			case 'about': return 'About';
			case 'birthDate': return 'Birth Date';
			case 'location': return 'Location';
			case 'next': return 'Next';
			case 'done': return 'Done';
			case 'noFaceDetected': return 'No face detected in the image. Try Again';
			case 'above18': return 'You need to be above 18.';
			case 'validationProfile': return 'Picture, Name, Last Name and Birth Date are required.';
			case 'infoAboutYou': return 'Info About Yourself';
			case 'gender': return 'Gender';
			case 'genderList.0': return 'Male';
			case 'genderList.1': return 'Female';
			case 'hobbies': return 'Hobbies & Interests';
			case 'hobbyList.0': return 'Wrestling';
			case 'hobbyList.1': return 'Sailing';
			case 'hobbyList.2': return 'Triathlon';
			case 'hobbyList.3': return 'Sauna';
			case 'hobbyList.4': return 'Comedy';
			case 'hobbyList.5': return 'Gym & Fitness';
			case 'hobbyList.6': return 'Gaming';
			case 'hobbyList.7': return 'Book';
			case 'hobbyList.8': return 'Cripto';
			case 'hobbyList.9': return 'NFT';
			case 'hobbyList.10': return 'Football';
			case 'hobbyList.11': return 'Basketball';
			case 'hobbyList.12': return 'Volleyball';
			case 'hobbyList.13': return 'Gliding';
			case 'hobbyList.14': return 'Climbing';
			case 'hobbyList.15': return 'Diving';
			case 'hobbyList.16': return 'Movies';
			case 'hobbyList.17': return 'Tv Shows';
			case 'hobbyList.18': return 'Anime';
			case 'hobbyList.19': return 'Technology';
			case 'hobbyList.20': return 'Music';
			case 'hobbyList.21': return 'Traveling';
			case 'hobbyList.22': return 'Cooking';
			case 'hobbyList.23': return 'Meditation';
			case 'hobbyList.24': return 'Hunting';
			case 'hobbyList.25': return 'Swimming';
			case 'interestedGender': return 'Interested Gender';
			case 'sexualOrientation': return 'Sexual Orientation';
			case 'sexualOrientationList.0': return 'Straight';
			case 'sexualOrientationList.1': return 'Gay';
			case 'sexualOrientationList.2': return 'Lesbian';
			case 'sexualOrientationList.3': return 'Bisexual';
			case 'sexualOrientationList.4': return 'Asexual';
			case 'sexualOrientationList.5': return 'Demisexual';
			case 'sexualOrientationList.6': return 'Pansexual';
			case 'sexualOrientationList.7': return 'Bicurious';
			case 'sexualOrientationList.8': return 'Queer';
			case 'lookingFor': return 'Looking For';
			case 'lookingForList.0': return 'Long-term Partner';
			case 'lookingForList.1': return 'Short-term Partner';
			case 'lookingForList.2': return 'Long-term Open Relationship';
			case 'lookingForList.3': return 'Short-term Open Relationship';
			case 'lookingForList.4': return 'New Friens';
			case 'lookingForList.5': return 'Still Figuring It Out';
			case 'discover': return 'Discover';
			case 'profile': return 'Profile';
			case 'updateProfile': return 'Update Profile';
			case 'likes': return 'Likes';
			case 'messages': return 'Messages';
			case 'chat': return 'Chat';
			case 'room': return 'Room';
			case 'error': return 'Error';
			case 'checkYourEmail': return 'Please Check Your Email!';
			case 'loginFailed': return 'Login Failed';
			case 'close': return 'Close';
			case 'registerFailed': return 'Register Failed';
			case 'microphonePermissionNotGranted': return 'Microphone permission not granted';
			case 'errorUploadingImage': return 'Error uploading image';
			case 'cantSendImage': return 'You can\'t Send Image';
			case 'userCantRecieveImages': return 'The other user can\'t receive images.';
			case 'ok': return 'Okay';
			case 'recieveImageTitle': return 'Do You Want To Recieve Image';
			case 'recieveImageBody': return ({required Object firstName}) => '${firstName} wants to send image.Go ahead and open it on your settings';
			case 'errorUploadingVideo': return 'Error uploading video';
			case 'cantSendVideo': return 'You can\'t Send Video';
			case 'userCantRecieveVideos': return 'The other user can\'t receive videos.';
			case 'recieveVideoTitle': return 'Do You Want To Recieve Video';
			case 'recieveVideoBody': return ({required Object firstName}) => '${firstName} wants to send video.Go ahead and open it on your settings';
			case 'errorUploadingAudio': return 'Error uploading audio';
			case 'cantSendAudio': return 'You can\'t Send Audio';
			case 'userCantRecieveAudios': return 'The other user can\'t receive audios.';
			case 'recieveAudioTitle': return 'Do You Want To Recieve Audio';
			case 'recieveAudioBody': return ({required Object firstName}) => '${firstName} wants to send audio.Go ahead and open it on your settings';
			case 'requestSended': return 'Your request has been send';
			case 'sendRequest': return 'Send Request';
			case 'cancel': return 'Cancel';
			case 'photo': return 'Photo';
			case 'audio': return 'Audio';
			case 'video': return 'Video';
			case 'recording': return 'Recording...';
			case 'recordingInProgress': return 'Recording in progress...';
			case 'stopRecording': return 'Stop Recording';
			case 'filter': return 'Filter';
			case 'noDataAvailable': return 'No Data Available';
			case 'noRooms': return 'No rooms';
			case 'cantFindRoom': return 'Chat room can\'t be found';
			case 'yearsOld': return 'years old';
			case 'recievingSettings': return 'Recieving Image/Audio/Video';
			case 'verification': return 'Verification';
			case 'kmAway': return 'Km Away';
			case 'resend': return 'Resend';
			case 'noProfile': return 'Hi unfortunately there isn\'t any cool person in here yet, check later on';
			case 'checkYourMail': return 'Check your Email';
			case 'sendedMail': return ({required Object email}) => 'We have sent you a mail on ${email}';
			case 'verifyingEmail': return 'Verifying email..';
			case 'emailVerified': return 'Email Verified';
			case 'recieveSettings': return 'Recieving Image/Audio/Video Settings';
			case 'recieveImage': return 'Receive Images';
			case 'recieveAudio': return 'Receive Audios';
			case 'recieveVideo': return 'Receive Videos';
			case 'accountVerified': return 'Your account is verified succesfully';
			case 'matches': return 'Matches';
			case 'likesYou': return 'Likes You';
			case 'yourLikes': return 'Your Likes';
			case 'yourMatches': return 'Your Matches';
			case 'subscriptionToSeeTitle': return 'To See This Profile';
			case 'subscriptionToSeeBody': return 'You Need to Subscribe';
			case 'readyToRecord': return 'Ready to Record';
			case 'startRecording': return 'Start Recording';
			default: return null;
		}
	}
}

extension on _StringsTr {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'hello': return ({required Object name}) => 'Merhaba ${name}';
			case 'login': return 'Giriş';
			case 'loginState.success': return 'Başarıyla giriş yapıldı';
			case 'loginState.fail': return 'Giriş başarısız';
			case 'logout': return 'Çıkış';
			case 'getStarted': return 'Başlayalım';
			case 'email': return 'E-posta';
			case 'password': return 'Şifre';
			case 'forgotPw': return 'Şifremi Unuttum';
			case 'appIntro': return 'Uygulama hakkında giriş metni xxxx xxx xx xxxxx uygulama adını belirterek dahil edin';
			case 'save': return 'Kaydet';
			case 'dontHaveAccount': return 'Hesabınız yok mu?';
			case 'register': return 'Kayıt Ol';
			case 'name': return 'İsim';
			case 'lastName': return 'Soyadı';
			case 'about': return 'Hakkında';
			case 'birthDate': return 'Doğum Tarihi';
			case 'location': return 'Konum';
			case 'next': return 'İleri';
			case 'done': return 'Tamam';
			case 'noFaceDetected': return 'Yüzünüz tespit edilemedi. Tekrar Deneyin';
			case 'above18': return '18 yaşından büyük olmalısın.';
			case 'validationProfile': return 'Fotoğraf, İsim, Soyisim ve Doğum Tarihi alanları zorunludur.';
			case 'infoAboutYou': return 'Hakkındaki Bilgiler';
			case 'privacyPolicy': return 'Gizlilik Politikası';
			case 'termsOfUse': return 'Kullanım Koşulları';
			case 'notification': return 'Bildirim';
			case 'yourAccountDeleted': return 'Hesabınız Başarıyla Silindi.';
			case 'sound': return 'Ses';
			case 'vibration': return 'Titreşim';
			case 'willBeImplemented': return 'Yakında Uygulanacak';
			case 'chatHistory': return 'Sohbet Geçmişi';
			case 'deleteAccount': return 'Hesabı Sil';
			case 'helpCenter': return 'Yardım Merkezi';
			case 'aboutLoveLens': return 'Hakkında (Love Lens)';
			case 'gender': return 'Cinsiyet';
			case 'genderList.0': return 'Erkek';
			case 'genderList.1': return 'Kadın';
			case 'hobbies': return 'Hobiler & İlgi Alanları';
			case 'hobbyList.0': return 'Güreş';
			case 'hobbyList.1': return 'Yelkencilik';
			case 'hobbyList.2': return 'Triatlon';
			case 'hobbyList.3': return 'Sauna';
			case 'hobbyList.4': return 'Komedi';
			case 'hobbyList.5': return 'Spor Salonu & Fitness';
			case 'hobbyList.6': return 'Oyun';
			case 'hobbyList.7': return 'Kitap';
			case 'hobbyList.8': return 'Kripto';
			case 'hobbyList.9': return 'NFT';
			case 'hobbyList.10': return 'Futbol';
			case 'hobbyList.11': return 'Basketbol';
			case 'hobbyList.12': return 'Voleybol';
			case 'hobbyList.13': return 'Planörle Uçuş';
			case 'hobbyList.14': return 'Dağcılık';
			case 'hobbyList.15': return 'Dalış';
			case 'hobbyList.16': return 'Filmler';
			case 'hobbyList.17': return 'TV Programları';
			case 'hobbyList.18': return 'Anime';
			case 'hobbyList.19': return 'Teknoloji';
			case 'hobbyList.20': return 'Müzik';
			case 'hobbyList.21': return 'Seyahat';
			case 'hobbyList.22': return 'Yemek Pişirme';
			case 'hobbyList.23': return 'Meditasyon';
			case 'hobbyList.24': return 'Avcılık';
			case 'hobbyList.25': return 'Yüzme';
			case 'interestedGender': return 'İlgilenilen Cinsiyet';
			case 'sexualOrientation': return 'Cinsel Yönelim';
			case 'sexualOrientationList.0': return 'Heteroseksüel';
			case 'sexualOrientationList.1': return 'Eşcinsel';
			case 'sexualOrientationList.2': return 'Lezbiyen';
			case 'sexualOrientationList.3': return 'Biseksüel';
			case 'sexualOrientationList.4': return 'Aseksüel';
			case 'sexualOrientationList.5': return 'Demiseksüel';
			case 'sexualOrientationList.6': return 'Panseksüel';
			case 'sexualOrientationList.7': return 'Bikürsüel';
			case 'sexualOrientationList.8': return 'Queer';
			case 'lookingFor': return 'Aranan';
			case 'lookingForList.0': return 'Uzun Vadeli Partner';
			case 'lookingForList.1': return 'Kısa Vadeli Partner';
			case 'lookingForList.2': return 'Uzun Vadeli Açık İlişki';
			case 'lookingForList.3': return 'Kısa Vadeli Açık İlişki';
			case 'lookingForList.4': return 'Yeni Arkadaşlar';
			case 'lookingForList.5': return 'Hala Anlamaya Çalışıyorum';
			case 'discover': return 'Keşfet';
			case 'profile': return 'Profil';
			case 'updateProfile': return 'Profil Güncelle';
			case 'likes': return 'Beğeniler';
			case 'messages': return 'Mesajlar';
			case 'chat': return 'Sohbet';
			case 'room': return 'Oda';
			case 'error': return 'Hata';
			case 'checkYourEmail': return 'Lütfen Mail Adresinizi Kontrol Edin!';
			case 'loginFailed': return 'Girişte bir hata ile karşılaşıldı';
			case 'close': return 'Kapat';
			case 'registerFailed': return 'Kayıtta bir hata ile karşılaşıldı';
			case 'microphonePermissionNotGranted': return 'Mikrofon izni verilmedi.';
			case 'errorUploadingImage': return 'Resim yüklenirken bir hata ile karşılaşıldı';
			case 'cantSendImage': return 'Resim Gönderemezsin';
			case 'userCantRecieveImages': return 'Diğer kullanıcıya resim gönderemezsin';
			case 'ok': return 'Tamam';
			case 'recieveImageTitle': return 'Görüntü Almak İster Misiniz?';
			case 'recieveImageBody': return ({required Object firstName}) => '${firstName} görüntü göndermek istiyor. Ayarlarınızda açabilirsiniz.';
			case 'errorUploadingVideo': return 'Video yüklenirken hata oluştu.';
			case 'cantSendVideo': return 'Video gönderemezsiniz.';
			case 'userCantRecieveVideos': return 'Diğer kullanıcı videoları alamaz.';
			case 'recieveVideoTitle': return 'Video Almak İster Misiniz?';
			case 'recieveVideoBody': return ({required Object firstName}) => '${firstName} video göndermek istiyor. Ayarlarınızda açabilirsiniz.';
			case 'errorUploadingAudio': return 'Ses yüklenirken hata oluştu.';
			case 'cantSendAudio': return 'Ses gönderemezsiniz.';
			case 'userCantRecieveAudios': return 'Diğer kullanıcı sesleri alamaz.';
			case 'recieveAudioTitle': return 'Ses Almak İster Misiniz?';
			case 'recieveAudioBody': return ({required Object firstName}) => '${firstName} ses göndermek istiyor. Ayarlarınızda açabilirsiniz.';
			case 'requestSended': return 'İsteğiniz gönderildi.';
			case 'sendRequest': return 'İsteği Gönder';
			case 'cancel': return 'İptal';
			case 'photo': return 'Fotoğraf';
			case 'audio': return 'Ses';
			case 'video': return 'Video';
			case 'recording': return 'Kaydediliyor...';
			case 'recordingInProgress': return 'Kayıt yapılıyor...';
			case 'stopRecording': return 'Kaydı Durdur';
			case 'filter': return 'Filtre';
			case 'noDataAvailable': return 'Gösterebileceğimiz bir değer yok';
			case 'noRooms': return 'Oda yok';
			case 'cantFindRoom': return 'Oda bulunamıyor';
			case 'yearsOld': return 'Yaşında';
			case 'kmAway': return 'Km Uzaklıkta';
			case 'resend': return 'Yeniden Gönder';
			case 'noProfile': return 'Maalesef burada henüz harika bir kişi yok, daha sonra kontrol edin.';
			case 'checkYourMail': return 'E-postanızı kontrol edin';
			case 'sendedMail': return ({required Object email}) => 'Size ${email} adresine bir e-posta gönderdik.';
			case 'verifyingEmail': return 'E-posta doğrulanıyor...';
			case 'emailVerified': return 'E-posta doğrulandı.';
			case 'verification': return 'Doğrulama';
			case 'recievingSettings': return 'Fotoğraf/Ses/Video Alımı';
			case 'recieveSettings': return 'Fotoğraf/Ses/Video Ayarlarını Al';
			case 'recieveImage': return 'Resimleri Al';
			case 'recieveAudio': return 'Sesleri Al';
			case 'recieveVideo': return 'Videoları Al';
			case 'accountVerified': return 'Hesabınız başarıyla doğrulandı.';
			case 'matches': return 'Eşleşmeler';
			case 'likesYou': return 'Seni Beğenenler';
			case 'yourLikes': return 'Beğendiklerin';
			case 'yourMatches': return 'Eşleşmelerin';
			case 'subscriptionToSeeTitle': return 'Bu Profili Görmek İçin';
			case 'subscriptionToSeeBody': return 'Abone Olmanız Gerekiyor';
			case 'readyToRecord': return 'Kayda Hazır';
			case 'startRecording': return 'Kayıtı Başlat';
			default: return null;
		}
	}
}
