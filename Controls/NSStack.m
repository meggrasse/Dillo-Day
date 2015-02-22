//
//  NSStack.m
//  NSStack
//
//  Created by Raj Wilhoit on 7/3/13.
//  Copyright (c) 2013 UF.rajwilhoit. All rights reserved.
//

#import "NSStack.h"

@implementation NSStack

@synthesize stack;

- (int)size
{
    return [stack count];
}

- (void)printStack
{
    if([stack count] == 0)
    {
        NSLog(@"Stack is empty; cannot print");
    }
    else
    {
        for(int i=0;i<[stack count];i++)
        {
            NSLog(@"Printing object at index %d", [stack count] - 1 - i);
            NSLog(@"Stack object: %@",[stack objectAtIndex:([stack count]- 1 - i)]);
        }
    }
}

- (void)push:(id)object
{
    // Allocate memory for the array if the stack is empty
    if([stack count] == 0)
    {
        stack = [[NSMutableArray alloc] init];
    }
    
    [stack addObject:object];
}

- (void)clearStack
{
    [stack removeAllObjects];
}

- (id)pop
{
    id poppedObject = [stack objectAtIndex:([stack count]-1)];
    [stack removeLastObject];
    
    return poppedObject;
}

- (BOOL)isEmpty
{
    if([stack count] == 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


@end
