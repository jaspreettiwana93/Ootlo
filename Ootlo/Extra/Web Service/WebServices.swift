//
//  WebServices.swift
//  YoutubeSwift
//
//  Created by Gurinder Singh Batth on 19/06/17.
//  Copyright © 2017 Batth. All rights reserved.
//

import UIKit
import SystemConfiguration

var blurView = UIView()
var loadingMessage = UILabel()
var indicatorView: NVActivityIndicatorView!
let API_URL = "http://ootlo.com/backend"

extension UIViewController{
    
    
    func webservicesPostRequest(method: String, parameters: NSDictionary?, isIndicator: Bool, indicatorMessage: String = "Loading...", isToast: Bool = true, success:@escaping (_ response: NSDictionary)-> Void, failure:@escaping (_ error: Error) -> Void){

        if(connectedToNetwork())
        {
            let headers = [
                "content-type": "application/json"
                ]
            let sessionConfiguration = URLSessionConfiguration.default
            //        var session:URLSession
            let session = URLSession(configuration: sessionConfiguration, delegate: nil, delegateQueue: OperationQueue.main)

            let jsonData = try? JSONSerialization.data(withJSONObject:parameters!)


            let url = "\(API_URL)/\(method)"

            print(url)
            print(parameters!)

            var request = URLRequest(url: URL(string: url)!)
            request.allHTTPHeaderFields = headers
            request.httpMethod = "POST"
            request.httpBody = jsonData

            if(isIndicator)
            {
                self.indicator(isIndicator, message: indicatorMessage)
            }

            let dataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                if(isIndicator)
                {
                    self.indicator(false)
                }

                if error == nil{
                    if let responseData = data{
                        do {
//                            let json = try JSONSerialization.jsonObject(with: responseData, options: [])
                            let json = try JSONSerialization.jsonObject(with: responseData, options: [.allowFragments])
                            
                            success(json as! NSDictionary)
                            
                        }
                        catch let err{
                            //                        if(err.localizedDescription == )
                            print(err)
                            failure(err)
                            if(isToast)
                            {
                                self.view.showJToast(_message: ERROR_UNABLE_TO_PARSE_JSON, _bgImage: UIImage(), _bgColor: UIColor.JToastBGColor.warningColor, _textColor: .white, _type: .warning)
                            }
                        }
                    }
                }
                else
                {
                    failure(error!)
                    if(isToast)
                    {
                        if(error?._code == NSURLErrorTimedOut)
                        {
                            self.view.showJToast(_message: ERROR_REQUEST_TIMEOUT, _bgImage: UIImage(), _bgColor: UIColor.JToastBGColor.warningColor, _textColor: .white, _type: .warning)
                        }
                        else
                        {
                            self.view.showJToast(_message: ERROR_UNKNOWN, _bgImage: UIImage(), _bgColor: UIColor.JToastBGColor.warningColor, _textColor: .white, _type: .warning)
                        }
                    }
                    
                }
            }
            dataTask.resume()
        }
        else
        {
            if(isToast)
            {
                failure(NSError(domain: "www.google.com", code: 123, userInfo: [:]))
                self.view.showJToast(_message: ERROR_INTERNET_NOT_AVAILABLE, _bgImage: UIImage(), _bgColor: .gray, _textColor: .white, _type: .warning)
            }
        }



    }

