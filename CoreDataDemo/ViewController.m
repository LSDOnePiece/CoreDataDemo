//
//  ViewController.m
//  CoreDataDemo
//
//  Created by 神州锐达 on 2017/12/1.
//  Copyright © 2017年 onePiece. All rights reserved.
//

#import "ViewController.h"
#import "CoreDataManager.h"
#import "UserModel+CoreDataModel.h"
@interface ViewController ()

@property(strong,nonatomic)CoreDataManager *dataManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Student *stu1 = [NSEntityDescription insertNewObjectForEntityForName:TableName inManagedObjectContext:self.dataManager.managedObjectContext];
    
    stu1.studentName = @"xiaoming1";
    stu1.studentAge = 10;
    stu1.studentId = 1;
    
    [self.dataManager save];

    Student *stu2 = [NSEntityDescription insertNewObjectForEntityForName:TableName inManagedObjectContext:self.dataManager.managedObjectContext];
    
    stu2.studentName = @"xiaoming2";
    stu2.studentAge = 20;
    stu2.studentId = 2;
    [self.dataManager save];
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
