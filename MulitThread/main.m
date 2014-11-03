//
//  main.m
//  MulitThread
//
//  Created by Ltian on 14/10/31.
//  Copyright (c) 2014年 Ltian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThreadPoolManage.h"
#import "Task.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
 //       NSOperationQueue* queue = [[NSOperationQueue alloc]init];
//        for (int i = 0 ; i < 10; i++) {
//            NSBlockOperation* taskBlock = [NSBlockOperation blockOperationWithBlock:^{
//                NSLog(@"helloworld%d %@",i);
//            }];
//            [queue addOperation:taskBlock];
//            
//        }
        __block dispatch_semaphore_t sem = dispatch_semaphore_create(0);
        dispatch_queue_t queues = dispatch_queue_create("studyBlocks", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(queues, ^{
            ;;
        });
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0), ^{
            
            dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
           NSLog(@"helloworld");
            //dispatch_semaphore_signal(sem);
        });
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0), ^{
            dispatch_semaphore_signal(sem);
           // dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
            NSLog(@"helloworld1");
    
        });
     
        ThreadPoolManage* manager = [ThreadPoolManage shareManage];
        [manager addBlockTaskPriorty:PRIORITY_LOW withBlock:^{
            NSLog(@"is end");
            [manager taskOnMainThread:^{
                NSLog(@"on main");
            }];
        }];
        Task * a = [[Task alloc]init];
        [a run];
        [manager addBlockTaskPriorty:PRIORITY_HIGH withBlock:nil];
    }
    
    
    [[NSRunLoop currentRunLoop]run];
    return 0;
}
