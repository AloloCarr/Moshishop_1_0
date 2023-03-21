import 'package:flutter/material.dart';
import 'package:moshi_movil_app/widgets/config_Responsive.dart';

class IconPerson extends StatelessWidget {
  const IconPerson({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig(context);
    return SafeArea(
      child: Container(
        height:SizeConfig.safeBlockSizeHorizontal(20) ,
        width: SizeConfig.screenWidth,
        child: Image.asset('assets/img/logo.png' )
        ),
      );
  }
}

