
class Feed{
  String id = "",
         imagePath = "",
         title = "";
  Feed(){}

  factory Feed.fromJson(dynamic json) {

    Feed pi = new Feed();

    if(json['id'] != null){
      pi.id = json['id'];
    }

    if(json['imagePath'] != null){
      pi.imagePath = json['imagePath'];
    }

    if(json['title'] != null){
      pi.title = json['title'];
    }

    return pi;
  }

  Map<String, dynamic> toJson(){
    return {
      "id": this.id,
      "imagePath": this.imagePath,
      "title": this.title,
    };
  }
}