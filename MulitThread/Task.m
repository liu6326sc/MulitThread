//
//  Task.m
//  MulitThread
//
//  Created by Ltian on 14/10/31.
//  Copyright (c) 2014年 Ltian. All rights reserved.
//

#import "Task.h"
#import "ThreadPoolManage.h"
@implementation Task
- (void)run
{
    //ThreadPoolManage * manger = [ThreadPoolManage shareManage];
    [[ThreadPoolManage shareManage] addSELTaskWithTarget:self withPriorty:PRIORITY_HIGH withSEL:@selector(test)];
    
}
-(void)test
{
    NSLog(@"test");
}
@end
