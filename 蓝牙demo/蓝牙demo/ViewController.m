//
//  ViewController.m
//  蓝牙demo
//
//  Created by 3D on 17/2/13.
//  Copyright © 2017年 3D. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>




@interface ViewController ()
<
CBCentralManagerDelegate, //中心代理
CBPeripheralDelegate
>
@property(nonatomic,strong) UISwitch *fengMing;
@property(nonatomic,strong) UISwitch *shanshuo;
@property(nonatomic,strong) UILabel *bushuLB;
@property(nonatomic,strong) CBCentralManager *centralManager;
@property(nonatomic,strong) CBPeripheral *periPheral;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.centralManager = [[CBCentralManager alloc]initWithDelegate:self queue:nil options:nil];
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    self.bushuLB = [[UILabel alloc]initWithFrame:CGRectMake(width/2-100, 50, 200, 50)];
    self.bushuLB.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_bushuLB];
    
    self.fengMing = [[UISwitch alloc]initWithFrame:CGRectMake(50, 200, 0, 0)];
    [self.view addSubview:_fengMing];
    UILabel *fmLB = [[UILabel alloc]initWithFrame:CGRectMake(50, 250, self.fengMing.frame.size.width, 30)];
    fmLB.text = @"蜂鸣";
    fmLB.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:fmLB];
    
    self.shanshuo = [[UISwitch alloc]initWithFrame:CGRectMake(width-50-self.fengMing.frame.size.width, 200, 0, 0)];
    [self.view addSubview:_shanshuo];
    UILabel *ssLB = [[UILabel alloc]initWithFrame:CGRectMake(width-50-self.fengMing.frame.size.width, 250, self.fengMing.frame.size.width, 30)];
    ssLB.text = @"闪烁";
    ssLB.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:ssLB];

}

-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case CBCentralManagerStateUnknown:
            NSLog(@"CBCentralManagerStateUnknown");
            break;
        case CBCentralManagerStateResetting:
            NSLog(@">>>CBCentralManagerStateResetting");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@">>>CBCentralManagerStateUnsupported");
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@">>>CBCentralManagerStateUnauthorized");
            break;
        case CBCentralManagerStatePoweredOff:
            NSLog(@">>>CBCentralManagerStatePoweredOff");
            break;
        case CBCentralManagerStatePoweredOn:
            NSLog(@">>>CBCentralManagerStatePoweredOn");
            //只有蓝牙打开的状态才呢个开始
            [central scanForPeripheralsWithServices:nil options:nil];
            break;
        default:
            break;
    }
}

//扫描到设备
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{
    //在这里筛选 我们要链接的 设备;
    if ([peripheral.name hasPrefix:@"Sensor"]) {
        //找到设备 我们得持有这个设备
        self.periPheral = peripheral;
        //链接外设
        [central connectPeripheral:peripheral options:nil];
        
    }
}


//链接外设失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{

}

//断开链接
-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{

}

//链接外设成功
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    //链接成功之后 设置外设的代理
    [peripheral setDelegate:self];
    //发现服务
    [peripheral discoverServices:nil];
}

//找到服务 Discover
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    for (CBService *service in peripheral.services) {
        //找特征
        [peripheral discoverCharacteristics:nil forService:service];
    }
}
//外设用服务找到 服务特征
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    for (CBCharacteristic *characteristic in service.characteristics){
        if([characteristic.UUID.UUIDString isEqualToString:@"FFF6"]){
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            
            NSDateComponents *comps = [self getTime];
            
            Byte bytes[20];
            bytes[0] = CMD_HEAD_END;
            bytes[1] = 18;
            bytes[2] = CMD_SYS_PARAM;
            bytes[3] = CMD_STEP_PARAM_1;
            bytes[4] = CMD_STEP_PARAM_2;
            bytes[5] = CMD_STEP_PARAM_3;
            bytes[6] = CMD_STEP_PARAM_4;
            bytes[7] = [comps year] % 100;
            bytes[8] = [comps month];
            bytes[9] = [comps day];
            bytes[10] = [comps hour];
            bytes[11] = [comps minute];
            bytes[12] = [comps second];
            bytes[13] = 00;
            bytes[14] = 00;
            bytes[15] = 00;
            bytes[16] = 100;
            bytes[17] = CMD_HEAD_END;
            
            NSData *data = [NSData dataWithBytes:bytes length:sizeof(bytes)];
            [peripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
//            [peripheral readValueForCharacteristic:characteristic];
        }
    }
}

-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    NSLog(@"@@@@ :%@ :%@ :%@",characteristic.UUID,characteristic.UUID.UUIDString,characteristic.value);
    if([characteristic.UUID.UUIDString isEqualToString:@"FFF6"]) {
        Byte *resultBytes = (Byte *)[characteristic.value bytes];
        for (int i = 0; i<characteristic.value.length; i++) {
            NSLog(@"controlByte  =  %x",resultBytes[i]);
        }
        if (resultBytes[2] == 0x01) {
            
        }
        
        
        Byte controlByte = resultBytes[2];
        
        switch (controlByte) {
            case RESP_SYS_PARAM:
            {
               
                return;
            }
            case RESP_STEP_COUNT:
            {
                
                return;
            }
            case RESP_BATTERY_POWER:
            {
                
                return;
            }
            case RESP_SYNC_DATA:
            {
                
                return;
            }
            case RESP_SYNC_SUBPACKAGE:
            {
                
                
                return;
            }
            case RESP_RESET_FACTORY:
            {
                
                return;
            }
                
                
            default:
                break;
        }

        
        
    }
}

//停止扫描
-(void)stopScan{
    [self.centralManager stopScan];
}

//断开链接
- (void)cancelPeripheralConnection:(CBPeripheral *)peripheral{
    [self.centralManager cancelPeripheralConnection:peripheral];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSDateComponents *)getTime
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:[NSDate date]];
    
    NSLog(@"time:%ld, %ld, %ld, %ld, %ld, %ld", [comps year] % 100, [comps month], [comps day], [comps hour], [comps minute], [comps second]);
    
    return comps;
    
}


@end
