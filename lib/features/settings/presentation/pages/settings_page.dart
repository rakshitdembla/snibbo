import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snibbo_app/core/constants/mystrings.dart';
import 'package:snibbo_app/core/utils/services_utils.dart';
import 'package:snibbo_app/core/utils/ui_utils.dart';
import 'package:snibbo_app/features/settings/presentation/widgets/my_adaptive_switch.dart';
import 'package:snibbo_app/features/settings/presentation/widgets/my_listtile.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_events.dart';
import 'package:snibbo_app/features/settings/presentation/bloc/theme_states.dart';
import 'package:snibbo_app/presentation/routes/auto_route.gr.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeBloc>().state is DarkThemeState;
    final width = UiUtils.screenWidth(context);
    final height = UiUtils.screenHeight(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Settings and activity"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: height * 0.01),
          child: Column(
            children: [
              BlocBuilder<ThemeBloc, ThemeStates>(
                builder: (context, state) {
                  final value = state is DarkThemeState;
                  return MyListtile(
                    leadingTitle: "Dark Theme",
                    trailingWidget: MyAdaptiveSwitch(
                      onChanged: (value) {
                        context.read<ThemeBloc>().add(
                          ToogleTheme(isDark: value),
                        );
                      },
                      value: value,
                    ),
                  );
                },
              ),
              MyListtile(
                onTap: () {
                  context.router.push(
                    WebViewScreenRoute(url: MyStrings.aboutSnibboUrl),
                  );
                },
                leadingTitle: "About",
                trailingWidget: Icon(Icons.info_outline, size: width * 0.07),
              ),
              MyListtile(
                onTap: () {
                  ServicesUtils.openEmailApp(
                    isReport: true,
                    reportFor: "snibbo",
                    uniqueID: "bug",
                    context: context,
                  );
                },
                leadingTitle: "Report a Bug",
                trailingWidget: Icon(
                  Icons.bug_report_outlined,
                  size: width * 0.07,
                ),
              ),
              MyListtile(
                onTap: () {
                  context.router.push(
                    WebViewScreenRoute(url: MyStrings.termsConditionsUrl),
                  );
                },
                leadingTitle: "Terms & Conditions",
                trailingWidget: Icon(
                  Icons.article_outlined,
                  size: width * 0.07,
                ),
              ),
              MyListtile(
                onTap: () {
                  context.router.push(
                    WebViewScreenRoute(url: MyStrings.privacyPolicyUrl),
                  );
                },
                leadingTitle: "Privacy Policy",
                trailingWidget: Icon(
                  Icons.privacy_tip_outlined,
                  size: width * 0.07,
                ),
              ),
              MyListtile(
                onTap: () async {
                  context.router.replaceAll([OnboardScreenRoute()]);
                  UiUtils.showToast(
                    title: "See You Soon!",
                    description:
                        "You've successfully logged out of your account.",
                    isDark: isDark,
                    context: context,
                    isSuccess: true,
                    isWarning: false,
                  );
                  await ServicesUtils.deleteTokenId();
                  await ServicesUtils.deleteUsername();
                },
                leadingTitle: "Logout",
                trailingWidget: Icon(Icons.logout_outlined, size: width * 0.07),
              ),
              MyListtile(
                onTap: () {
                  ServicesUtils.copyLink(
                    uniqueID: "snibbo",
                    type: "invite",
                    context: context,
                  );
                },
                leadingTitle: "Invite Friends",
                trailingWidget: Icon(
                  Icons.group_add_outlined,
                  size: width * 0.07,
                ),
              ),
              MyListtile(
                onTap: () async {
                  final userId = await ServicesUtils.getTokenId();
                  final username = await ServicesUtils.getUsername();
                  if (context.mounted) {
                    ServicesUtils.openEmailApp(
                      isReport: false,
                      text: "Account Deletion Request for $username - $userId",
                      context: context,
                    );
                  }
                },
                leadingTitle: "Request Account Deletion",
                trailingWidget: Icon(
                  Icons.cancel_outlined,
                  size: width * 0.07,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
