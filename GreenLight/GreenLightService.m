//
//  GreenLightService.m
//  GreenLight
//
//  Created by Ian MacKinnon on 13-06-11.
//  Copyright (c) 2013 Ian MacKinnon. All rights reserved.
//

#import "GreenLightService.h"


@interface GreenLightService ()
- (void) setupService;
@end


@implementation GreenLightService



-(id) init{
    self = [super init];
    
    if (self){
        manager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
        cbm = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    return self;
}

-(void) peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral{
    switch (peripheral.state){
        case CBPeripheralManagerStatePoweredOn:
            [self setupService];
            break;
        default:
            NSLog(@"CBPeripheralManager changed State");
            break;
    }
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    //self.cBReady = false;
    switch (central.state) {
        case CBCentralManagerStatePoweredOff:
            NSLog(@"CoreBluetooth BLE hardware is powered off");
            break;
        case CBCentralManagerStatePoweredOn:
            NSLog(@"CoreBluetooth BLE hardware is powered on and ready");
            //self.cBReady = true;
            [cbm scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
            break;
        case CBCentralManagerStateResetting:
            NSLog(@"CoreBluetooth BLE hardware is resetting");
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@"CoreBluetooth BLE state is unauthorized");
            break;
        case CBCentralManagerStateUnknown:
            NSLog(@"CoreBluetooth BLE state is unknown");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@"CoreBluetooth BLE hardware is unsupported on this platform");
            break;
        default:
            break;
    }
}


-(void) setupService{
    NSString *kCharacteristicPipeUUIDString = kCOREUUID;
    
    NSString *kGreenLightServiceUUIDString = kCOREUUID;
    
    CBUUID *cbuuidService = [CBUUID UUIDWithString:kGreenLightServiceUUIDString];
    
    CBUUID *cbuuidPipe = [CBUUID UUIDWithString:kCharacteristicPipeUUIDString];
    
    
    greenLightCharacteristic = [[CBMutableCharacteristic alloc]
                                 initWithType:cbuuidPipe
                                 properties:CBCharacteristicPropertyNotify
                                 value:nil
                                 permissions:CBAttributePermissionsReadable];
    
    greenLightService = [[CBMutableService alloc] initWithType:cbuuidService primary:YES];
    
    
    greenLightService.characteristics = [NSArray arrayWithObject:greenLightCharacteristic];
    
    [manager addService:greenLightService];
    
    
    
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error {
    if (error == nil) {
        [self advertise];
    }
}

-(void) advertise{    
    NSString *kGreenLightServiceUUIDString = kCOREUUID;
    
    CBUUID *cbuuidService = [CBUUID UUIDWithString:kGreenLightServiceUUIDString];
    
    NSArray *services = [NSArray arrayWithObject:cbuuidService];
    
    NSDictionary *advertisingDict = [NSDictionary dictionaryWithObject:services forKey:CBAdvertisementDataServiceUUIDsKey ];
    
    [manager startAdvertising:advertisingDict];
    [manager startAdvertising:@{ CBAdvertisementDataLocalNameKey : @"ICServer", CBAdvertisementDataServiceUUIDsKey : @[[CBUUID UUIDWithString:kCOREUUID]] }];
    
}


- (void) centralManager:(CBCentralManager *)central
  didDiscoverPeripheral:(CBPeripheral *)peripheral
      advertisementData:(NSDictionary *)advertisementData
                   RSSI:(NSNumber *)RSSI
{
    // Print out the name parameter of the discovered peripheral
    NSLog (@"Discovered peripheral: %@ with RSSI: %@", [peripheral name], RSSI);
}

-(void) peripheralManager:(CBPeripheralManager *)peripheral
                    central:(CBCentral *)central
                    didSubscribeToCharacteristic:(CBCharacteristic *)characteristic{
    
    //NSData *nextChunk = [self getNextChunk];

    //while (nextChunk){
    //    [manager updateValue:nextChunk
     //      forCharacteristic:greenLightCharacteristic onSubscribedCentrals:nil];
        
     //   nextChunk = [self getNextChunk];
    //}
    NSUUID *myUUID = [[UIDevice alloc] identifierForVendor];
    [manager updateValue:[[myUUID UUIDString] dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:greenLightCharacteristic onSubscribedCentrals:nil];
     
    NSData *eom = [@"ENDVAL" dataUsingEncoding:NSUTF8StringEncoding];
    
    [manager updateValue:eom forCharacteristic:greenLightCharacteristic onSubscribedCentrals:nil];
    
}


@end
