class RunshoptypeEntity {
	List<RunshoptypeList> xList;

	@override
	String toString() {
		return 'RunshoptypeEntity{xList: $xList}';
	}

	RunshoptypeEntity({this.xList});

	RunshoptypeEntity.fromJson(Map<String, dynamic> json) {
		if (json['list'] != null) {
			xList = new List<RunshoptypeList>();(json['list'] as List).forEach((v) { xList.add(new RunshoptypeList.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.xList != null) {
      data['list'] =  this.xList.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class RunshoptypeList {
	String name;
	int id;

	@override
	String toString() {
		return 'RunshoptypeList{name: $name,  id: $id}';
	}

	RunshoptypeList({this.name,  this.id});

	RunshoptypeList.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['id'] = this.id;
		return data;
	}
}
