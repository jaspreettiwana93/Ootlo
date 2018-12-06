//
//  UploadImageWebService.h
//  Tow to Go
//
//  Created by SIERRA on 11/23/17.
//  Copyright © 2017 SIERRA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadImageWebService : UIViewController
+(void)uploadImages:(NSDictionary*)images parameters:(NSDictionary*)_params url:(NSString*)urlString completion:(void (^)(bool success, NSDictionary* jsonData,  NSError* error))completionHandler;
@end
