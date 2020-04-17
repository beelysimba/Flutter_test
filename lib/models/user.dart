import 'package:json_annotation/json_annotation.dart';



part 'user.g.dart';

@JsonSerializable()
class User {
      User();

  @JsonKey(name: 'user_id') int userId;
  String name;
  Map<String, dynamic> photo;
  String intro;
  int gender;
  int approve;
  int decade;
  String address;
  @JsonKey(name: 'fans_count') int fansCount;
  @JsonKey(name: 'follow_count') int followCount;
  @JsonKey(name: 'msg_count') int msgCount;
  @JsonKey(name: 'dub_count') int dubCount;
  @JsonKey(name: 'expl_count') int explCount;
  @JsonKey(name: 'photo_count') int photoCount;
  int score;
  @JsonKey(name: 'score_title') String scoreTitle;
  @JsonKey(name: 'score_level') int scoreLevel;
  @JsonKey(name: 'upgrade_score') int upgradeScore;
  int coin;
  @JsonKey(name: 'learn_second') int learnSecond;
  @JsonKey(name: 'sign_in_count') int signInCount;
  @JsonKey(name: 'approve_info') Map<String, dynamic> approveInfo;
  int type;
  String email;
  String phone;
  @JsonKey(name: 'notice_phone') String noticePhone;
  @JsonKey(name: 'continuation_days') int continuationDays;
  String birthday;
  @JsonKey(name: 'reg_client') String regClient;
  @JsonKey(name: 'reg_time') String regTime;
  @JsonKey(name: 'email_activation') int emailActivation;
  @JsonKey(name: 'last_auth_method') String lastAuthMethod;
  @JsonKey(name: 'is_membership') int isMembership;
  Map<String, dynamic> vip;
  @JsonKey(name: 'c_count') int cCount;
  @JsonKey(name: 'last_auth_type') int lastAuthType;
  @JsonKey(name: 'album_count') int albumCount;
  Map<String, dynamic> tags;
  @JsonKey(name: 'membership_expire') String membershipExpire;
  @JsonKey(name: 'membership_expire_desc') String membershipExpireDesc;
  @JsonKey(name: 'is_plan') int isPlan;
  @JsonKey(name: 'plan_expire') String planExpire;
  @JsonKey(name: 'plan_expire_desc') String planExpireDesc;
  int level;
  @JsonKey(name: 'class_start_date') String classStartDate;
  @JsonKey(name: 'lastest_level') String lastestLevel;
  @JsonKey(name: 'is_super_star') int isSuperStar;
  @JsonKey(name: 'is_bought_study_plan') int isBoughtStudyPlan;
  Map<String, dynamic> extension;
  Map<String, dynamic> quota;
  @JsonKey(name: 'red_package_total') int redPackageTotal;
  @JsonKey(name: 'invite_coupon') List<dynamic> inviteCoupon;
  @JsonKey(name: 'compensative_card_total') int compensativeCardTotal;
  @JsonKey(name: 'invite_friend') Map<String, dynamic> inviteFriend;
  @JsonKey(name: 'is_show_diamond') int isShowDiamond;
  @JsonKey(name: 'diamond_amount') String diamondAmount;

  factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}