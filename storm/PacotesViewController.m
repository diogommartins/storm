//
//  ViewController.m
//  storm
//
//  Created by Diogo Magalhães Martins on 7/1/15.
//  Copyright (c) 2015 Diogo Magalhães Martins. All rights reserved.
//

#import "PacotesViewController.h"
#import "MPSkewedCell.h"
#import "MPSkewedParallaxLayout.h"
#import "VBPacote.h"
#import "PacoteDetailViewController.h"

#define kPACOTE_CELL_IDENTIFIER @"pacoteCell"


@interface PacotesViewController () 

@end

@implementation PacotesViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.pacotes = [NSMutableArray new];
    self.api = [VBAPIManager new];
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
    [self.api.manager GET: @"http://private-30403b-storm4.apiary-mock.com/pacotes"
               parameters: nil
                  success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                      for (NSDictionary * pacote in responseObject){
                          [self.pacotes addObject: [[VBPacote alloc] initWithContentsOfAPIResponse: pacote]];
                      }
                      [self.collectionView reloadData];
                      
                  }
                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                      NSLog(@"Disparar alerta para usuário e adicionar esta requisição novamente a fila após X segundos");
                  }];
}

-(void)updateCellsBackgroundImage{
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [(MPSkewedParallaxLayout *)self.collectionView.collectionViewLayout setItemSize:CGSizeMake(CGRectGetWidth(self.view.bounds), 250)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString: @"showPacoteDetail"]){
        PacoteDetailViewController * vc = [segue destinationViewController];
        NSIndexPath * indexPath = sender;
        [vc setPacote: [self.pacotes objectAtIndex: indexPath.row]];
    }
}

#pragma mark - UICollectionViewDatasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.pacotes count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MPSkewedCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier: kPACOTE_CELL_IDENTIFIER
                                                                   forIndexPath: indexPath];
    
    VBPacote * pacote = [self.pacotes objectAtIndex: indexPath.row];
    [self.api getImageWithURL: pacote.imagemURL
                      success: ^(AFHTTPRequestOperation *operation, UIImage *image) {
                          cell.image = image;
                          
                      }
                      failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                          NSLog(@"Adicionar uma imagem de placeholder?");
                      }];
    
    cell.text = [pacote destino];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier: @"showPacoteDetail" sender: indexPath];
}

@end
