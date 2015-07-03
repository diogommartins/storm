//
//  ViewController.m
//  storm
//
//  Created by Diogo Magalhães Martins on 7/1/15.
//  Copyright (c) 2015 Diogo Magalhães Martins. All rights reserved.
//

#import "ViewController.h"
#import "MPSkewedCell.h"
#import "MPSkewedParallaxLayout.h"

#define kPACOTE_CELL_IDENTIFIER @"pacoteCell"


@interface ViewController () 

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateAvaiablePacotes];
    MPSkewedParallaxLayout *layout = [[MPSkewedParallaxLayout alloc] init];
    layout.lineSpacing = 2;
    layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 250);
    
    [self.collectionView setCollectionViewLayout: layout];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass: [MPSkewedCell class]
            forCellWithReuseIdentifier: kPACOTE_CELL_IDENTIFIER];
    [self.view addSubview:self.collectionView];
    
}

-(void)updateAvaiablePacotes{
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [(MPSkewedParallaxLayout *)self.collectionView.collectionViewLayout setItemSize:CGSizeMake(CGRectGetWidth(self.view.bounds), 250)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDatasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.pacotes count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.item % 5 + 1;
    MPSkewedCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier: kPACOTE_CELL_IDENTIFIER
                                                                   forIndexPath: indexPath];
    cell.image = [UIImage imageNamed:[NSString stringWithFormat:@"%zd", index]];
    cell.text = @"teste";
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Perfom segue... %@ %zd", NSStringFromSelector(_cmd), indexPath.item);
}

@end
