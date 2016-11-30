//
//  TipHistory+CoreDataProperties.m
//  
//
//  Created by dawei che on 2016/11/30.
//
//

#import "TipHistory+CoreDataProperties.h"

@implementation TipHistory (CoreDataProperties)

+ (NSFetchRequest<TipHistory *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"TipHistory"];
}

@dynamic searchKey;

@end
