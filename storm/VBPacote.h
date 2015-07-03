//
//  VBPacote.h
//  storm
//
//  Created by Diogo Magalhães Martins on 7/3/15.
//  Copyright (c) 2015 Diogo Magalhães Martins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VBPacote : NSObject

@property int uid;
@property (strong, nonatomic) NSString * destino;
@property (strong, nonatomic) NSNumber * preco;
@property (strong, nonatomic) NSURL * imagemURL;
@property (strong, nonatomic) NSString * resourceURL;
@property (strong, nonatomic) NSString * descricao;


@end