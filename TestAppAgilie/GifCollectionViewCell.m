//
//  GifCollectionViewCell.m
//  TestAppAgilie
//
//  Created by Nikita Ilyukhin on 02.02.17.
//  Copyright © 2017 Nikita Ilyukhin. All rights reserved.
//

#import "GifCollectionViewCell.h"

@implementation GifCollectionViewCell

-(void) fillWhithGif: (GifItem*) gifItem{
    
    self.gifItem = gifItem;
    
    [self.imageViewGif setShowActivityIndicatorView:YES];
    [self.imageViewGif setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    [self.imageViewGif sd_setImageWithURL:[NSURL URLWithString:gifItem.url]];

}

@end
