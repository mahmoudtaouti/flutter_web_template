import 'package:flutter/material.dart';
import 'package:web_template/utils/extensions/widgets_extensions.dart';
import 'package:web_template/widgets/animations/animate_on_hover.dart';
import 'package:web_template/widgets/elements/search_bar.dart';
import 'package:web_template/widgets/layout/centered_web_content.dart';
import 'package:web_template/widgets/layout/responsive_layout.dart';

class DashboardExample extends StatelessWidget {
  const DashboardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return CenteredWebContent(
      child: ResponsiveLayout(
        builder: (context, info) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Dashboard'),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildHeader(info),
                    _buildSummary(info),
                    const ResponsiveConstrainedBox(
                        maxWidthDesktop: 640,
                        maxWidthTablet: 450,
                        maxWidthMobile: 350,
                        child: SimpleSearchBar()),
                    _buildItemList(info),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(ResponsiveInfo info) {
    return ResponsivePadding(
      mobilePadding: const EdgeInsets.all(16),
      tabletPadding: const EdgeInsets.all(24),
      desktopPadding: const EdgeInsets.all(32),
      child: Text(
        'Welcome to Your Dashboard',
        style: TextStyle(
          fontSize: info.responsiveValue(
            mobile: 24,
            tablet: 32,
            desktop: 40,
          ),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSummary(ResponsiveInfo info) {
    return ResponsiveConstrainedBox(
      maxWidthMobile: double.infinity,
      maxWidthTablet: 600,
      maxWidthDesktop: 1200,
      child: ResponsivePadding(
        mobilePadding: const EdgeInsets.all(16),
        tabletPadding: const EdgeInsets.all(24),
        desktopPadding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Summary',
              style: TextStyle(
                fontSize: info.responsiveValue(
                  mobile: 20,
                  tablet: 24,
                  desktop: 28,
                ),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSummaryGrid(info),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryGrid(ResponsiveInfo info) {
    final items = [
      {'title': 'Total Users', 'value': '1,234'},
      {'title': 'Active Projects', 'value': '42'},
      {'title': 'Completed Tasks', 'value': '890'},
      {'title': 'Pending Issues', 'value': '13'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: info.responsiveValue(
          mobile: 1,
          tablet: 2,
          desktop: 4,
        ),
        childAspectRatio: 1.6,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Card(
            elevation: 0,
            color:
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(13),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    items[index]['title']!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    items[index]['value']!,
                    style: const TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
          ),
        ).addTooltip('this is Awesome 😍', offset: 90);
      },
    );
  }

  Widget _buildItemList(ResponsiveInfo info) {
    final items = List.generate(10, (index) => 'Item ${index + 1}');

    return ResponsiveConstrainedBox(
      maxWidthMobile: double.infinity,
      maxWidthTablet: 600,
      maxWidthDesktop: 1200,
      child: ResponsivePadding(
        mobilePadding: const EdgeInsets.all(16),
        tabletPadding: const EdgeInsets.all(24),
        desktopPadding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Items',
              style: TextStyle(
                fontSize: info.responsiveValue(
                  mobile: 20,
                  tablet: 24,
                  desktop: 28,
                ),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_vert_rounded)),
                  onTap: () {},
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