//    func webservicesGetRequest(method: String, isIndicator: Bool,success:@escaping (_ response: NSDictionary)-> Void, failure:@escaping (_ error: Error) -> Void){
//
//        if(connectedToNetwork())
//        {
//            let headers = [
//                "content-type": "application/json"
//            ]
//            let sessionConfiguration = URLSessionConfiguration.default
//            //        var session:URLSession
//            let session = URLSession(configuration: sessionConfiguration, delegate: nil, delegateQueue: OperationQueue.main)
//
//            let url = "\(API_URL)/\(method)"
//
//            print(url)
//            //            print(parameters!)
//
//            var request = URLRequest(url: URL(string: url)!)
//            request.allHTTPHeaderFields = headers
//            request.httpMethod = "GET"
//
//            self.indicator(isIndicator)
//
//            request.timeoutInterval = 60.0
//            let dataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
//                if(isIndicator)
//                {
//                    self.indicator(false)
//                }
//
//                if error == nil{
//                    if let responseData = data{
//                        do {
//                            //                            let json = try JSONSerialization.jsonObject(with: responseData, options: [])
//                            let json = try JSONSerialization.jsonObject(with: responseData, options: [.allowFragments])
//                            success(json as! NSDictionary)
//
//                        }
//                        catch let err{
//                            //                        if(err.localizedDescription == )
//                            print(err)
//                            failure(err)
//                        }
//
//                    }
//                }else{
//                    failure(error!)
//                    if(error?._code == NSURLErrorTimedOut)
//                    {
//                        self.view.showJToast(_message: ERROR_REQUEST_TIMEOUT, _bgImage: UIImage(), _bgColor: .gray, _textColor: .white, _type: .warning)
//                    }
//                    else
//                    {
//                        self.view.showJToast(_message: ERROR_UNKNOWN, _bgImage: UIImage(), _bgColor: .gray, _textColor: .white, _type: .warning)
//                    }
//                }
//            }
//            dataTask.resume()
//        }
//        else
//        {
//            failure(NSError(domain: "www.google.com", code: 123, userInfo: [:]))
//            self.view.showJToast(_message: ERROR_INTERNET_NOT_AVAILABLE, _bgImage: UIImage(), _bgColor: .gray, _textColor: .white, _type: .warning)
//        }
//
//
//
//    }
    
    
    //**********IMAGE UPLOAD WEBSERVICE******************
    func webservicesPostImageRequest(baseString: String, imageParams: NSDictionary?, parameters: NSDictionary?, isIndicator: Bool, indicatorMessage: String = "Loading...",success:@escaping (_ response: NSDictionary)-> Void, failure:@escaping (_ error: Error) -> Void){

        if(connectedToNetwork())
        {
//            let data = UIImageJPEGRepresentation(image, 0.5)
            let url = "\(API_URL)/\(baseString)"
            if(isIndicator)
            {
                self.indicator(isIndicator, message: indicatorMessage)
            }
            UploadImageWebService.uploadImages(imageParams as! [AnyHashable : UIImage], parameters: parameters as! [String : Any], url: url, completion: { (succes, data, error) in
                if(isIndicator)
                {
                    self.indicator(false)
                }
                
                if error == nil{
//                    if let responseData = data{
//                        do {
//                            let json = try JSONSerialization.jsonObject(with: responseData, options: [])
                    
                    success(data! as NSDictionary)
                    
//                        success(data! as NSDictionary)
                    
//                        }catch let err{
//                            //                        if(err.localizedDescription == )
//                            print(err)
//                            failure(err)
//                        }
//                }
                }else{
                    failure(error!)
                    if(error?._code == NSURLErrorTimedOut)
                    {
                        self.view.showJToast(_message: ERROR_REQUEST_TIMEOUT, _bgImage: UIImage(), _bgColor: .gray, _textColor: .white, _type: .warning)
                    }
                    else
                    {
                        self.view.showJToast(_message: ERROR_UNKNOWN, _bgImage: UIImage(), _bgColor: .gray, _textColor: .white, _type: .warning)
                    }
                }
            })

            print(url)
            print(parameters!)
        }
        else
        {
            failure(NSError(domain: "www.google.com", code: 123, userInfo: [:]))
            self.view.showJToast(_message: ERROR_INTERNET_NOT_AVAILABLE, _bgImage: UIImage(), _bgColor: .gray, _textColor: .white, _type: .warning)
        }
    }
    
    func connectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }

    func alert(title:String , message: String)
    {
        
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
  
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    func isIndicatorRunning() -> Bool
    {
        return (indicatorView?.isAnimating) ?? false
    }
    
    func indicator(_ isTrue:Bool, message: String = "")
    {
        blurView.frame = CGRect(x: 0, y: -20, width: self.view.frame.size.width, height: self.view.frame.size.height + 20)
        blurView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.view.addSubview(blurView)
        
        blurView.isHidden = true
        
        loadingMessage.frame = CGRect(x: 0, y: (UIScreen.main.bounds.size.height / 2) + 45, width: view.frame.size.width, height: 50)
        loadingMessage.text = message
        loadingMessage.textColor = .white
        loadingMessage.textAlignment = .center
        view.addSubview(loadingMessage)
        loadingMessage.isHidden = true
        
        if(indicatorView == nil)
        {
            let x = (UIScreen.main.bounds.size.width / 2) - 35
            let y = (UIScreen.main.bounds.size.height / 2) - 35
            
            indicatorView = NVActivityIndicatorView(frame: CGRect(x: x, y: y, width: 70, height: 70), type: .lineScalePulseOut, color: .white, padding: 0)
        }
        
        view.addSubview(indicatorView ?? UIView())
        if(isTrue)
        {
            indicatorView?.startAnimating()
            blurView.isHidden = false
            indicatorView?.isHidden = false
            loadingMessage.isHidden = false
        }
        else
        {
            indicatorView?.stopAnimating()
            blurView.isHidden = true
            indicatorView?.isHidden = true
            loadingMessage.isHidden = true
            
            blurView.removeFromSuperview()
            loadingMessage.removeFromSuperview()
            indicatorView?.removeFromSuperview()
        }
    }
}


