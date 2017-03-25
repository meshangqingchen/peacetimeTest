//
//  ViewController.h
//  蓝牙demo
//
//  Created by 3D on 17/2/13.
//  Copyright © 2017年 3D. All rights reserved.
//

#import <UIKit/UIKit.h>

static const Byte CMD_HEAD_END         = '#';
static const Byte CMD_SYS_PARAM        = 0x02;
static const Byte CMD_STEP_PARAM_1     = 0x05;
static const Byte CMD_STEP_PARAM_2     = 0x06;
static const Byte CMD_STEP_PARAM_3     = 0x07;
static const Byte CMD_STEP_PARAM_4     = 0x08;
static const Byte CMD_STEP_COUNT       = 0x09;
static const Byte CMD_BATTERY_POWER    = 0x06;
static const Byte CMD_SYNC_DATA        = 0x50;
static const Byte CMD_SYNC_REPLY       = 0x52;
static const Byte CMD_SYNC_SUBPACKAGE  = 0x54;
static const Byte CMD_SYNC_FINISH      = 0x56;
static const Byte CMD_BUZZER_ON        = 0x26;
static const Byte CMD_BUZZER_OFF       = 0x28;
static const Byte CMD_FLASH_LIGHT_ON   = 0x22;
static const Byte CMD_FLASH_LIGHT_OFF  = 0x24;
static const Byte CMD_RESET_FACTORY    = 0x04;

static const Byte RESP_SYS_PARAM       = 0x01;
static const Byte RESP_STEP_COUNT      = 0x07;
static const Byte RESP_BATTERY_POWER   = 0x05;
static const Byte RESP_SYNC_DATA       = 0x51;
static const Byte RESP_SYNC_SUBPACKAGE = 0x53;
static const Byte RESP_RESET_FACTORY   = 0x03;

@interface ViewController : UIViewController



@end

