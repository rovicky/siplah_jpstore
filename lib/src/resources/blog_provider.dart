import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:flutter/foundation.dart';
import 'package:siplah_jpmall/src/models/Blog.dart';
import 'package:siplah_jpmall/src/utils/base_url.dart';
//import '';

class BlogProvider{
  Client client = Client();
  final url = BaseUrl.base + "blog/blog_footer";
  Future<List<Blog>> fetchBlog() async {
    final response = await client.get(url,headers: {"Content-Type": BaseUrl.headers.contentTypeurlx,"API-App":BaseUrl.headers.apiApp,"Api-Key":BaseUrl.headers.apiKey,"API-Token":BaseUrl.headers.apiToken},);
    
    //print(response.body);
    if(response.statusCode == 200){
      return compute(blogsFromJson, response.body);
    }else{
      throw Exception("Failed to Load");
    }
  }
}