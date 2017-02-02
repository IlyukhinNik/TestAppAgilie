//
//  GifCollectionViewCell.h
//  TestAppAgilie
//
//  Created by Nikita Ilyukhin on 02.02.17.
//  Copyright © 2017 Nikita Ilyukhin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GifItem.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <FLAnimatedImage.h>

@interface GifCollectionViewCell : UICollectionViewCell

@property(strong,nonatomic)GifItem* gifItem;
@property (weak, nonatomic) IBOutlet FLAnimatedImageView *imageViewGif;

-(void) fillWhithGif: (GifItem*) gifItem;

@end
