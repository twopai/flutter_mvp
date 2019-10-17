/**
 * 可以在Android studio中集成插件flutterjsonbeanfactory，然后复制json右键JsonToDartBeanAction直接生成此文件
 */
class RunshopEntity {
	List<RunshopList> xList;

	@override
	String toString() {
		return 'RunshopEntity{xList: $xList}';
	}

	RunshopEntity({this.xList});

	RunshopEntity.fromJson(Map<String, dynamic> json) {
		if (json['list'] != null) {
			xList = new List<RunshopList>();(json['list'] as List).forEach((v) { xList.add(new RunshopList.fromJson(v)); });
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

class RunshopList {
	int id;
	String title;

	@override
	String toString() {
		return 'RunshopList{id: $id, title: $title}';
	}

	RunshopList({ this.id,this.title});

	RunshopList.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['title'] = this.title;
		return data;
	}
}
