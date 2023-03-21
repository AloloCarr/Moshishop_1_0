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
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height:SizeConfig.safeBlockSizeHorizontal(60) ,
          width: SizeConfig.screenWidth,
          child: Image.asset('assets/img/logo.png' )
          ),
      ),
      
      );
  }
}

