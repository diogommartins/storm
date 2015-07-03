//
//  ViewController.h
//  storm
//
//  Created by Diogo Magalhães Martins on 7/1/15.
//  Copyright (c) 2015 Diogo Magalhães Martins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray * pacotes;

- (void)updateAvaiablePacotes;

@end

