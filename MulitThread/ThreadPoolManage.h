//
//  ThreadPoolManage.h
//  MulitThread
//
//  Created by Ltian on 14/10/31.
//  Copyright (c) 2014年 Ltian. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    PRIORITY_HIGH,
    PRIORITY_DEFAULT,
    PRIORITY_LOW
}PRIORTY;
enum{sun,mon,tue,wed,thu,fri,sat}asd,b,c;
@interface ThreadPoolManage : NSObject

/**
 *获取单例
 */
+ (instancetype) shareManage;

/**
 *bllck添加新任务
 *@param PRIORTY 优先级
 *@param block 任务
 */
- (void)addBlockTaskPriorty:(PRIORTY) priorty withBlock:(void (^)(void))block;

/**
 *返回主线程
 */
- (dispatch_queue_t)getMainThread;

/**
 *bllck添加任务到主线程
 *@param block 任务
 */
- (void)taskOnMainThread:(void(^)(void)) block;

/**
 *SEL添加任务到主线程
 *@param id 传入对象
 *@param PRIORTY 优先级
 *@param SEL 方法
 */
- (void)addSELTaskWithTarget:(id)obj withPriorty:(PRIORTY)priorty withSEL:(SEL)sel;
@end
