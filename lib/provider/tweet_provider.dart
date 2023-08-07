import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitter_clone/modal/tweet.dart';
import 'package:flutter_twitter_clone/provider/user_provider.dart';

final tweetProvider = Provider<TweeterApi>((ref) {
  return TweeterApi(ref);
});

class TweeterApi {
  TweeterApi(this.ref);
  final Ref ref;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> postTweet(String tweet) async {
    LocalUser currentUser = ref.read(userProvider);
    await _firestore.collection("tweets").add(
          Tweet(
            uid: currentUser.id,
            profilePic: currentUser.user.profilePic,
            name: currentUser.user.name,
            tweet: tweet,
            postTime: Timestamp.now(),
          ).toMap(),
        );
  }
}
