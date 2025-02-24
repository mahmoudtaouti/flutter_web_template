import 'package:flutter/material.dart';
import 'package:web_template/router/app_router.dart';
import 'package:web_template/utils/extensions/widgets_extensions.dart';
import 'package:web_template/widgets/animations/animate_on_hover.dart';
import 'package:web_template/widgets/layout/centered_web_content.dart';
import 'package:web_template/widgets/layout/responsive_layout.dart';
import 'data.dart';

class BlogAppExample extends StatefulWidget {
  const BlogAppExample({super.key});

  @override
  State<BlogAppExample> createState() => _BlogAppExampleState();
}

class _BlogAppExampleState extends State<BlogAppExample> {
  @override
  void initState() {
    super.initState();
    _initializeRouter();
  }

  void _initializeRouter() {
    AppRouter().initializeRouter({
      '/': (context, _) => const HomePage(),
      '/blogs': (context, _) => const BlogsPage(),
      '/about': (context, _) => const AboutPage(),
    });

    AppRouter().addRoutes({
      '/blog': (context, _) => const BlogPostPage(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enhanced Blog',
      navigatorKey: AppRouter().navigationService.navigatorKey,
      onGenerateRoute: AppRouter().generateRoute,
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar.build(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context),
            _buildIntroSection(),
            _buildCategoriesSection(),
            _buildFeaturedBlogs(context),
            _buildNewsletterSection(),
            _buildTestimonialsSection(),
            _buildContactSection(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 500,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1535378273068-9bb67d5beacd?q=80&w=1994&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 500,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.6),
                Colors.black.withOpacity(0.3)
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Explore the World of Tech',
                  style: TextStyle(
                    fontSize: ResponsiveLayout.of(context)
                        .responsiveValue(mobile: 28, desktop: 45),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Stay Ahead with Our Cutting-Edge Insights',
                  style: TextStyle(
                    fontSize: ResponsiveLayout.of(context)
                        .responsiveValue(mobile: 15, desktop: 24),
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 5.0,
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIntroSection() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Discover Latest Insights',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Explore our latest blog posts and stay updated with the newest trends and tips in the world of technology and programming. Whether you are a beginner or an experienced developer, we have something for everyone!',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedBlogs(BuildContext context) {
    return ResponsiveConstrainedBox(
      maxWidthDesktop: 1000,
      maxWidthMobile: 600,
      child: Column(
        children: dummyBlogs.map((blog) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              title: Text(blog.title),
              subtitle: Text(blog.excerpt),
              trailing: Text(blog.date.toLocal().toString().split(' ')[0]),
              onTap: () {
                context.router.navigateTo('/blog',
                    queryParams: {'id': blog.id.toString()});
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCategoriesSection() {
    final categories = ['Web Dev', 'Mobile', 'AI', 'Cloud', 'Security'];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          const Text('Explore Topics',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: categories
                .map((category) => Chip(
                      label: Text(category),
                    ).moveUpOnHover)
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsletterSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      color: Colors.grey.shade200,
      child: Column(
        children: [
          const Text('Stay Updated',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const Text('Subscribe to our newsletter for weekly tech insights'),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                ),
                child: const Text('Subscribe'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialsSection() {
    final testimonials = [
      {
        'name': 'John Doe',
        'comment': 'This blog has been invaluable for my tech career!'
      },
      {
        'name': 'Jane Smith',
        'comment': 'I always find the latest trends here first.'
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          const Text('What Our Readers Say',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Wrap(
            children: testimonials
                .map((t) => Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(t['comment']!,
                                style: const TextStyle(
                                    fontSize: 16, fontStyle: FontStyle.italic)),
                            const SizedBox(height: 10),
                            Text('- ${t['name']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ).moveUpOnHover)
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Us',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'We would love to hear from you! If you have any questions, comments, or suggestions, please feel free to reach out to us.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.email),
              SizedBox(width: 8),
              Text('contact@ourblog.com', style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.phone),
              SizedBox(width: 8),
              Text('+1 234 567 890', style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.black54,
      child: const Center(
        child: Text(
          '© 2024 Our Blog. All rights reserved.',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class BlogsPage extends StatelessWidget {
  const BlogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar.build(context),
      body: CenteredWebContent(
        maxWidth: 1200,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildBlogHeader(),
              _buildSearchSection(),
              _buildBlogList(context),
              _buildPagination(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlogHeader() {
    return Container(
      padding: const EdgeInsets.all(40),
      child: const Column(
        children: [
          Text('Our Blog',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Text(
              'Discover the latest in tech, programming, and digital innovation',
              style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }

  Widget _buildBlogList(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: dummyBlogs.length,
      itemBuilder: (context, index) {
        final blog = dummyBlogs[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: InkWell(
            onTap: () {
              context.router.navigateTo('/blog',
                  arguments: {'id': blog.id},
                  queryParams: {'id': blog.id.toString()});
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(blog.title,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(blog.excerpt, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.person, size: 16),
                      const SizedBox(width: 5),
                      Text(blog.author),
                      const SizedBox(width: 20),
                      const Icon(Icons.calendar_today, size: 16),
                      const SizedBox(width: 5),
                      Text(blog.date.toLocal().toString().split(' ')[0]),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPagination() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {},
            child: const Text('Previous'),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSection() {
    return ResponsiveConstrainedBox(
      maxWidthDesktop: 1000,
      maxWidthMobile: 600,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search blog posts...',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onSubmitted: (query) {
            // Implement search functionality
          },
        ),
      ),
    );
  }
}

class BlogPostPage extends StatelessWidget {
  const BlogPostPage({super.key});

  @override
  Widget build(BuildContext context) {

    Uri url = Uri.parse(context.router.getCurrentPath(context));
    final blogId =  int.parse(url.queryParameters['id']!);
    final blog = dummyBlogs.firstWhere(
      (blog) => blog.id == blogId,
      orElse: () => BlogPost(
        id: 0,
        title: "Not Found",
        excerpt: "",
        content: "The requested blog post was not found.",
        author: "",
        date: DateTime.now(),
      ),
    );

    return Scaffold(
      appBar: NavBar.build(context),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildBlogHeader(blog),
            CenteredWebContent(
              maxWidth: 800,
              sideMargin: 32,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(blog.content,
                            style: const TextStyle(fontSize: 18, height: 1.6))
                        .selectableWidget(),
                    const SizedBox(height: 40),
                    _buildAuthorSection(blog),
                    const SizedBox(height: 40),
                    _buildCommentSection(),
                    const SizedBox(height: 40),
                    _buildRelatedPosts(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlogHeader(BlogPost blog) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(blog.title,
                style:
                    const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center)
            .selectableWidget(),
        const SizedBox(height: 20),
        Wrap(
          children: [
            Text(blog.author).selectableWidget(),
            const SizedBox(width: 20),
            Text(blog.date.toLocal().toString().split(' ')[0])
                .selectableWidget(),
          ],
        ),
      ],
    );
  }

  Widget _buildAuthorSection(BlogPost blog) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(blog.author,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))
                    .selectableWidget(),
                const SizedBox(height: 5),
                const Text('Tech enthusiast and software developer')
                    .selectableWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Comments',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
            .selectableWidget(),
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(
            hintText: 'Leave a comment',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Post Comment'),
        ),
        const SizedBox(height: 20),
        const Text('No comments yet.',
                style: TextStyle(fontSize: 16, color: Colors.grey))
            .selectableWidget(),
      ],
    );
  }

  Widget _buildRelatedPosts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Related Posts',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
            .selectableWidget(),
        const SizedBox(height: 20),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: dummyBlogs
              .take(3)
              .map((blog) => Card(
                    child: SizedBox(
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(blog.title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold))
                                    .selectableWidget(),
                                const SizedBox(height: 5),
                                Text(blog.excerpt,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis)
                                    .selectableWidget(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class NavBar {
  NavBar._();
  static PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      title: InkWell(
        child: const Text('Our Blog'),
        onTap: () => context.router.navigateTo('/'),
      ),
      automaticallyImplyLeading: false,
      actions: [
        TextButton(
          child:
              const Text('Home', style: TextStyle(fontWeight: FontWeight.w700)),
          onPressed: () => context.router.navigateTo('/'),
        ),
        TextButton(
          child: const Text('Blogs',
              style: TextStyle(fontWeight: FontWeight.w700)),
          onPressed: () => context.router.navigateTo('/blogs'),
        ),
        TextButton(
          child: const Text('About',
              style: TextStyle(fontWeight: FontWeight.w700)),
          onPressed: () => context.router.navigateTo('/about'),
        ),
        TextButton(
          child: const Text('Contact',
              style: TextStyle(fontWeight: FontWeight.w700)),
          onPressed: () => context.router.navigateTo('/contact'),
        ),
      ],
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar.build(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildMissionSection(),
            _buildTeamSection(),
            _buildValuesSection(),
            _buildContactSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 300,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://source.unsplash.com/random/1600x900?technology'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.6),
              Colors.black.withOpacity(0.3)
            ],
          ),
        ),
        child: Center(
          child: Text(
            'About Our Blog',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black.withOpacity(0.5),
                  offset: const Offset(0, 5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMissionSection() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Our Mission',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ).selectableWidget(),
          const SizedBox(height: 16),
          const Text(
            'At Our Blog, we are passionate about bringing you the latest insights and trends in technology. '
            'Our mission is to empower developers, tech enthusiasts, and curious minds with knowledge that '
            'helps them stay ahead in the rapidly evolving world of technology.',
            style: TextStyle(fontSize: 18, height: 1.5),
          ).selectableWidget(),
        ],
      ),
    );
  }

  Widget _buildTeamSection() {
    final teamMembers = [
      {'name': 'John Doe', 'role': 'Founder & Editor-in-Chief'},
      {'name': 'Jane Smith', 'role': 'Senior Tech Writer'},
      {'name': 'Mike Johnson', 'role': 'Web Developer'},
    ];

    return Container(
      color: Colors.grey.shade100,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        children: [
          const Text(
            'Our Team',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ).selectableWidget(),
          const SizedBox(height: 24),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: teamMembers
                .map((member) => Card(
                      elevation: 3,
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  'https://source.unsplash.com/random/100x100?portrait'),
                            ),
                            const SizedBox(height: 16),
                            Text(member['name']!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold))
                                .selectableWidget(),
                            Text(member['role']!,
                                    style: const TextStyle(
                                        fontStyle: FontStyle.italic))
                                .selectableWidget(),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildValuesSection() {
    final values = [
      {
        'icon': Icons.lightbulb_outline,
        'title': 'Innovation',
        'description': 'We strive to bring you cutting-edge information.'
      },
      {
        'icon': Icons.verified_user_outlined,
        'title': 'Integrity',
        'description':
            'We are committed to providing accurate and reliable content.'
      },
      {
        'icon': Icons.people_outline,
        'title': 'Community',
        'description':
            'We foster a supportive environment for tech enthusiasts.'
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          const Text(
            'Our Values',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ).selectableWidget(),
          const SizedBox(height: 24),
          ...values.map((value) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: [
                    Icon(value['icon'] as IconData,
                        size: 48, color: Colors.blue),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(value['title'].toString(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))
                              .selectableWidget(),
                          const SizedBox(height: 8),
                          Text(value['description'].toString(),
                                  style: const TextStyle(fontSize: 16))
                              .selectableWidget(),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      color: Colors.blue.shade50,
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contact Us',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ).selectableWidget(),
          const SizedBox(height: 16),
          const Text(
            'We would love to hear from you! If you have any questions, comments, or suggestions, please feel free to reach out to us.',
            style: TextStyle(fontSize: 18),
          ).selectableWidget(),
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.email, color: Colors.blue),
            title: const Text('contact@ourblog.com',
                    style: TextStyle(fontSize: 18))
                .selectableWidget(),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.phone, color: Colors.blue),
            title: const Text('+1 234 567 890', style: TextStyle(fontSize: 18))
                .selectableWidget(),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              // Implement contact form functionality
            },
            icon: const Icon(Icons.send),
            label: const Text('Send us a message'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
