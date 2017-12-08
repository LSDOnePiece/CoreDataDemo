//
//  ViewController.m
//  CoreDataDemo
//
//  Created by 神州锐达 on 2017/12/1.
//  Copyright © 2017年 onePiece. All rights reserved.
//

#import "ViewController.h"
#import "CoreDataManager.h"

@interface ViewController ()

@property(strong,nonatomic)CoreDataManager *dataManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Student *stu1 = [NSEntityDescription insertNewObjectForEntityForName:TableName inManagedObjectContext:self.dataManager.managedObjectContext];
    stu1.studentName = @"iOS";
    stu1.studentAge = 28;
    stu1.studentId = 1;
    
    [self.dataManager save];
    
    Student *stu2 = [NSEntityDescription insertNewObjectForEntityForName:TableName inManagedObjectContext:self.dataManager.managedObjectContext];
    stu2.studentName = @"Android";
    stu2.studentAge = 30;
    stu2.studentId = 2;
    
    [self.dataManager save];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"studentName CONTAINS[cd] 'O'"];
    
    NSArray *array =  [self.dataManager fetchDataWithPredicate:predicate];

    
    [array enumerateObjectsUsingBlock:^(Student *obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSLog(@"%@",obj.studentName);
    }];
    
    
     NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"studentName CONTAINS[cd] 'O'"];

    [self.dataManager updateDataWithPredicate:predicate1 propertiesToUpdate:@{@"studentName":@"hehe"}];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CoreDataManager *)dataManager{
    if (_dataManager == nil) {
        _dataManager = [[CoreDataManager alloc]init];
    }
    return _dataManager;
}


@end
