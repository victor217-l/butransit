import 'package:butransit/common/globalvariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintext;
  const CustomTextfield(
      {super.key, required this.controller, required this.hintext});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(255, 239, 239, 244),
        filled: true,
        hintText: hintext,

        focusColor: Colors.grey ,
      /* border:  OutlineInputBorder(
           borderRadius: BorderRadius.all(Radius.circular(12)),
           borderSide: BorderSide(
               color: Colors.grey,
               width: 1.0)), */
       disabledBorder:  OutlineInputBorder(
           borderRadius: BorderRadius.all(Radius.circular(12)),
           borderSide: BorderSide(
               color: Colors.grey,
               width: 1.0)),
       focusedBorder:
       OutlineInputBorder(
           borderRadius: BorderRadius.all(Radius.circular(12)),
           borderSide: BorderSide(
               color: Colors.grey,
               width: 1.0)),
       errorBorder:  OutlineInputBorder(
           borderRadius: BorderRadius.all(Radius.circular(12)),
           borderSide: BorderSide(
               color: Colors.grey,
               width: 1.0)),
       enabledBorder: OutlineInputBorder(
         borderRadius: BorderRadius.all(Radius.circular(12)),
       borderSide: BorderSide(
         color: Colors.grey,
         width: 1.0
       )
      ),
        focusedErrorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0)),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintext';
        }
      },
    );
  }
}

class CustomTextfieldforAmbulance extends StatelessWidget {
  final TextEditingController controller;
  final String hintext;
  const CustomTextfieldforAmbulance(
      {super.key, required this.controller, required this.hintext});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.multiline,
      minLines: 2,
      maxLines: 10,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromARGB(255, 239, 239, 244),
        hintText: hintext,

        focusColor: Colors.grey ,
        border:  OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0)),
        disabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0)),
        focusedBorder:
        OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0)),
        errorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0
            )
        ),
        focusedErrorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0)),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintext';
        }
      },
    );
  }
}

class PasswordFieldState extends StatelessWidget {
  final TextEditingController controller;
  final String hintext;

  const PasswordFieldState({
    super.key,
    required this.controller,
    required this.hintext
  });

  @override
  Widget build(BuildContext context) {
    bool obscurePassword = true;
    return TextFormField(

      controller: controller,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return hintext;
        }
      },
      obscureText: obscurePassword,
      keyboardType: TextInputType.visiblePassword,
      decoration: const InputDecoration(

        filled: true,
            focusColor: Colors.grey,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.0
                ),
            ),
        border:  OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0)),
    disabledBorder:  OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(
    color: Colors.grey,
    width: 1.0)),
    focusedBorder:
    OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(
    color: Colors.grey,
    width: 1.0)),
    errorBorder:  OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(
    color: Colors.grey,
    width: 1.0)),
    focusedErrorBorder:  OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(
    color: Colors.grey,
    width: 1.0)),


        hintText: "Password",


        fillColor: Color.fromARGB(255, 239, 239, 244),

      ),
    );
  }
}

/*  suffixIcon: IconButton(
            onPressed: () => setState(
              () => obscurePassword = !obscurePassword,
            ),
            icon: Icon(
              obscurePassword ? Icons.visibility : Icons.visibility_off,
              color: GlobalVariables.primaryColor,
            ),
          )*/
 


/*class PsswordFieldstate extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  const PsswordFieldstate({super.key, required this.controller, required this.hintText});

  @override
  State<PsswordFieldstate> createState() => _PsswordFieldstateState();
}

class _PsswordFieldstateState extends State<PsswordFieldstate> {
  bool obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
      },
      obscureText: obscurePassword,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          labelText: "Password field",
          helperText: "",
          hintText: "Password",
          suffixIcon: IconButton(
            onPressed: () => setState(
              () => obscurePassword = !obscurePassword,
            ),
            icon: Icon(
              obscurePassword ? Icons.visibility : Icons.visibility_off,
              color: GlobalVariables.primaryColor,
            ),
          )),
    );
  }
} 
*/


class CustomTextfiel extends StatelessWidget {
  final TextEditingController controller;
  final String hintext;
  const CustomTextfiel({Key? key,
    required this.controller,
    required this.hintext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey,
          hintStyle: TextStyle(fontSize: 12, color: Colors.black),
          hintText: hintext,
          focusColor: Colors.grey ,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.grey
            ),
          ),
          enabledBorder: OutlineInputBorder(

            borderSide: BorderSide(
                color: Colors.grey,
                width: 1),
          ),
            border:OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(width: 1, color: Colors.grey)
          ),
          disabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1.0)),

          errorBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1.0)),

          focusedErrorBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1.0)),
        ),
        validator: (val) {
          if (val == null || val.isEmpty) {
            return 'Enter your $hintext';
          }
        },
      ),
    );
  }
}

