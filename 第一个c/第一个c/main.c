//
//  main.c
//  第一个c
//
//  Created by 3D on 16/12/22.
//  Copyright © 2016年 3D. All rights reserved.
//

#include <stdio.h>

//int main(int argc, const char * argv[]) {
//    // insert code here...
//    printf("Hello, World!\n");
//    return 0;
//}

int main(void){
    
    int ten = 10;
    int tow = 2;
    
    printf("%d miuns %d is %d\n",ten,2,ten-tow);
    
    printf("=== %o \n",73);//八进制;
    printf("=== %x \n",16);//16进制;
    
    printf("=== %#o \n",8);//显示c语言前缀.
    printf("=== %#x \n",16);
    
    //假设我们的系统 int 类型是32 位的 那么 int所能表达的做大正数 是2147483647
    //
    int i  = 2147483647;
    unsigned  j = 4294967295;
    printf("%d %d %d\n",i,i+1,i+2);//溢出 结果是2147483647 -2147483648 -2147483647
    printf("%d %d %d\n",j,j+1,j+2);//溢出 结果是-1 0 1
    //无符号的值得起始点 是0当溢出的时候会 从返回到起始点.....同样int 变量i的起始点 是-2147483648
    
    char zifu = 'a';
    printf("%c\n",zifu);
    printf("%d\n",zifu);
    
    int zifu1 = 97;
    printf("== %c\n",zifu1);
    
    char zifu2 = 'QWAF'; //'QWAF'占了32位 每一个字符占据8位 zifu2只取最后面的8为
    printf("++ %c\n",zifu2);
    
    char fengming = '\007';
    printf("fengming = %c\n",fengming);
    
    
    
    
    static unsigned char kPNGSignatureBytes[8] = {0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A};
    printf("fengming = %s\n",kPNGSignatureBytes);
    return 0;
}
