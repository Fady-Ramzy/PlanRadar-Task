//
//  APIClient.h
//  PlanRadar-Task
//
//  Created by Fady Ramzy on 17/07/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^CompleteDiceRolling)(NSInteger diceValue);

@interface APIClient : NSObject

+ (id) sharedInstanceX;
- (void) sendRequestWithURL: (NSString *) url parameters: (NSDictionary* _Nullable)params httpHeaders: (NSDictionary* _Nullable)headers httpMethod: (NSString *) method completionHandler: (void (^)( id _Nullable  result, NSError*  _Nullable error))finishBlock ;

@end

NS_ASSUME_NONNULL_END
