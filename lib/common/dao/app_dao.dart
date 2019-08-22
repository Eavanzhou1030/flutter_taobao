import 'package:flutter_taobao/common/services/address.dart';
import 'package:flutter_taobao/common/services/api.dart';

class AppDao {
  // 获取仓库的release列表
  static getRepositoryReleaseDao(userName, reposName, page, {needHtml = true, release = true}) async {
    String url = release
      ? Address.getReposRelease(userName, reposName) + Address.getPageParams("?", page)
      : Address.getReposTag(userName, reposName) + Address.getPageParams("?", page);

    var res = await httpManager.netFetch(url, null, {"Accept": (needHtml ? '' : '')}, null);
  }

  // 版本更新
  static getNewsVersion(context, showTip) async {

  }
}