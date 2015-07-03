//
//  PacoteDetailViewController.m
//  storm
//
//  Created by Diogo Magalhães Martins on 7/3/15.
//  Copyright (c) 2015 Diogo Magalhães Martins. All rights reserved.
//

#import "PacoteDetailViewController.h"

@interface PacoteDetailViewController ()

-(void)loadBackgroundImageView;
-(void)loadPacoteDescricao: (VBPacote *)pacote placeholderView:(UITextView *)textView;

@end

@implementation PacoteDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.api = [VBAPIManager new];
    [self.navigationItem setTitle: self.pacote.destino];
    [self.lblDestino setText: self.pacote.destino];
    [self.lblPreco setText: [NSString stringWithFormat:@"R$%@", self.pacote.preco]];
    [self loadPacoteDescricao: self.pacote placeholderView: self.lblDescricao];
    [self loadBackgroundImageView];
}

-(void)loadPacoteDescricao:(VBPacote *)pacote placeholderView:(UITextView *)textView{
    if (!self.pacote.descricao){
        [self.api.manager GET: [self.api URLForPath: self.pacote.resourceURL]
                   parameters: nil
                      success: ^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
                          [self.pacote setDescricao: [responseObject objectForKey: @"descricao"]];
                          [self.lblDescricao setText: self.pacote.descricao];
                      }
                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                          NSLog(@"Disparar alerta para usuário e adicionar esta requisição novamente a fila após X segundos");
                      }];
    }
    else{
        [self.lblDescricao setText: self.pacote.descricao];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadBackgroundImageView{
    [self.api getImageWithURL: self.pacote.imagemURL
                      success: ^(AFHTTPRequestOperation *operation, UIImage *image) {
                          [self.lblImagemDestino setImage: image];
                          
                          UIImageView * backgroundView = [[UIImageView alloc] initWithImage: image];
                          [backgroundView setContentMode: UIViewContentModeScaleAspectFill];
                          [backgroundView setFrame: self.view.frame];
                          [backgroundView setClipsToBounds: YES];
                          
                          UIVisualEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
                          UIVisualEffectView *bluredBackgroundview = [[UIVisualEffectView alloc] initWithEffect: blur];
                          bluredBackgroundview.frame = backgroundView.bounds;
                          [backgroundView addSubview: bluredBackgroundview];
                          
                          [self.backgroundView insertSubview: backgroundView atIndex:0];
                      }
                      failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                          NSLog(@"Adicionar alguma imagem default ");
                      }];
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
