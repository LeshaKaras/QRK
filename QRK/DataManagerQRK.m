//
//  DataManagerQRK.m
//  QRK
//
//  Created by Alexei Karas on 21.06.17.
//  Copyright © 2017 Alexei Karas. All rights reserved.
//

#import "DataManagerQRK.h"
#import "ScanEntity+CoreDataProperties.h"


@implementation DataManagerQRK

+(DataManagerQRK*) sharedManager {
    
    static DataManagerQRK* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataManagerQRK alloc] init];
    });
    return manager;
}

-(NSPersistentContainer *)persistentContainer {
    
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"QRK"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

-(NSArray*) dataQRK {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* descriptor = [NSEntityDescription entityForName:@"ScanEntity"
                                                  inManagedObjectContext:self.persistentContainer.viewContext];
    [request setEntity:descriptor];
    
    NSError* error = nil;
    NSArray* array = [self.persistentContainer.viewContext executeFetchRequest:request error:&error];
    
        NSSortDescriptor * name = [NSSortDescriptor sortDescriptorWithKey:@"stringName" ascending:YES];
        NSArray* arraySD = @[name];
        NSArray* sortedArray = [array sortedArrayUsingDescriptors:arraySD];
    
    return sortedArray;
}



-(void) insertNewScanObject: (NSString *) scan scanDate:(NSDate*)time {
    
    ScanEntity* object = [NSEntityDescription insertNewObjectForEntityForName:@"ScanEntity"
                                                inManagedObjectContext:self.persistentContainer.viewContext];
    
    object.stringName = scan;
    object.dateCriatedObject = time;
    
    NSError* error = nil;
    [self.persistentContainer.viewContext save:&error];
   // [self saveContext];
    
}

- (void) loadObjectSelected:(NSString*) stringUrl{
    
    self.objectLoadWebView = stringUrl;
}


@end
