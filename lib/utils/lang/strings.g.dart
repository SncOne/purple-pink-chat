/// Generated file. Do not edit.
///
/// Original: lib/utils/lang
/// To regenerate, run: `dart run slang`
///
/// Locales: 2
/// Strings: 36 (18 per locale)
///
/// Built on 2024-06-04 at 14:05 UTC

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
	String get name => 'Name';
	String get lastName => 'Last Name';
	String get about => 'About';
	String get birthDate => 'Birth Date';
	String get location => 'Location';
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
	@override String get login => 'Giriş Yap';
	@override late final _StringsLoginStateTr loginState = _StringsLoginStateTr._(_root);
	@override String get logout => 'Çıkış Yap';
	@override String get getStarted => 'Başlayalım!';
	@override String get email => 'Email';
	@override String get password => 'Şifre';
	@override String get forgotPw => 'Şifremi unuttum';
	@override String get appIntro => 'Uygulama hakkında bilgi xxxx xxx xx xxxxx uygulamanın adını ekleyerek belirt';
	@override String get save => 'Kaydet';
	@override String get dontHaveAccount => 'Hesabın yok mu?';
	@override String get register => 'Kayıt Ol';
	@override String get name => 'İsim';
	@override String get lastName => 'Soyisim';
	@override String get about => 'Hakkında';
	@override String get birthDate => 'Doğum Tarihi';
	@override String get location => 'Lokasyon';
}

// Path: loginState
class _StringsLoginStateTr implements _StringsLoginStateEn {
	_StringsLoginStateTr._(this._root);

	@override final _StringsTr _root; // ignore: unused_field

	// Translations
	@override String get success => 'Başarıyla giriş Yapıldı';
	@override String get fail => 'Giriş yaparken bir sorun ile karşılaşıldı';
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
			case 'name': return 'Name';
			case 'lastName': return 'Last Name';
			case 'about': return 'About';
			case 'birthDate': return 'Birth Date';
			case 'location': return 'Location';
			default: return null;
		}
	}
}

extension on _StringsTr {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'hello': return ({required Object name}) => 'Merhaba ${name}';
			case 'login': return 'Giriş Yap';
			case 'loginState.success': return 'Başarıyla giriş Yapıldı';
			case 'loginState.fail': return 'Giriş yaparken bir sorun ile karşılaşıldı';
			case 'logout': return 'Çıkış Yap';
			case 'getStarted': return 'Başlayalım!';
			case 'email': return 'Email';
			case 'password': return 'Şifre';
			case 'forgotPw': return 'Şifremi unuttum';
			case 'appIntro': return 'Uygulama hakkında bilgi xxxx xxx xx xxxxx uygulamanın adını ekleyerek belirt';
			case 'save': return 'Kaydet';
			case 'dontHaveAccount': return 'Hesabın yok mu?';
			case 'register': return 'Kayıt Ol';
			case 'name': return 'İsim';
			case 'lastName': return 'Soyisim';
			case 'about': return 'Hakkında';
			case 'birthDate': return 'Doğum Tarihi';
			case 'location': return 'Lokasyon';
			default: return null;
		}
	}
}
