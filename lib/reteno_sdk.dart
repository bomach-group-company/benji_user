import 'dart:async';
import 'dart:developer';
import 'dart:math' show Random;

import 'package:app_links/app_links.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:reteno_plugin/anonymous_user_attributes.dart';
import 'package:reteno_plugin/reteno.dart';
import 'package:reteno_plugin/reteno_user.dart';
import 'package:reteno_plugin_example/events_page.dart';
import 'package:reteno_plugin_example/secrets.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:uuid/uuid.dart';

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();

//   print("Handling a background message: ${message.messageId}");
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SentryFlutter.init(
    (options) {
      options.dsn = Constants.sentryDsn;
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(const MyApp()),
  );
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyHomePage(title: 'Flutter Demo Home Page');
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'recom',
          builder: (BuildContext context, GoRouterState state) {
            return const EventsPage();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Reteno Plugin Example',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      routerConfig: _router,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _showAlert(BuildContext context, String text) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: SingleChildScrollView(child: Text(text)),
    ));
  }

  final Reteno _reteno = Reteno();

  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;
  StreamSubscription<String>? _stringLinkSubscription;

  @override
  void initState() {
    super.initState();
    try {
      throw Exception('Testing Sentry');
    } catch (exception, stackTrace) {
      Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
    _reteno.getInitialNotification().then((value) {
      if (value != null) {
        _showAlert(context, 'getInitialNotification: ${value.toString()}');
      }
    });
    Reteno.onRetenoNotificationReceived.listen((event) {
      _showAlert(context, 'onRetenoNotificationReceived: ${event.toString()}');
    });
    Reteno.onRetenoNotificationClicked.listen((event) {
      _showAlert(context, 'onRetenoClicked: ${event.toString()}');
    });
    _initFirebaseNotifications();
    initDeepLinks();
  }

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'reteno_id', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  Future<void> _initFirebaseNotifications() async {
    // const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    // const iosInit = DarwinInitializationSettings();

    // const initSetting =
    //     InitializationSettings(android: androidInit, iOS: iosInit);
    // final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(channel);
    // await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()
    //     ?.requestPermission();
    // await flutterLocalNotificationsPlugin.initialize(initSetting,
    //     onDidReceiveNotificationResponse: (response) {
    //   print(response.payload.toString());
    // });

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    //   print('Got a message whilst in the foreground!');
    //   print('Message data: ${message.data}');

    //   if (message.notification != null) {
    //     print('Message also contained a notification: ${message.notification}');
    //   }
    //   final notification = message.notification;
    //   final android = message.notification?.android;

    //   // if (notification != null && android != null) {
    //     await flutterLocalNotificationsPlugin.show(
    //       notification.hashCode,
    //       'notification.title',
    //       'notification.body',
    //       NotificationDetails(
    //         android: AndroidNotificationDetails(
    //           channel.id,
    //           channel.name,
    //           channelDescription: channel.description,
    //         ),
    //         iOS: const DarwinNotificationDetails(),
    //       ),
    //       payload: json.encode(message.data),
    //     );
    //   // }
    // });
    // FirebaseMessaging.instance.getToken().then((value) {
    //   _showAlert(context, value?.toString() ?? '');
    // });
  }

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();

    // Check initial link if app was in cold state (terminated)
    final appLink = await _appLinks.getInitialAppLink();
    if (appLink != null) {
      log('getInitialAppLink: $appLink');
      openAppLink(appLink);
    }

    // Handle link when app is in warm state (front or background)
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      log('onAppLink: $uri');

      openAppLink(uri);
    });

    // _stringLinkSubscription = _appLinks.stringLinkStream.listen((uri) {
    //   log('onAppLink: $uri');
    //   //openAppLink(uri);
    // });
  }

  void openAppLink(Uri uri) {
    var path = uri.path;
    if (path.isEmpty) {
      path = '/${uri.authority}';
    }
    context.go(path);
    log(uri.toString());
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    _stringLinkSubscription?.cancel();
    super.dispose();
  }

  final _formKey = GlobalKey<FormBuilderState>();

  final ValueNotifier<bool> _isAnonymousUser = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    InputDecoration inputDecoration(String labelText) => InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.lightBlue,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reteno Example'),
        actions: [
          Row(
            children: [
              const Text('Anonymous User  '),
              ValueListenableBuilder(
                valueListenable: _isAnonymousUser,
                builder: (context, value, _) {
                  return Switch(
                    value: value,
                    onChanged: (value) {
                      _isAnonymousUser.value = value;
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: _isAnonymousUser,
            builder: (context, isAnonymousUser, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: FormBuilder(
                            key: _formKey,
                            onChanged: () {
                              _formKey.currentState!.save();
                            },
                            autovalidateMode: AutovalidateMode.disabled,
                            initialValue: {
                              if (!isAnonymousUser) 'externalUserId': null,
                              if (!isAnonymousUser) 'phone': null,
                              if (!isAnonymousUser) 'email': null,
                              'first_name': null,
                              'last_name': null,
                              'language_code': null,
                              'timezone': null,
                              'region': null,
                              'town': null,
                              'address': null,
                              'postcode': null,
                              if (!isAnonymousUser) 'group_include': null,
                              if (!isAnonymousUser) 'group_exclude': null,
                              'additional_info': null,
                            },
                            skipDisabled: true,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                const SizedBox(height: 8),
                                const Text(
                                  'User attributes:',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    backgroundColor: Colors.amber,
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                if (!isAnonymousUser)
                                  Row(
                                    children: [
                                      Expanded(
                                        child: FormBuilderTextField(
                                          name: 'externalUserId',
                                          decoration: inputDecoration(
                                              'External User Id'),
                                          validator:
                                              FormBuilderValidators.compose([
                                            FormBuilderValidators.required(),
                                          ]),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            const uuid = Uuid();
                                            final generatedId = uuid.v4();
                                            _formKey.currentState
                                                ?.fields['externalUserId']
                                                ?.didChange(generatedId
                                                    .substring(0, 25));
                                          },
                                          child: const Text(
                                            'Generate',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                if (!isAnonymousUser) const SizedBox(height: 8),
                                if (!isAnonymousUser)
                                  Row(
                                    children: [
                                      Expanded(
                                        child: FormBuilderTextField(
                                          name: 'phone',
                                          decoration:
                                              inputDecoration('Phone number'),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            final random = Random();
                                            final randomPhoneNumber =
                                                random.nextInt(8999999) +
                                                    1000000;
                                            _formKey
                                                .currentState?.fields['phone']
                                                ?.didChange(
                                                    '+38068$randomPhoneNumber');
                                          },
                                          child: const Text(
                                            'Random',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                if (!isAnonymousUser) const SizedBox(height: 8),
                                if (!isAnonymousUser)
                                  FormBuilderTextField(
                                    name: 'email',
                                    decoration: inputDecoration('Email'),
                                  ),
                                const SizedBox(height: 8),
                                FormBuilderTextField(
                                  name: 'first_name',
                                  decoration: inputDecoration('First name'),
                                ),
                                const SizedBox(height: 8),
                                FormBuilderTextField(
                                  name: 'last_name',
                                  decoration: inputDecoration('Last name'),
                                ),
                                const SizedBox(height: 8),
                                FormBuilderTextField(
                                  name: 'language_code',
                                  decoration: inputDecoration('Language code'),
                                ),
                                const SizedBox(height: 8),
                                FormBuilderTextField(
                                  name: 'timezone',
                                  decoration: inputDecoration('Timezone'),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Address info:',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    backgroundColor: Colors.amber,
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                FormBuilderTextField(
                                  name: 'region',
                                  decoration: inputDecoration('Region'),
                                ),
                                const SizedBox(height: 8),
                                FormBuilderTextField(
                                  name: 'town',
                                  decoration: inputDecoration('Town'),
                                ),
                                const SizedBox(height: 8),
                                FormBuilderTextField(
                                  name: 'address',
                                  decoration: inputDecoration('Address'),
                                ),
                                const SizedBox(height: 8),
                                FormBuilderTextField(
                                  name: 'postcode',
                                  decoration: inputDecoration('Postcode'),
                                ),
                                if (!isAnonymousUser)
                                  const SizedBox(height: 16),
                                if (!isAnonymousUser)
                                  FormBuilderTextField(
                                    name: 'groups_exclude',
                                    decoration:
                                        inputDecoration('Groups to exclude'),
                                  ),
                                if (!isAnonymousUser) const SizedBox(height: 8),
                                if (!isAnonymousUser)
                                  FormBuilderTextField(
                                    name: 'groups_include',
                                    decoration:
                                        inputDecoration('Groups to include'),
                                  ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Additional Info(Custom Field TEXT):',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    backgroundColor: Colors.amber,
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                FormBuilderTextField(
                                  name: 'additional_info',
                                  decoration: inputDecoration(
                                      'Value for custom field TEXT'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (isAnonymousUser) {
                                await updateAnonymousUserAttributes();
                              } else {
                                await updateUserAttributes();
                              }
                            },
                            child: const Text(
                              'Update User Attributes',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              context.go('/recom');
                            },
                            child: const Text(
                              'Go to custom events page',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  Future<void> updateAnonymousUserAttributes() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final value = _formKey.currentState?.value;
      if (value == null) {
        return;
      }
      final customFields = <UserCustomField>[];
      if (value['additional_info']?.toString().isNotEmpty ?? false) {
        customFields.add(UserCustomField(
            key: 'ADDITIONAL_FIELDS.TEXT', value: value['additional_info']));
      }
      Address? userAddress;
      if (value['postcode']?.toString().isNotEmpty ??
          value['address']?.toString().isNotEmpty ??
          value['region']?.toString().isNotEmpty ??
          value['town']?.toString().isNotEmpty ??
          false) {
        userAddress = Address(
          postcode: value['postcode']?.toString(),
          address: value['address']?.toString(),
          region: value['region']?.toString(),
          town: value['town']?.toString(),
        );
      }

      final firstName = value['first_name']?.toString();
      final lastName = value['last_name']?.toString();
      final timezone = value['timezone']?.toString();
      final languageCode = value['language_code']?.toString();

      AnonymousUserAttributes? attributes;

      if ([firstName, lastName, timezone, languageCode]
              .any((element) => element != null && element.isNotEmpty) ||
          userAddress != null) {
        attributes = AnonymousUserAttributes(
          firstName: firstName,
          lastName: lastName,
          timeZone: timezone,
          languageCode: languageCode,
          address: userAddress,
          fields: customFields,
        );
      }

      await _reteno.setAnomymousUserAttributes(
        anonymousUserAttributes: attributes ?? AnonymousUserAttributes(),
      );
    } else {
      debugPrint(_formKey.currentState?.value.toString());
      debugPrint('validation failed');
    }
  }

  Future<void> updateUserAttributes() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final value = _formKey.currentState?.value;
      if (value == null) {
        return;
      }
      final customFields = <UserCustomField>[];
      if (value['additional_info']?.toString().isNotEmpty ?? false) {
        customFields.add(UserCustomField(
            key: 'ADDITIONAL_FIELDS.TEXT', value: value['additional_info']));
      }
      Address? userAddress;
      if (value['postcode']?.toString().isNotEmpty ??
          value['address']?.toString().isNotEmpty ??
          value['region']?.toString().isNotEmpty ??
          value['town']?.toString().isNotEmpty ??
          false) {
        userAddress = Address(
          postcode: value['postcode']?.toString(),
          address: value['address']?.toString(),
          region: value['region']?.toString(),
          town: value['town']?.toString(),
        );
      }

      final email = value['email']?.toString();
      final firstName = value['first_name']?.toString();
      final lastName = value['last_name']?.toString();
      final phone = value['phone']?.toString();
      final timezone = value['timezone']?.toString();
      final languageCode = value['language_code']?.toString();

      UserAttributes? attributes;

      if ([email, firstName, lastName, phone, timezone, languageCode]
              .any((element) => element != null && element.isNotEmpty) ||
          userAddress != null) {
        attributes = UserAttributes(
          email: email,
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          timeZone: timezone,
          languageCode: languageCode,
          address: userAddress,
          fields: customFields,
        );
      }

      final userInfo = RetenoUser(
        userAttributes: attributes,
        groupNamesExclude: value['groups_exclude']
            ?.toString()
            .split(',')
            .map((e) => e.trim())
            .toList(),
        groupNamesInclude: value['groups_include']
            ?.toString()
            .split(',')
            .map((e) => e.trim())
            .toList(),
      );

      await _reteno.setUserAttributes(
        userExternalId: value['externalUserId'],
        user: userInfo,
      );
    } else {
      debugPrint(_formKey.currentState?.value.toString());
      debugPrint('validation failed');
    }
  }
}
