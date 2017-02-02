//
//  SearchGifsViewController.m
//  TestAppAgilie
//
//  Created by Nikita Ilyukhin on 01.02.17.
//  Copyright © 2017 Nikita Ilyukhin. All rights reserved.
//

#import "SearchGifsViewController.h"

#import "GifItem.h"
#import "GifModels.h"
#import "MBProgressHUD.h"
#import "GIphyAPIManager.h"
#import "GifCollectionViewCell.h"

static NSString * const reuseIdentifier = @"gifCell";

@interface SearchGifsViewController () <GifModelsDelegate, UICollectionViewDataSource, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBarGifs;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewGifs;

@property(strong,nonatomic) GifModels* gifModels;

@property(strong,nonatomic) NSMutableArray* gifs;

@property(assign,nonatomic) BOOL isLoading;

@end

@implementation SearchGifsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBarGifs.delegate = self;
    
    self.gifs = [NSMutableArray array];
    
    self.gifModels = [[GifModels alloc]init];
    
    self.gifModels.delegate = self;
    
    self.collectionViewGifs.alwaysBounceVertical = YES;
    
}

#pragma mark - GifModelsDelegate

-(void) searchGifForTermResponds:(NSMutableArray*) gifArray{
    
    [self.gifs addObjectsFromArray:gifArray];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    _isLoading = NO;
    
    [self.collectionViewGifs reloadData];
    
}

-(void) errorResponds:(NSString*) errorDescription{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:errorDescription preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSLog(@"OK");
    }];

    [alertController addAction:okAction];
    [self presentViewController:alertController animated: YES completion: nil];
}

#pragma mark - UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.gifs count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GifCollectionViewCell *cell = [self.collectionViewGifs dequeueReusableCellWithReuseIdentifier:@"GifCell" forIndexPath:indexPath];
    
    
    
    GifItem* gifItem = [self.gifs objectAtIndex:indexPath.row];
    
    [cell fillWhithGif:gifItem];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int numberOfCellInRow = 3;
    CGFloat cellWidth =  [[UIScreen mainScreen] bounds].size.width/numberOfCellInRow-7;
    return CGSizeMake(cellWidth, cellWidth);
}


#pragma mark - ScrollView


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGFloat contentHeight = scrollView.contentSize.height;
    
    if (offsetY > contentHeight - scrollView.frame.size.height)
    {
        if (!_isLoading) {
            
            _isLoading = YES;
            
            [self.gifModels searchGifForTerm:self.searchBarGifs.text limit:self.gifModels.limit offset:(self.gifModels.offset+self.gifModels.limit)];
            
        }
    }
}


#pragma mark - UISearchBarDelegate


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
    
    [self.gifs removeAllObjects];
    
    [self.collectionViewGifs reloadData];
    
    self.gifModels.offset = 0;
    
    [self.gifModels searchGifForTerm:searchBar.text limit:self.gifModels.limit offset:self.gifModels.offset];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
}


-(void)collectionView:(UICollectionView *)collectionView
didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
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
        
        NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                       UIActivityTypePrint,
                                       UIActivityTypeAssignToContact,
                                       UIActivityTypeSaveToCameraRoll,
                                       UIActivityTypeAddToReadingList,
                                       UIActivityTypePostToFlickr,
                                       UIActivityTypePostToVimeo];
        
        activityController.excludedActivityTypes = excludeActivities;
        
        [self presentViewController:activityController animated:YES completion:nil];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated: YES completion: nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
