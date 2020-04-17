// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..userId = json['user_id'] as int
    ..name = json['name'] as String
    ..photo = json['photo'] as Map<String, dynamic>
    ..intro = json['intro'] as String
    ..gender = json['gender'] as int
    ..approve = json['approve'] as int
    ..decade = json['decade'] as int
    ..address = json['address'] as String
    ..fansCount = json['fans_count'] as int
    ..followCount = json['follow_count'] as int
    ..msgCount = json['msg_count'] as int
    ..dubCount = json['dub_count'] as int
    ..explCount = json['expl_count'] as int
    ..photoCount = json['photo_count'] as int
    ..score = json['score'] as int
    ..scoreTitle = json['score_title'] as String
    ..scoreLevel = json['score_level'] as int
    ..upgradeScore = json['upgrade_score'] as int
    ..coin = json['coin'] as int
    ..learnSecond = json['learn_second'] as int
    ..signInCount = json['sign_in_count'] as int
    ..approveInfo = json['approve_info'] as Map<String, dynamic>
    ..type = json['type'] as int
    ..email = json['email'] as String
    ..phone = json['phone'] as String
    ..noticePhone = json['notice_phone'] as String
    ..continuationDays = json['continuation_days'] as int
    ..birthday = json['birthday'] as String
    ..regClient = json['reg_client'] as String
    ..regTime = json['reg_time'] as String
    ..emailActivation = json['email_activation'] as int
    ..lastAuthMethod = json['last_auth_method'] as String
    ..isMembership = json['is_membership'] as int
    ..vip = json['vip'] as Map<String, dynamic>
    ..cCount = json['c_count'] as int
    ..lastAuthType = json['last_auth_type'] as int
    ..albumCount = json['album_count'] as int
    ..tags = json['tags'] as Map<String, dynamic>
    ..membershipExpire = json['membership_expire'] as String
    ..membershipExpireDesc = json['membership_expire_desc'] as String
    ..isPlan = json['is_plan'] as int
    ..planExpire = json['plan_expire'] as String
    ..planExpireDesc = json['plan_expire_desc'] as String
    ..level = json['level'] as int
    ..classStartDate = json['class_start_date'] as String
    ..lastestLevel = json['lastest_level'] as String
    ..isSuperStar = json['is_super_star'] as int
    ..isBoughtStudyPlan = json['is_bought_study_plan'] as int
    ..extension = json['extension'] as Map<String, dynamic>
    ..quota = json['quota'] as Map<String, dynamic>
    ..redPackageTotal = json['red_package_total'] as int
    ..inviteCoupon = json['invite_coupon'] as List
    ..compensativeCardTotal = json['compensative_card_total'] as int
    ..inviteFriend = json['invite_friend'] as Map<String, dynamic>
    ..isShowDiamond = json['is_show_diamond'] as int
    ..diamondAmount = json['diamond_amount'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'user_id': instance.userId,
      'name': instance.name,
      'photo': instance.photo,
      'intro': instance.intro,
      'gender': instance.gender,
      'approve': instance.approve,
      'decade': instance.decade,
      'address': instance.address,
      'fans_count': instance.fansCount,
      'follow_count': instance.followCount,
      'msg_count': instance.msgCount,
      'dub_count': instance.dubCount,
      'expl_count': instance.explCount,
      'photo_count': instance.photoCount,
      'score': instance.score,
      'score_title': instance.scoreTitle,
      'score_level': instance.scoreLevel,
      'upgrade_score': instance.upgradeScore,
      'coin': instance.coin,
      'learn_second': instance.learnSecond,
      'sign_in_count': instance.signInCount,
      'approve_info': instance.approveInfo,
      'type': instance.type,
      'email': instance.email,
      'phone': instance.phone,
      'notice_phone': instance.noticePhone,
      'continuation_days': instance.continuationDays,
      'birthday': instance.birthday,
      'reg_client': instance.regClient,
      'reg_time': instance.regTime,
      'email_activation': instance.emailActivation,
      'last_auth_method': instance.lastAuthMethod,
      'is_membership': instance.isMembership,
      'vip': instance.vip,
      'c_count': instance.cCount,
      'last_auth_type': instance.lastAuthType,
      'album_count': instance.albumCount,
      'tags': instance.tags,
      'membership_expire': instance.membershipExpire,
      'membership_expire_desc': instance.membershipExpireDesc,
      'is_plan': instance.isPlan,
      'plan_expire': instance.planExpire,
      'plan_expire_desc': instance.planExpireDesc,
      'level': instance.level,
      'class_start_date': instance.classStartDate,
      'lastest_level': instance.lastestLevel,
      'is_super_star': instance.isSuperStar,
      'is_bought_study_plan': instance.isBoughtStudyPlan,
      'extension': instance.extension,
      'quota': instance.quota,
      'red_package_total': instance.redPackageTotal,
      'invite_coupon': instance.inviteCoupon,
      'compensative_card_total': instance.compensativeCardTotal,
      'invite_friend': instance.inviteFriend,
      'is_show_diamond': instance.isShowDiamond,
      'diamond_amount': instance.diamondAmount,
    };
