//
//  TipHistory+CoreDataProperties.h
//  
//
//  Created by dawei che on 2016/11/30.
//
//

#import "TipHistory+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TipHistory (CoreDataProperties)

+ (NSFetchRequest<TipHistory *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *searchKey;

@end

NS_ASSUME_NONNULL_END
