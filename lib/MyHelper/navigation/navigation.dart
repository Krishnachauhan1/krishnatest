import 'package:flutter/material.dart';

import '../../main.dart';

navigatorPush(widgetScreen,{context,fullscreenDialog=false})async
{
  return await Navigator.push(context??MyApp.navigatorKey.currentContext, 
      PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return widgetScreen;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
      fullscreenDialog: fullscreenDialog,
    ));
}

// navigatorPushReplace(widgetScreen, {context})async
// {
//   return await Navigator.of(context??MyApp.navigatorKey.currentContext).pushAndRemoveUntil(MaterialPageRoute(
//       builder: (_) =>widgetScreen),(Route<dynamic> route) => false);
// }

// goBack({param,context})
// {
//   if(Navigator.canPop(context??MyApp.navigatorKey.currentContext!)) {
//     Navigator.pop(context??MyApp.navigatorKey.currentContext!,param);
//   }
// }

// navigatorPop({int popCount = 0,context})
// {
//   Navigator.of(context??MyApp.navigatorKey.currentContext!).popUntil((_) => popCount-- <= 0);
// }