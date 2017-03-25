//
//  ViewController.m
//  蓝牙
//
//  Created by 3D on 17/2/7.
//  Copyright © 2017年 3D. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
@interface ViewController ()
<CBCentralManagerDelegate,
CBPeripheralDelegate
>

@property(nonatomic,strong) CBCentralManager *manager;
@property(nonatomic,strong) NSMutableArray *peripherals;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // CBPeripheral
    // Do any additional setup after loading the view, typically from a nib.
    self.manager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
}


//必须实现的代理
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    /*
     CBManagerStateUnknown = 0,
     CBManagerStateResetting,
     CBManagerStateUnsupported,
     CBManagerStateUnauthorized,
     CBManagerStatePoweredOff,
     CBManagerStatePoweredOn,
     */
    switch (central.state) {
        case CBManagerStateUnknown:
            
            break;
        case CBManagerStateResetting://重置
            
            break;
        case CBManagerStateUnsupported://不支持的
            
            break;
        case CBManagerStateUnauthorized://不被授权的
            
            break;
        case CBManagerStatePoweredOff://
            //2 扫描外设（discover），扫描外设的方法我们放在centralManager成功打开的委托中，因为只有设备成功打开，才能开始扫描，否则会报错。
            //3 开始扫描外设设备
            /*
             第一个参数nil就是扫描周围所有的外设，扫描到外设后会进入
             - (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI;
             */
            [self.manager scanForPeripheralsWithServices:nil options:nil];
            break;
        case CBManagerStatePoweredOn:
            
            break;
        default:
            break;
    }
}

//扫描设备后会进入下面方法
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{
    //4 接下来就是要链接我们的外设 设别 可以按照我们自己的规则
    if ([peripheral.name isEqualToString:@"ccc"]) {
        /*
         一个主设备最多能连7个外设，每个外设最多只能给一个主设备连接,连接成功，失败，断开会进入各自的委托
         ==============================================================================
         - (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral;//连接外设成功的委托
         - (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;//外设连接失败的委托
         - (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;//断开外设的委托
         */
        
        //重点
        //找到的设备必须持有它，否则CBCentralManager中也不会保存peripheral，那么CBPeripheralDelegate中的方法也不会被调用！！
        [self.peripherals addObject:peripheral];
        //链接外设
        [self.manager connectPeripheral:peripheral options:nil];
    }
}

//连接到Peripherals-成功
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@">>>连接到名称为（%@）的设备-成功",peripheral.name);
    //5 连接成功后 就可以扫描设备的服务了，同样是通过委托形式，扫描到结果后会进入委托方法。但是这个委托已经不再是主设备的委托（CBCentralManagerDelegate），而是外设的委托（CBPeripheralDelegate）,这个委托包含了主设备与外设交互的许多 回叫方法，包括获取services，获取characteristics，获取characteristics的值，获取characteristics的Descriptor，和Descriptor的值，写数据，读rssi，用通知的方式订阅数据等等。
    
    //5.1 设置的peripheral委托CBPeripheralDelegate
    //@interface ViewController : UIViewController<CBCentralManagerDelegate,CBPeripheralDelegate>
    peripheral.delegate = self;
    
    
}

//连接到Peripherals-失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@">>>连接到名称为（%@）的设备-失败,原因:%@",[peripheral name],[error localizedDescription]);
}

//Peripherals断开连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@">>>外设连接断开连接 %@: %@\n", [peripheral name], [error localizedDescription]);
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//保存链接的外设 设备
- (NSMutableArray *)peripherals {
	if(_peripherals == nil) {
		_peripherals = [[NSMutableArray alloc] init];
	}
	return _peripherals;
}

@end
