class CategoryEntity {
	String code;
	List<CategoryPageModelData> data;
	String message;

	CategoryEntity({this.code, this.data, this.message});

	CategoryEntity.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		if (json['data'] != null) {
			data = new List<CategoryPageModelData>();(json['data'] as List).forEach((v) { data.add(new CategoryPageModelData.fromJson(v)); });
		}
		message = json['message'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = this.code;
		if (this.data != null) {
      data['data'] =  this.data.map((v) => v.toJson()).toList();
    }
		data['message'] = this.message;
		return data;
	}
}

class CategoryPageModelData {
	String image;
	List<CategoryPageModelDataBxmallsubdto> bxMallSubDto;
	dynamic comments;
	String mallCategoryId;
	String mallCategoryName;

	CategoryPageModelData({this.image, this.bxMallSubDto, this.comments, this.mallCategoryId, this.mallCategoryName});

	CategoryPageModelData.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		if (json['bxMallSubDto'] != null) {
			bxMallSubDto = new List<CategoryPageModelDataBxmallsubdto>();(json['bxMallSubDto'] as List).forEach((v) { bxMallSubDto.add(new CategoryPageModelDataBxmallsubdto.fromJson(v)); });
		}
		comments = json['comments'];
		mallCategoryId = json['mallCategoryId'];
		mallCategoryName = json['mallCategoryName'];


	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		if (this.bxMallSubDto != null) {
      data['bxMallSubDto'] =  this.bxMallSubDto.map((v) => v.toJson()).toList();
    }
		data['comments'] = this.comments;
		data['mallCategoryId'] = this.mallCategoryId;
		data['mallCategoryName'] = this.mallCategoryName;
		return data;
	}
}

class CategoryPageModelDataBxmallsubdto {
	String mallSubName;
	String comments;
	String mallCategoryId;
	String mallSubId;

	CategoryPageModelDataBxmallsubdto({this.mallSubName, this.comments, this.mallCategoryId, this.mallSubId});

	CategoryPageModelDataBxmallsubdto.fromJson(Map<String, dynamic> json) {
		mallSubName = json['mallSubName'];
		comments = json['comments'];
		mallCategoryId = json['mallCategoryId'];
		mallSubId = json['mallSubId'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['mallSubName'] = this.mallSubName;
		data['comments'] = this.comments;
		data['mallCategoryId'] = this.mallCategoryId;
		data['mallSubId'] = this.mallSubId;
		return data;
	}
}
