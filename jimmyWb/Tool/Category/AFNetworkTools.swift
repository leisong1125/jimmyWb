//
//  AFNetworkTools.swift
//  AFNetworkingHelper
//
//  Created by jimmy on 2016/12/15.
//  Copyright © 2016年 jimmy. All rights reserved.
//

import AFNetworking

enum RequestType {
    case GET
    case POST
}


class AFNetworkTools: AFHTTPSessionManager {

    // let 是线程安全的
    static let shareInstance : AFNetworkTools = {
        let tools = AFNetworkTools()
        
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")

        return tools
        
    }()
}

//MARK:- # 请求 AccessToken
extension AFNetworkTools {
    
    func loadAccessToken(code : String, finished : @escaping (_ result : [String : AnyObject]?, _ error : NSError?) -> ()) {
        
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let parameters = ["client_id" : app_key, "client_secret" : app_secret, "grant_type" : "authorization_code", "redirect_uri" : redirect_uri, "code" : code]
        
        request(type: .POST, urlString: urlString, parameters: parameters, finished:  {(result : AnyObject?,error : Error?) -> () in
            finished(result as? [String : AnyObject], error as? NSError)
        })
  
    }
}

//MARK:- # 请求用户信息
extension AFNetworkTools {
    
    func loadUserInfo(access_token : String, uid : String, finished : @escaping (_ result : [String : AnyObject]?, _ error : NSError?) -> ()) {
        
        let urlString = "https://api.weibo.com/2/users/show.json"
        let parameters = ["access_token" : access_token, "uid" : uid]
        
        request(type: .GET, urlString: urlString, parameters: parameters, finished: {(result : AnyObject?,error : Error?) -> () in
            finished(result as? [String : AnyObject], error as? NSError)
        })
    }  
}

//MARK:- # 请求首页数据
extension AFNetworkTools {
    
    func loadStatuses(finished : @escaping ( _ result : [[String : AnyObject]]?, _ error : Error?) -> ()) {
    
        let urlString = "https://api.weibo.com/2/statuses/friends_timeline.json"
        let parameters = ["access_token" : (UserAccoutTool.shareTool.accout?.access_token)!]
        
        request(type: .GET, urlString: urlString, parameters: parameters, finished: {(result : AnyObject?, error : Error?) -> Void in
        
            guard let resultDic = result as? [String : AnyObject] else {
               finished(nil, error)
                return
            }
            
            finished(resultDic["statuses"] as! [[String : AnyObject]]?, error)
        
        })  
    }
    
}



//MARK:- # 封装请求方法
extension AFNetworkTools {
    
    func request(type : RequestType,  urlString : String, parameters : [String : Any], finished : @escaping (_ result : AnyObject?, _ error : Error?) -> ()) {
        let successBlock = {(task : URLSessionDataTask, result :  Any?) -> Void in
            finished(result as AnyObject?, nil)
        }
        
        let failBlock = {(task : URLSessionDataTask?, error :  Error) -> Void in
            finished(nil, error)
        }

        if type == .GET {
            get(urlString, parameters: parameters, progress: nil, success: successBlock, failure: failBlock)
        }else
        {
            post(urlString, parameters: parameters, progress: nil, success: successBlock, failure: failBlock)
        }
    }
}
