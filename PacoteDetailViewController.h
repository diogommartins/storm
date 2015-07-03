//
//  PacoteDetailViewController.h
//  storm
//
//  Created by Diogo Magalhães Martins on 7/3/15.
//  Copyright (c) 2015 Diogo Magalhães Martins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VBPacote.h"
#import "VBAPIManager.h"

@interface PacoteDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (strong, nonatomic) VBPacote * pacote;
@property (strong, nonatomic) VBAPIManager * api;

@property (weak, nonatomic) IBOutlet UILabel *lblPreco;
@property (weak, nonatomic) IBOutlet UILabel *lblDestino;
@property (weak, nonatomic) IBOutlet UITextView *lblDescricao;
@property (weak, nonatomic) IBOutlet UIImageView *lblImagemDestino;

@end
