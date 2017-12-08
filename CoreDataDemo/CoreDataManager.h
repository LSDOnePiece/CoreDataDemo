//
//  CoreDataManager.h
//  CoreDataDemo
//
//  Created by 神州锐达 on 2017/12/1.
//  Copyright © 2017年 onePiece. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<CoreData/CoreData.h>
#import "UserModel+CoreDataModel.h"
///表名
#define TableName @"Student"

@interface CoreDataManager : NSObject


@property(strong,nonatomic)NSManagedObjectModel *managedObjectModel;

@property(strong,nonatomic)NSManagedObjectContext  *managedObjectContext;

@property(strong,nonatomic)NSPersistentStoreCoordinator *persistentStoreCoordinator;

///保存数据
- (BOOL)save;

///查询数据
-(NSArray *)fetchDataWithPredicate:(NSPredicate *)predicate;


///删除数据
-(BOOL)deleteDataWithPredicate:(NSPredicate *)predicate;

///更新数据
-(BOOL)updateDataWithPredicate:(NSPredicate *)predicate Data:(Student *)data;

///批量更新 NSBatchUpdateRequest  iOS 8 特性
-(BOOL)updateDataWithPredicate:(NSPredicate *)predicate propertiesToUpdate:(NSDictionary *)properties;

///批量删除 NSBatchDeleteRequest  iOS 9 特性
-(BOOL)DeleteDataWithPredicate:(NSPredicate *)predicate;



@end
