import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:graphql_demo/i18n/translations.g.dart';
import 'package:graphql_demo/injection.dart';

import 'bloc/auth/auth_cubit.dart';
import 'routes/router.dart';
import 'theme/theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>()..checkAuth(),

      /// Translations wrapper
      child: TranslationProvider(
        child: Builder(builder: (context) {
          /// Material app initialization
          return MaterialApp.router(
            onGenerateTitle: (context) => t.common.app.title,
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            routerConfig: router.config(),
            locale: TranslationProvider.of(context).flutterLocale,
            supportedLocales: AppLocaleUtils.supportedLocales,
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
          );
        }),
      ),
    );
  }
}
