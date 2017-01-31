//
//  DetailViewController.h
//  TestAppAgilie
//
//  Created by Nikita Ilyukhin on 31.01.17.
//  Copyright © 2017 Nikita Ilyukhin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestAppAgilie+CoreDataModel.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Event *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

