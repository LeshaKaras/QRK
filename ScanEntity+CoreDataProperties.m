//
//  ScanEntity+CoreDataProperties.m
//  QRK
//
//  Created by Alexei Karas on 29.06.17.
//  Copyright © 2017 Alexei Karas. All rights reserved.
//

#import "ScanEntity+CoreDataProperties.h"

@implementation ScanEntity (CoreDataProperties)

+ (NSFetchRequest<ScanEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ScanEntity"];
}

@dynamic stringName;
@dynamic dateCriatedObject;

@end
