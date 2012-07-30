//
//  GoogleAPI.h
//  Image Search
//
//  Created by Sean Yu on 7/29/12.
//  Copyright (c) 2012 Blackboard Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISServer : NSObject
{
	
}

+ (void)imageSearchWithQuery:(NSString *)query success:(void (^)(id data))success failure:(void (^)(NSError *error))failure;

@end
