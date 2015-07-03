//
//  VBPacote.m
//  storm
//
//  Created by Diogo Magalhães Martins on 7/3/15.
//  Copyright (c) 2015 Diogo Magalhães Martins. All rights reserved.
//

#import "VBPacote.h"

@implementation VBPacote

-(instancetype)initWithContentsOfAPIResponse:(NSDictionary *)response{
    if(self = [super init]){
        self.destino = [response objectForKey: @"destino"];
        self.imagemURL = [NSURL URLWithString: [response objectForKey: @"imagem"]];
        self.preco = [response objectForKey:@"preco"];
        self.resourceURL = [response objectForKey: @"url"];
        
        NSDateFormatter * formatter = [NSDateFormatter new];
        [formatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
        self.published_at = [formatter dateFromString: [response objectForKey:@"published_at"]];
    }
    return self;
}

@end
