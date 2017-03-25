//
//  OpenGLView.m
//  OpenGL1
//
//  Created by 3D on 17/3/13.
//  Copyright © 2017年 3D. All rights reserved.
//

#import "OpenGLView.h"
//#import <QuartzCore/QuartzCore.h>
#include <OpenGLES/ES2/gl.h>
//#include <OpenGLES/ES2/glext.h>

@interface OpenGLView ()
@property(nonatomic,strong) CAEAGLLayer *eaglLayer;
@property(nonatomic,strong) EAGLContext *context;
@property(nonatomic,assign) GLuint colorRenderBuffer;
@property(nonatomic,assign) GLuint frameBuffer;

@end

@implementation OpenGLView

+ (Class)layerClass{
    return [CAEAGLLayer class];
}

//设置layer
- (void)setupLayer{
    self.eaglLayer = (CAEAGLLayer*)self.layer;
    // CALayer 默认是透明的，必须将它设为不透明才能让其可见
    _eaglLayer.opaque = YES;
    //drawableProperties是EAGLDrawable协议属性 CAEAGLLayer尊选EAGLDrawable协议
    _eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                     [NSNumber numberWithBool:NO], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
}
//设置上下文
- (void)setupContext{
    // 指定 OpenGL 渲染 API 的版本，在这里我们使用 OpenGL ES 2.0
    EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES2;
    self.context = [[EAGLContext alloc] initWithAPI:api];
    // 设置为当前上下文
    [EAGLContext setCurrentContext:self.context];
}
//创建颜色渲染缓存
- (void)setupRenderBuffer {
    /*它是为 renderbuffer 申请一个 id（或曰名字）。参数 n 表示申请生成
    renderbuffer 的个数，而 renderbuffers 返回分配给 renderbuffer 的 id，注意：返回的 id 不会为0，id 0 是OpenGL ES 保留的，我们也不能使用 id 为0的 renderbuffer。*/
    //glGenRenderbuffers (GLsizei n, GLuint* renderbuffers)
    glGenRenderbuffers(1, &_colorRenderBuffer);
    NSLog(@"++++%u",_colorRenderBuffer);
    /*
     这个函数将指定 id 的 renderbuffer 设置为当前 renderbuffer。参数 target 必须为 GL_RENDERBUFFER，参数 renderbuffer 是就是使用 glGenRenderbuffers 生成的 id。当指定 id 的 renderbuffer 第一次被设置为当前 renderbuffer 时，会初始化该 renderbuffer 对象，其初始值为：
     */
    //glBindRenderbuffer(<#GLenum target#>, <#GLuint renderbuffer#>)
    glBindRenderbuffer(GL_RENDERBUFFER, self.colorRenderBuffer);
    NSLog(@"====%u",_colorRenderBuffer);
    
    /*
     在内部使用 drawable（在这里是 EAGLLayer）的相关信息（还记得在 setupLayer 时设置了drawableProperties的一些属性信息么？）作为参数调用了 glRenderbufferStorage(GLenum target, GLenum internalformat, GLsizei width, GLsizei height); 后者 glRenderbufferStorage 指定存储在 renderbuffer 中图像的宽高以及颜色格式，并按照此规格为之分配存储空间。在这里，将使用我们在前面设置 eaglLayer 的颜色格式 RGBA8， 以及 eaglLayer 的宽高作为参数调用 glRenderbufferStorage。
     */
    [self.context renderbufferStorage:GL_RENDERBUFFER fromDrawable:self.eaglLayer];
    
}

- (void)setupFrameBuffer{
    glGenFramebuffers(1, &_frameBuffer);
    // 设置为当前 framebuffer
    glBindFramebuffer(GL_FRAMEBUFFER, self.frameBuffer);
    // 好难理解的参数 懵逼
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _colorRenderBuffer);

}

- (void)destoryRenderAndFrameBuffer
{
    glDeleteFramebuffers(1, &_frameBuffer);
    _frameBuffer = 0;
    glDeleteRenderbuffers(1, &_colorRenderBuffer);
    _colorRenderBuffer = 0;
}

- (void)render{
    glClearColor(0, 0, 1.0, 1);
    glClear(GL_COLOR_BUFFER_BIT);
    [_context presentRenderbuffer:GL_RENDERBUFFER];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupLayer];
        [self setupContext];
    }
    return self;
}

- (void)layoutSubviews {
    [self destoryRenderAndFrameBuffer];
    
    [self setupRenderBuffer];
    [self setupFrameBuffer];
    
    [self render];
}

@end






//Render buffer渲染缓冲
//Frame  buffer帧缓存
//Vertex Shade 顶点着色器
//Fragment Shader 片段着色器






















