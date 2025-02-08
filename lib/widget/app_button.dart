import 'package:flutter/material.dart';
import 'package:flutter_bloc_clean_architecture/core/constant/sizes.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  final double borderRedius;
  final bool isLoading;
  final bool bottomSafeArea;

  const AppButton({
    super.key,
    required this.text,
    required this.onTap,
    this.borderRedius = Sizes.size8,
    this.isLoading = false,
    this.bottomSafeArea = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Sizes.size16,
        right: Sizes.size16,
        bottom: MediaQuery.of(context).viewPadding.bottom + Sizes.size16,
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(Sizes.size16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRedius),
          ),
          disabledBackgroundColor:
              Theme.of(context).colorScheme.primary.withAlpha(200),
          backgroundColor: Theme.of(context).colorScheme.primary,
          overlayColor: Colors.black.withAlpha(50),
        ),
        child: SizedBox(
          height: Sizes.size24,
          child: isLoading
              ? SizedBox(
                  width: Sizes.size24,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                )
              : Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
