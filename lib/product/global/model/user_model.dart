class UserModel {
  int? id;
  String? name;
  String? firstName;
  String? email;
  bool? isActive;
  String? password;
  List<Works>? works;
  List<Videos>? videos;

  UserModel(
      {this.id,
      this.name,
      this.firstName,
      this.email,
      this.isActive,
      this.password,
      this.works,
      this.videos});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['firstName'];
    email = json['email'];
    isActive = json['isActive'];
    password = json['password'];
    if (json['works'] != null) {
      works = <Works>[];
      json['works'].forEach((v) {
        works!.add(Works.fromJson(v));
      });
    }
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(Videos.fromJson(v));
      });
    }
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['firstName'] = firstName;
    data['email'] = email;
    data['isActive'] = isActive;
    data['password'] = password;
    if (works != null) {
      data['works'] = works!.map((v) => v.toJson()).toList();
    }
    if (videos != null) {
      data['videos'] = videos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Works {
  int? assignmentId;
  String? description;
  bool? isCompleted;
  int? userId;

  Works({this.assignmentId, this.description, this.isCompleted, this.userId});

  Works.fromJson(Map<String, dynamic> json) {
    assignmentId = json['assignmentId'];
    description = json['description'];
    isCompleted = json['isCompleted'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['isCompleted'] = isCompleted;
    data['userId'] = userId;
    return data;
  }
}

class Videos {
  int? videoId;
  String? title;
  String? url;
  String? duration;
  bool? isWatched;
  bool? isLiked;
  String? currentTime;
  DateTime? lastWatched;
  int? userId;

  Videos({
    this.videoId,
    this.title,
    this.url,
    this.duration,
    this.isWatched,
    this.isLiked,
    this.currentTime,
    this.lastWatched,
    this.userId,
  });

  Videos copyWith({
    int? videoId,
    String? title,
    String? url,
    String? duration,
    bool? isWatched,
    bool? isLiked,
    String? currentTime,
    DateTime? lastWatched,
    int? userId,
  }) {
    return Videos(
      videoId: videoId ?? this.videoId,
      title: title ?? this.title,
      url: url ?? this.url,
      duration: duration ?? this.duration,
      isWatched: isWatched ?? this.isWatched,
      isLiked: isLiked ?? this.isLiked,
      currentTime: currentTime ?? this.currentTime,
      lastWatched: lastWatched,
      userId: userId ?? this.userId,
    );
  }

  Videos.fromJson(Map<String, dynamic> json) {
    videoId = json['videoId'];
    title = json['title'];
    url = json['url'];
    duration = json['duration'];
    isWatched = json['isWatched'];
    isLiked = json['isLiked'];
    currentTime = json['currentTime'];
    lastWatched = json['lastWatched'] != null
        ? DateTime.parse(json['lastWatched'])
        : null;
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['videoId'] = videoId;
    data['title'] = title;
    data['url'] = url;
    data['duration'] = duration;
    data['isWatched'] = isWatched;
    data['isLiked'] = isLiked;
    data['currentTime'] = currentTime;
    if (lastWatched != null) {
    data['lastWatched'] = lastWatched!.toIso8601String();
  } else {
    data['lastWatched'] = null;
  }
    data['userId'] = userId;
    return data;
  }
}

