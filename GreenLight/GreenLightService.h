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

@interface GreenLightService : NSObject<CBPeripheralManagerDelegate, CBPeripheralDelegate, CBCentralManagerDelegate>
{
    CBPeripheralManager *manager;
    CBMutableService *greenLightService;
    CBMutableCharacteristic *greenLightCharacteristic;
    CBCentralManager *cbm;
}

@end
