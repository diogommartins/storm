//
//  ViewController.h
//  storm
//
//  Created by Diogo Magalhães Martins on 7/1/15.
//  Copyright (c) 2015 Diogo Magalhães Martins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VBAPIManager.h"

@interface PacotesViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray * pacotes;
@property (strong, nonatomic) VBAPIManager * api;

- (void)updateAvaiablePacotes;

@end

