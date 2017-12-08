//
//  CoreDataManager.m
//  CoreDataDemo
//
//  Created by 神州锐达 on 2017/12/1.
//  Copyright © 2017年 onePiece. All rights reserved.
//

#import "CoreDataManager.h"
#import "UserModel+CoreDataModel.h"

@interface CoreDataManager()



@end

@implementation CoreDataManager

- (BOOL)save
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            return NO;
        }else{
            return YES;
        }
    }else{
        return NO;
    }
}

-(NSArray *)fetchDataWithPredicate:(NSPredicate *)predicate{
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:TableName inManagedObjectContext:self.managedObjectContext];
    
    [request setEntity:entity];
    
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if (array == nil) {
        array = [NSArray array];
    }
    
    return array;
}


-(BOOL)deleteDataWithPredicate:(NSPredicate *)predicate{
    
    NSArray *array =  [self fetchDataWithPredicate:predicate];

    for (Student *obj in array) {
        [self.managedObjectContext deleteObject:obj];
    }
   
    if ([self save]) {
        return YES;
    }else{
        return NO;
    };
    
}

-(BOOL)updateDataWithPredicate:(NSPredicate *)predicate Data:(Student *)data{
    
    NSArray *array =  [self fetchDataWithPredicate:predicate];
    
    for (Student *obj in array) {
        obj.studentName  = data.studentName;
        obj.studentId = data.studentId;
        obj.studentAge = data.studentAge;
    }
    
    if ([self save]) {
        return YES;
    }else{
        return NO;
    };
    
}

#pragma mark --批量更新
-(BOOL)updateDataWithPredicate:(NSPredicate *)predicate propertiesToUpdate:(NSDictionary *)propertiesToUpdate{
    
    // 根据 entityName 创建
    NSBatchUpdateRequest *updateRequest = [[NSBatchUpdateRequest alloc] initWithEntityName:TableName];
    
    updateRequest.predicate = predicate;
    
    updateRequest.resultType = NSStatusOnlyResultType;
    
    updateRequest.propertiesToUpdate = propertiesToUpdate;
    
    NSError *error = nil;
    [self.managedObjectContext executeRequest:updateRequest error:&error];
    
    if (error) {
        return NO;
    }else{
        return YES;
    }
    
}

#pragma mark --批量删除
-(BOOL)DeleteDataWithPredicate:(NSPredicate *)predicate{

    NSFetchRequest *deleteFetch = [Student fetchRequest];
    
    deleteFetch.predicate = predicate;
    
    NSBatchDeleteRequest *deleteRequest = [[NSBatchDeleteRequest alloc] initWithFetchRequest:deleteFetch];
    deleteRequest.resultType = NSBatchDeleteResultTypeObjectIDs;
    
    NSError *error = nil;
    NSBatchDeleteResult *deleteResult = [self.managedObjectContext executeRequest:deleteRequest error:&error];
    
    if (error) {
        return NO;
    }else{
        
        NSArray<NSManagedObjectID *> *deletedObjectIDs = deleteResult.result;
        
        NSDictionary *deletedDict = @{NSDeletedObjectsKey : deletedObjectIDs};
        
        [NSManagedObjectContext mergeChangesFromRemoteContextSave:deletedDict intoContexts:@[self.managedObjectContext]];
        return YES;
    }
    
}


#pragma mark - Core Data stack
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    // url 为UserModel.xcdatamodeld，注意扩展名为 momd，而不是 xcdatamodeld 类型
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"UserModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}


- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self documentDirectoryURL] URLByAppendingPathComponent:@"UserModel.sqlite"];
    
    NSLog(@"storeURL === %@",storeURL);
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// 用来获取 document 目录
- (nullable NSURL *)documentDirectoryURL {
    return [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
}


@end
