//
//  SharedConstants.h
//  Winterfell
//
//  Created by Ian MacKinnon on 2013-08-11.
//  Copyright (c) 2013 Ian MacKinnon. All rights reserved.
//

#import <Foundation/Foundation.h>



#ifdef DEBUG
#   define SERVER_URL                     @"http://lokaloapp.com"
#   define LOKALO_UUID      @"B9407F30-F5F8-466E-AFF9-25556B57FE6D" //estimote
#else
#   define SERVER_URL                     @"http://lokaloapp.com"
#   define LOKALO_UUID      @"486874B4-25A1-4DAF-A18E-81220C96905E"
#endif
