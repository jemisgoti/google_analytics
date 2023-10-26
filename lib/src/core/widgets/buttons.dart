import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///primary button of the app
class PrimaryButton extends StatelessWidget {
  ///initialize the widget
  const PrimaryButton({
    super.key,
    this.onTap,
    this.controller,
    this.title = '',
  });

  ///provide callback when user tap on the button
  final VoidCallback? onTap;

  ///controller for then button
  final ButtonController? controller;

  ///title of button
  final String title;
  @override
  Widget build(BuildContext context) => MaterialButton(
        height: 45,
        minWidth: MediaQuery.of(context).size.width,
        color: Theme.of(context).colorScheme.primary,
        splashColor: Theme.of(context).colorScheme.primary,
        onPressed: onTap,
        elevation: 1,
        enableFeedback: false,
        focusElevation: 2,
        hoverElevation: 0,
        clipBehavior: Clip.hardEdge,
        focusColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: controller != null
            ? ValueListenableBuilder<bool>(
                valueListenable: controller!.isLoading,
                builder:
                    (BuildContext context, bool isLoading, Widget? child) =>
                        isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : Text(
                                title,
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
              )
            : Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
      );
}

///secondary button of the app
class SecondaryButton extends StatelessWidget {
  ///initialize the widget
  const SecondaryButton({this.onTap, super.key, this.title = ''});

  ///provide callback when user tap on the button
  final VoidCallback? onTap;

  ///title of button
  final String title;
  @override
  Widget build(BuildContext context) => MaterialButton(
        height: 48,
        minWidth: MediaQuery.of(context).size.width,
        onPressed: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(
            width: 1.5,
            color: Color.fromRGBO(13, 13, 13, 1),
          ),
        ),
        child: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: const Color.fromRGBO(13, 13, 13, 1),
          ),
        ),
      );
}

///conttroller for the button
class ButtonController {
  ///loading notifier
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  ///set laoding as true
  void setLoading() {
    isLoading.value = true;
  }

  ///reset loading to false
  void resetLoading() {
    isLoading.value = false;
  }

  ///toggle value of the loading
  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  ///dispose the value
  void dispose() {
    isLoading.dispose();
  }
}
