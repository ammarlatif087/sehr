import 'package:flutter/services.dart';
import 'package:sehr/app/index.dart';
import 'package:sehr/presentation/view_models/blog_view_model.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../common/top_back_button_widget.dart';
import '../../src/index.dart';

class BlogView extends StatefulWidget {
  const BlogView({super.key});

  @override
  State<BlogView> createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (context) => DrawerMenuViewModel(),
          child: Scaffold(
            body: Consumer<DrawerMenuViewModel>(
              builder: (context, viewModel, child) {
                switch (viewModel.blogsList.status) {
                  case Status.loading:
                    return const Center(child: CircularProgressIndicator());
                  case Status.error:
                    return Center(
                      child: Text(viewModel.blogsList.message.toString()),
                    );
                  case Status.completed:
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          const TopBackButtonWidget(),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: getProportionateScreenHeight(10),
                                horizontal: getProportionateScreenWidth(30)),
                            child: kTextBentonSansBold("SEHR Blogs",
                                fontSize: getProportionateScreenHeight(31)),
                          ),
                          BlogCardWidget(
                              titleText: "blog ",
                              description: "blogDescription",
                              child: SizedBox(
                                height: getProportionateScreenHeight(300),
                                child: videoplayer(
                                    url:
                                        "https://www.youtube.com/watch?v=ho9kEuiB-pg&list=PLvQ2RGpesg2YG2ES7hsZ-nVI36NvKLxFO&ab_channel=SEHR"),
                              )),
                          BlogCardWidget(
                              titleText: "blog ",
                              description: "blogDescription",
                              child: SizedBox(
                                height: getProportionateScreenHeight(300),
                                child: videoplayer(
                                    url:
                                        "https://www.youtube.com/watch?v=KA69j9Z4JMs&list=PLvQ2RGpesg2YG2ES7hsZ-nVI36NvKLxFO&index=2&ab_channel=SEHR"),
                              )),
                          BlogCardWidget(
                              titleText: "blog ",
                              description: "blogDescription",
                              child: SizedBox(
                                height: getProportionateScreenHeight(300),
                                child: videoplayer(
                                    url:
                                        "https://www.youtube.com/watch?v=U87EzTr4IL4&list=PLvQ2RGpesg2YG2ES7hsZ-nVI36NvKLxFO&index=3&ab_channel=SEHR"),
                              )),
                          SizedBox(
                            height: 1000,
                            child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  buildVerticleSpace(20),
                              itemCount:
                                  viewModel.blogsList.data!.posts!.length,
                              itemBuilder: (context, index) {
                                print(
                                  'Post Lenght ===> ${viewModel.blogsList.data!.posts![index].image}',
                                );
                                var blogTitle = viewModel
                                    .blogsList.data!.posts![index].title;
                                // ignore: unused_local_variable
                                var blogContent = viewModel
                                    .blogsList.data!.posts![index].content;
                                var blogDescription = viewModel
                                    .blogsList.data!.posts![index].description;
                                var blogImage = viewModel
                                    .blogsList.data!.posts![index].image;
                                var blogVideo = viewModel
                                    .blogsList.data!.posts![index].video;

                                return BlogCardWidget(
                                    titleText: blogTitle!,
                                    description: blogDescription,
                                    child: blogImage != null
                                        ? Container(
                                            height:
                                                getProportionateScreenHeight(
                                                    220),
                                            width: SizeConfig.screenWidth,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                getProportionateScreenHeight(
                                                    10),
                                              ),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  blogImage,
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          )
                                        : blogVideo.toString().isEmpty
                                            ? SizedBox()
                                            : null);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  default:
                    return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class BlogCardWidget extends StatelessWidget {
  const BlogCardWidget({
    Key? key,
    required this.titleText,
    this.description,
    this.child,
  }) : super(key: key);

  final String titleText;
  final String? description;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: getProportionateScreenHeight(15),
      shadowColor: ColorManager.grey.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          getProportionateScreenHeight(24),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildVerticleSpace(20),
            kTextBentonSansMed(
              titleText,
              fontSize: getProportionateScreenHeight(17),
            ),
            buildVerticleSpace(10),
            child ??
                kTextBentonSansReg(
                  description ?? '',
                  fontSize: getProportionateScreenHeight(12),
                  lineHeight: getProportionateScreenHeight(2),
                  textOverFlow: TextOverflow.ellipsis,
                  maxLines: 4,
                ),
            Divider(
              color: ColorManager.textGrey.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class videoplayer extends StatefulWidget {
  videoplayer({super.key, required this.url});
  String url;

  @override
  _videoplayerState createState() => _videoplayerState();
}

class _videoplayerState extends State<videoplayer> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  // late PlayerState _playerState;
  // late YoutubeMetaData _videoMetaData;
  // final double _volume = 100;
  // final bool _muted = false;
  bool _isPlayerReady = false;

  late final List<String> _videoIds = [
    YoutubePlayer.convertUrlToId(widget.url.toString())!,
  ];

  String? video1 = YoutubePlayer.convertUrlToId('url');

  // String? videoId(String url) {
  //   return YoutubePlayer.convertUrlToId(url);
  // }
  int pageIndex = 0;
  void next() {
    setState(() {
      pageIndex = pageIndex + 1;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: _videoIds.first,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    // _videoMetaData = const YoutubeMetaData();
    // _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        // _playerState = _controller.value.playerState;
        // _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          Expanded(
            child: Text(
              _controller.metadata.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: getProportionateScreenHeight(18),
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
        onReady: () {
          _isPlayerReady = true;
        },
        onEnded: (data) {
          _controller.load(_videoIds[
              (_videoIds.indexOf(data.videoId) + 1) % _videoIds.length]);
          // _showSnackBar('Next Video Started!');
        },
      ),
      builder: (context, player) => SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(getProportionateScreenHeight(8)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                player,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
