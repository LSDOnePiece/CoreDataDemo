//
//  CoreDataManager.h
//  CoreDataDemo
//
//  Created by 神州锐达 on 2017/12/1.
//  Copyright © 2017年 onePiece. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<CoreData/CoreData.h>

///表名
#define TableName @"Student"

@interface CoreDataManager : NSObject


@property(strong,nonatomic)NSManagedObjectModel *managedObjectModel;

@property(strong,nonatomic)NSManagedObjectContext  *managedObjectContext;

@property(strong,nonatomic)NSPersistentStoreCoordinator *persistentStoreCoordinator;

///保存数据
- (void)save;

@end
