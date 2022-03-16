import 'package:flutter/material.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:provider/provider.dart';
import 'package:wtf/controller/gym_store.dart';
import 'package:wtf/helper/app_constants.dart';
import 'package:wtf/helper/colors.dart';
import 'package:wtf/helper/flash_helper.dart';
import 'package:wtf/helper/navigation.dart';
import 'package:wtf/helper/routes.dart';
import 'package:wtf/helper/ui_helpers.dart';
import 'package:wtf/main.dart';
import 'package:wtf/model/AllSessions.dart';
import 'package:wtf/widget/custom_button.dart';

class PTIntro extends StatefulWidget {
  @override
  State<PTIntro> createState() => _PTIntroState();
}

class _PTIntroState extends State<PTIntro> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.BACK_GROUND_BG,
        bottomNavigationBar: CustomButton(
          onTap: () {
            NavigationService.navigateTo(Routes.chooseSlotScreen);
          },
          text: 'Next',
          bgColor: AppConstants.primaryColor,
          textColor: Colors.white,
          radius: 10.0,
          height: 40.0,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: Consumer<GymStore>(
              builder: (context, store, child) => IntrinsicHeight(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 300.0,
                        child: Stack(
                          // fit: StackFit.expand,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: store.selectedAddOnSlot.image != null
                                  ? Image.network(
                                      store.selectedAddOnSlot.image,
                                      fit: BoxFit.cover,
                                      height: 300.0,
                                    )
                                  : Image.network(
                                      'https://media.istockphoto.com/photos/male-personal-trainer-helping-sportswoman-to-do-exercises-with-at-picture-id972833328?k=20&m=972833328&s=612x612&w=0&h=LtGaklhIxyJbMkxEKDNWzGXgX-zmONE2-llVRDrv17c=',
                                      fit: BoxFit.cover,
                                      height: 300.0,
                                    ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Image.asset(
                                  'assets/images/workout_background.png'),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: ListTile(
                                  title:Text(
                                    store.selectedAddOnSlot.name!=null?store.selectedAddOnSlot.name.capitalize():'No Name',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  )
                              ),
                            )
                            // Positioned(
                            //   bottom: 10.0,
                            //   left: 20.0,
                            //   child: ListTile(
                            //     title:Text(
                            //       store.selectedAddOnSlot.name!=null?store.selectedAddOnSlot.name.capitalize():'No Name',
                            //       style: TextStyle(
                            //         color: Colors.white,
                            //         fontSize: 18.0,
                            //         fontWeight: FontWeight.normal,
                            //       ),
                            //     )
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 20.0,
                        ),
                        child: Text(
                          store.selectedAddOnSlot.description ?? '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 13.0,
                          ),
                        ),
                      ),
                      UIHelper.verticalSpace(4.0),
                      Divider(
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.4),
                      ),
                      FeatureDetails(
                        heading: 'WHY BUY PERSONAL TRAINING?',
                        textColor: AppColors.TEXT_DARK,
                        headingColor: Colors.white,
                        headingSize: 20.0,
                        textSize: 16.0,
                        showVerticalBar: false,
                        items: [
                          {
                            'heading': 'Save More',
                            'text': 'Save up to 15% in per session cost',
                            'image': 'assets/gif/save.gif'
                          },
                          {
                            'heading': 'Be Regular',
                            'text':
                                'People who are regular are 95% more likely to achieve their fitness goals',
                            'image': 'assets/gif/regular.gif'
                          },
                          {
                            'heading': 'Hassle-Free Booking',
                            'text':
                                'Book regular sessions without having to pay every time',
                            'image': 'assets/gif/hassle.gif'
                          }
                        ],
                      ),
                      UIHelper.verticalSpace(12.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BookSession extends StatefulWidget {
  const BookSession({Key key}) : super(key: key);

  @override
  _BookSessionState createState() => _BookSessionState();
}

class _BookSessionState extends State<BookSession> {
  GymStore store;

  @override
  Widget build(BuildContext context) {
    //TODO: navigate to summary page:: bookingSummaryAddOn
    store = context.watch<GymStore>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.BACK_GROUND_BG,
        bottomNavigationBar: CustomButton(
          onTap: () {
            setState(() {
              store.chosenOffer = null;
            });
            if (store.selectedSession != null) {
              NavigationService.navigateTo(Routes.bookingSummaryAddOn);
            } else {
              FlashHelper.informationBar(context,
                  message: 'Please select a session first');
            }
          },
          text: 'Next',
          bgColor: AppConstants.primaryColor,
          textColor: Colors.white,
          radius: 10.0,
          height: 40.0,
        ),
        body: SingleChildScrollView(
          child: Consumer<GymStore>(
            builder: (context, store, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 300.0,
                  child: Stack(
                    // fit: StackFit.expand,
                    children: [
                      Align(
                          alignment: Alignment.topCenter,
                          child: store.selectedAddOnSlot.image != null
                              ? Image.network(
                            store.selectedAddOnSlot.image,
                            fit: BoxFit.cover,
                            height: 300.0,
                          )
                              : Image.network(
                            'https://media.istockphoto.com/photos/male-personal-trainer-helping-sportswoman-to-do-exercises-with-at-picture-id972833328?k=20&m=972833328&s=612x612&w=0&h=LtGaklhIxyJbMkxEKDNWzGXgX-zmONE2-llVRDrv17c=',
                            fit: BoxFit.cover,
                            height: 300.0,
                          )
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(
                            'assets/images/workout_background.png'),
                      ),
                      Positioned(
                        bottom: 10.0,
                        left: 20.0,
                        child: Text(
                          store.selectedAddOnSlot.name.capitalize(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 20.0,
                  ),
                  child: Text(
                    store.selectedAddOnSlot.description.capitalize() ?? '',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 13.0,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(4.0),
                Divider(
                  thickness: 0.5,
                  color: Colors.white.withOpacity(0.4),
                ),
                UIHelper.verticalSpace(24.0),
                IntrinsicHeight(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Select a package',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                      UIHelper.verticalSpace(20.0),
                      Consumer<GymStore>(
                        builder: (context, store, child) => store
                            .selectedAddonSessions !=
                            null
                            ? store.selectedAddonSessions.data.isNotEmpty
                            ? Wrap(
                          children: store
                              .selectedAddonSessions.data
                              .map(
                                (e) => Consumer<GymStore>(
                              builder:
                                  (context, store, child) =>
                                  SessionCard(
                                    data: e,
                                    onSelected: (data) {
                                      store.setSession(data);
                                    },
                                  ),
                            ),
                          )
                              .toList(),
                        )
                            : Container(
                          child: Text(
                            'Sessions Pack Unavailable',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        )
                            : Loader(),
                      ),
                    ],
                  ),
                ),
                UIHelper.verticalSpace(12.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FeatureDetails extends StatelessWidget {
  final String heading;
  final Color headingColor;
  final Color textColor;
  final double headingSize;
  final double textSize;
  final List<Map<String, String>> items;
  final bool showVerticalBar;

  FeatureDetails({
    this.heading,
    this.headingColor,
    this.headingSize,
    this.textSize,
    this.textColor,
    this.items,
    this.showVerticalBar,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              heading,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: headingColor,
                fontSize: headingSize,
              ),
            ),
            UIHelper.verticalSpace(6.0),
            ...items.map(
              (e) => FeatureDetailCard(
                textColor: textColor,
                headingColor: headingColor,
                headingSize: headingSize,
                textSize: textSize,
                image: e['image'],
                heading: e['heading'],
                text: e['text'],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureDetailCard extends StatelessWidget {
  final String heading;
  final String text;
  final Color headingColor;
  final Color textColor;
  final double headingSize;
  final double textSize;
  final String image;

  FeatureDetailCard({
    this.heading,
    this.headingColor,
    this.textColor,
    this.headingSize,
    this.textSize,
    this.image,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          // Expanded(
          //   flex: 1,
          //   child: Lottie.asset(image),
          // ),
          Expanded(
            flex: 1,
            child: Image.asset(image),
          ),
          UIHelper.horizontalSpace(20.0),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    heading,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: headingColor,
                      fontSize: headingSize - 2.0,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(6.0),
                Flexible(
                  child: Text(
                    text,
                    // overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: textColor,
                      fontSize: textSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SessionCard extends StatefulWidget {
  final SessionData data;
  final Function(SessionData) onSelected;

  SessionCard({
    this.data,
    this.onSelected,
  });

  @override
  _SessionCardState createState() => _SessionCardState();
}

class _SessionCardState extends State<SessionCard> {
  SessionData get data => widget.data;

  GymStore store;

  @override
  void didUpdateWidget(covariant SessionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    store = context.watch<GymStore>();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            widget.onSelected(data);
          });
        },
        child: IntrinsicHeight(
          child: Card(
            color: AppColors.PRIMARY_COLOR,
            elevation: 16.0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 10.0,
                      ),
                      padding: const EdgeInsets.all(2.0),
                      width: 24.0,
                      height: 24.0,
                      decoration: BoxDecoration(
                        color: store.selectedSession == data
                            ? Colors.green
                            : AppConstants.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: store.selectedSession == data
                            ? Colors.white
                            : AppConstants.primaryColor,
                        size: 12.0,
                      ),
                    ),
                  ),
                  UIHelper.horizontalSpace(16.0),
                  Flexible(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${data.nSession} Session',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6.0,
                                horizontal: 12.0,
                              ),
                              decoration: BoxDecoration(
                                color: AppConstants.primaryColor,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Text(
                                'Rs.${data.price}',
                                style: TextStyle(
                                  color: AppConstants.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Validity : ',
                            style: TextStyle(
                              color: AppColors.TEXT_DARK,
                              fontSize: 12.0,
                            ),
                            children: [
                              TextSpan(text: '${data.duration} Days'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
