import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PageLoadingIndicator extends StatelessWidget {
  const PageLoadingIndicator({
    super.key,
    this.future,
    required this.scaffold,
    this.focedLoading = false,
  });

  final Future? future;
  final bool focedLoading;
  final Scaffold scaffold;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        scaffold,
        FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            return Visibility(
              visible: focedLoading || snapshot.connectionState == ConnectionState.waiting,
              child: Positioned.fill(
                child: Container(
                  color: Colors.black54,
                  child: Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
