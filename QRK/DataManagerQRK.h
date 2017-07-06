//
//  DataManagerQRK.h
//  QRK
//
//  Created by Alexei Karas on 21.06.17.
//  Copyright © 2017 Alexei Karas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ScanEntity+CoreDataClass.h"


@interface DataManagerQRK : NSObject

@property (strong, nonatomic) NSPersistentContainer* persistentContainer;
@property (strong, nonatomic) NSString* objectLoadWebView;

+(DataManagerQRK*) sharedManager;
-(void)saveContext;

-(NSArray*) dataQRK;
-(void) insertNewScanObject: (NSString *) scan scanDate:(NSDate*)time;

- (void) loadObjectSelected:(NSString*) stringUrl;
- (void) deleteObject:(ScanEntity*) object;

@end
