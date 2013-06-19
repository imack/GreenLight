//
//  GreenLightService.h
//  GreenLight
//
//  Created by Ian MacKinnon on 13-06-11.
//  Copyright (c) 2013 Ian MacKinnon. All rights reserved.
//
#define kCOREUUID @"E1021EED-AFB5-4976-9A86-251B85FFE497"

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@protocol GreenLightServiceDelegate
-(void) update:(NSString*)update;
@end

@interface GreenLightService : NSObject<CBPeripheralManagerDelegate, CBPeripheralDelegate, CBCentralManagerDelegate>
{
    CBPeripheralManager *manager;
    CBMutableService *greenLightService;
    CBMutableCharacteristic *greenLightCharacteristic;
    CBCentralManager *cbm;
    __weak id<GreenLightServiceDelegate> delegate;
    CBPeripheral *_peripheral;
}

@property(nonatomic, weak) id<GreenLightServiceDelegate> delegate; 
@property(nonatomic, strong) CBPeripheral *peripheral;

@property(nonatomic, strong) CBPeripheralManager *manager;
@property(nonatomic, strong) CBCentralManager *cbm;

@end
