//
//  ThreadPoolManage.m
//  MulitThread
//
//  Created by Ltian on 14/10/31.
//  Copyright (c) 2014年 Ltian. All rights reserved.
//

#import "ThreadPoolManage.h"
static ThreadPoolManage * instance;
@implementation ThreadPoolManage
+ (instancetype)shareManage
{
    if (!instance) {
        instance = [[ThreadPoolManage alloc]init];
    }

    return instance;
}
- (void)addBlockTaskPriorty:(PRIORTY) priorty withBlock:(void (^)(void))block;
{
    if (!block) {
        return;
    }
    else{
        switch (priorty) {
            case PRIORITY_HIGH:
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0), block);
                break;
            case PRIORITY_DEFAULT:
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), block);
                break;
            case PRIORITY_LOW:
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), block);
            default:
                break;
        }
    }
}
- (dispatch_queue_t)getMainThread
{
    return dispatch_get_main_queue();
}
- (void)taskOnMainThread:(void(^)(void)) block
{
    if (!block) {
        return;
    }
    else{
        dispatch_async(dispatch_get_main_queue(), block);
    }
}
- (void)addSELTaskWithTarget:(id)obj withPriorty:(PRIORTY)priorty withSEL:(SEL)sel;
{
    if ([obj respondsToSelector:sel]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0), ^(void){
            [obj performSelector:sel];
        });
        switch (priorty) {
            case PRIORITY_HIGH:
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0), ^(void){
                    [obj performSelector:sel];
                });
                break;
            case PRIORITY_DEFAULT:
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^(void){
                        [obj performSelector:sel];
                    });
                break;
            case PRIORITY_LOW:
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^(void){
                            [obj performSelector:sel];
                        });
            default:
                break;
        }
    }
    else
    {
        return ;
    }
        
}
@end
