//
//  SearchGifsViewController.m
//  TestAppAgilie
//
//  Created by Nikita Ilyukhin on 01.02.17.
//  Copyright © 2017 Nikita Ilyukhin. All rights reserved.
//

#import "SearchGifsViewController.h"

#import "GifItem.h"
#import "MBProgressHUD.h"
#import "GIphyAPIManager.h"
#import "GifCollectionViewCell.h"
#import "Defines.h"
#import "NSDictionary+Validate.h"
#import "GiphyParser.h"


@interface SearchGifsViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBarGifs;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewGifs;

@property(assign,nonatomic) NSUInteger limit;
@property(assign, nonatomic) NSInteger offset;
@property(strong,nonatomic) NSMutableArray* gifs;
@property(assign,nonatomic) BOOL isLoading;

@end

@implementation SearchGifsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBarGifs.delegate = self;
    self.gifs = [NSMutableArray array];
    self.collectionViewGifs.alwaysBounceVertical = YES;
    
}

-(void)searchGifs
{
    NSDictionary* params = @{@"limit": PAGE_LIMIT,
                             @"offset": OFFSET,
                             @"q": self.searchBarGifs.text};
    
    [GIphyAPIManager searchGifWithParams:params complete:^(id responseObject, NSError *error) {
        if (error)
            [self showError:[NSString stringWithFormat:@"ERROR: %@", error.localizedDescription]];
        else
        {
            if ([responseObject objectForKey:@"pagination"])
            {
                NSDictionary* paginationDict = [responseObject objectForKey:@"pagination"];
                
                if ([paginationDict objectForKey:@"offset"])
                    self.offset =[paginationDict integerForKey:@"offset"];
            }
            
            if ([responseObject objectForKey:@"data"]&&[[responseObject objectForKey:@"data"]count]>0)
            {
                [self.gifs addObjectsFromArray:[GiphyParser getArrayGifItems:responseObject]];
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                _isLoading = NO;
                [self.collectionViewGifs reloadData];
            }
            else
                [self showError:[NSString stringWithFormat:@"Gif with that name is not found"]
                 ];
        }
    }];
}

-(void) showError:(NSString*) errorDescription{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:errorDescription preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSLog(@"OK");
    }];
    
    [alertController addAction:okAction];
    [self presentViewController:alertController animated: YES completion: nil];
}

#pragma mark - UICollectionView Protocol

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.gifs count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GifCollectionViewCell *cell = [self.collectionViewGifs dequeueReusableCellWithReuseIdentifier:@"GifCell" forIndexPath:indexPath];
    GifItem* gifItem = [self.gifs objectAtIndex:indexPath.row];
    [cell fillWhithGif:gifItem];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellWidth =  [[UIScreen mainScreen] bounds].size.width/NUMBER_CELLS_IN_ROW-7;
    return CGSizeMake(cellWidth, cellWidth);
}

-(void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    GifCollectionViewCell *selectedCell =
    (GifCollectionViewCell *)[self.collectionViewGifs cellForItemAtIndexPath:indexPath];
    GifItem *gifItem =  selectedCell.gifItem;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"GIF info" message:[NSString stringWithFormat:  @"Username: %@; Title:%@; DateCreate:%@;", gifItem.author, gifItem.title, gifItem.dateCreate]preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        //action when pressed button
    }];
    
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"Share" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        NSURL *imagePath = [NSURL URLWithString:gifItem.url];
        NSData *animatedGif = [NSData dataWithContentsOfURL:imagePath];
        NSArray *sharingItems = [NSArray arrayWithObjects: animatedGif, nil];
        
        UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
        
        if ( [activityController respondsToSelector:@selector(popoverPresentationController)] )
        {

            
            
            
            
            activityController.popoverPresentationController.sourceView = selectedCell;
            activityController.popoverPresentationController.sourceRect = selectedCell.bounds;
        }
        
        [self presentViewController:activityController animated:YES completion:nil];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    if ( [alertController respondsToSelector:@selector(popoverPresentationController)] )
    {
        alertController.popoverPresentationController.sourceView = selectedCell;
        alertController.popoverPresentationController.sourceRect = selectedCell.bounds;
    }
    
    [self presentViewController:alertController animated: YES completion: nil];
}

#pragma mark - ScrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGFloat contentHeight = scrollView.contentSize.height;
    
    if (offsetY > contentHeight - scrollView.frame.size.height)
    {
        if (!_isLoading)
        {
            _isLoading = YES;
            [self searchGifs];
        }
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
    
    [self.gifs removeAllObjects];
    
    [self.collectionViewGifs reloadData];

    [self searchGifs];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
