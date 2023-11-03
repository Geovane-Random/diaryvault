import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/settings_page_theme_extensions.dart';
import 'package:dairy_app/core/locale/language_locale.dart';
import 'package:dairy_app/features/auth/presentation/bloc/cubit/theme_cubit.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageDropDown extends StatelessWidget {
  const LanguageDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainTextColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .mainTextColor;

    final dropDownBackgroundColor = Theme.of(context)
        .extension<SettingsPageThemeExtensions>()!
        .dropDownBackgroundColor;

    return Row(
      children: [
        Text(
          "App Language",
          style: TextStyle(
            fontSize: 16.0,
            color: mainTextColor,
          ),
        ),
        const Spacer(),
        DropdownButton<Locale>(
          menuMaxHeight: 400,
          padding: const EdgeInsets.only(bottom: 0.0),
          iconEnabledColor: mainTextColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          focusColor: mainTextColor,
          underline: Container(
            height: 1,
            color: mainTextColor,
          ),
          dropdownColor: dropDownBackgroundColor,
          // value: Intl.getCurrentLocale(),
          onChanged: (value) async {
            // Update the selected value
            // await themeCubit.setTheme(value);
          },
          items: S.delegate.supportedLocales.map((Locale locale) {
            return DropdownMenuItem<Locale>(
              value: locale,
              child: Text(LanguageLocal
                  .isoLangs[locale.toLanguageTag()]!["nativeName"]!),
            );
          }).toList(),
        ),
      ],
    );
  }
}
