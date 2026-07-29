import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final List<Widget>? actions;
  final bool centerTitle;

  const AppScaffold({
    super.key,
    this.title,
    required this.body,
    this.actions,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            if (title != null)
              Material(
                color: Theme.of(context).appBarTheme.backgroundColor ?? Colors.green,
                child: SizedBox(
                  height: kToolbarHeight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            title!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: centerTitle ? TextAlign.center : TextAlign.start,
                          ),
                        ),
                        if (actions != null) ...actions!,
                      ],
                    ),
                  ),
                ),
              ),
            Expanded(child: body),
          ],
        ),
      ),
    );
  }
}

