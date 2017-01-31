//
//  MasterViewController.h
//  TestAppAgilie
//
//  Created by Nikita Ilyukhin on 31.01.17.
//  Copyright © 2017 Nikita Ilyukhin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "TestAppAgilie+CoreDataModel.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController<Event *> *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end

