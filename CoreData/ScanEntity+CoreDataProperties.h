//
//  ScanEntity+CoreDataProperties.h
//  QRK
//
//  Created by Alexei Karas on 29.06.17.
//  Copyright © 2017 Alexei Karas. All rights reserved.
//

#import "ScanEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ScanEntity (CoreDataProperties)

+ (NSFetchRequest<ScanEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *stringName;
@property (nullable, nonatomic, copy) NSDate *dateCriatedObject;

@end

NS_ASSUME_NONNULL_END
