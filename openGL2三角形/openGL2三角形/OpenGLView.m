//
//  OpenGLView.m
//  openGL2三角形
//
//  Created by 3D on 17/3/14.
//  Copyright © 2017年 3D. All rights reserved.
//

#import "OpenGLView.h"
#import <OpenGLES/ES2/gl.h>
@interface OpenGLView ()
@property(nonatomic,strong) CAEAGLLayer *eaglLayer;
@property(nonatomic,strong) EAGLContext *context; //上下文

@property(nonatomic,assign) GLuint colorRenderBuffer;//颜色缓冲区
@property(nonatomic,assign) GLuint frameBuffer; //帧缓存区
@property(nonatomic,assign) GLuint programHandle; //完整程序处理
@property(nonatomic,assign) GLuint positionSlot; //用 glGetAttribLocation 我们获取到 shader 中定义的变量 vPosition 在 program 的槽位，通过该槽位我们就可以对 vPosition 进行操作。
@end

@implementation OpenGLView

+ (Class)layerClass{
    return [CAEAGLLayer class];
}

//设置layer
- (void)setupLayer{
    self.eaglLayer = (CAEAGLLayer *)self.layer;
    self.eaglLayer.opaque = YES;
    self.eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                         [NSNumber numberWithBool:NO], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
}

//设置上下文
- (void)setupContext{
    // 指定 OpenGL 渲染 API 的版本，在这里我们使用 OpenGL ES 2.0
    EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES2;
    self.context = [[EAGLContext alloc]initWithAPI:api];
    // 设置当前上下文
    [EAGLContext setCurrentContext:self.context];
}

//创建 颜色 缓存区
- (void)setupRenderBuffer{
    glGenRenderbuffers(1, &_colorRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, self.colorRenderBuffer);
    
    [self.context renderbufferStorage:GL_RENDERBUFFER fromDrawable:self.eaglLayer];
}

//创建帧缓存区
- (void)setupFrameBuffer{
    glGenFramebuffers(1, &_frameBuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, self.frameBuffer);
    //(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _colorRenderBuffer)
    // 讲相关缓存区 attrach 到framebuffer上
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, self.colorRenderBuffer);
}

//清除
- (void)destoryRenderAndFrameBuffer{
    glDeleteFramebuffers(1, &_frameBuffer);
    _frameBuffer = 0;
    glDeleteRenderbuffers(1, &_colorRenderBuffer);
    _colorRenderBuffer = 0;
}

//开始渲染
- (void)render{
    glClearColor(1, 1, 0, 1);
    glClear(GL_COLOR_BUFFER_BIT);
    glViewport(0, 0, self.frame.size.width, self.frame.size.height);
    
    GLfloat vertices[] =
    {
        
        0.5f, 0.5f, 0.0f,
        0.5f, -0.5f, 0.0f,
        -0.5f, -0.5f, 0.0f,
//        -0.5f, 0.5f, 0.0f,
//        0.0f, 0.0f, -0.707f,
    };

    glVertexAttribPointer(_positionSlot, 3, GL_FLOAT, GL_FALSE, 0, vertices );
    glEnableVertexAttribArray(_positionSlot);
    
    // Draw triangle
    //
    glDrawArrays(GL_TRIANGLES, 0, 3);
    
    
    [self.context presentRenderbuffer:GL_RENDERBUFFER];
}

-(GLuint)complieShaderWithPath:(NSString *)path andGLenum:(GLenum)typ{
    
    NSError *error;
    // 对内容进行编码
    /*
     [NSString stringWithContentsOfFile:path
     encoding:NSUTF8StringEncoding
     error:&error]
     */
    NSString* shaderString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    if (!shaderString) {
        NSLog(@"Error: loading shader file: %@ %@", path, error.localizedDescription);
        return 0;
    }
    
    // 2 创建shader对象
    GLuint shaderHandle = glCreateShader(typ);
    // 3 让opengl获取这个shader的源代码
    const char * shaderStringUTF8 = [shaderString UTF8String];//shaderString的源码
    NSInteger shaderStringLength = [shaderString length];
    // 加载
    glShaderSource(shaderHandle, 1, &shaderStringUTF8, &shaderStringLength);
    //编译
    glCompileShader(shaderHandle);
    
    // 5  glGetShaderiv 和 glGetShaderInfoLog  会把error信息输出到屏幕
    GLint compiled = 0;
    glGetShaderiv(shaderHandle, GL_COMPILE_STATUS, &compiled);
    
    if (!compiled) {
        //有错误打印log
        GLint infoLen = 0;
        glGetShaderiv (shaderHandle, GL_INFO_LOG_LENGTH, &infoLen);
        if (infoLen > 1) {
            //malloc 想系统申请指定size的空间  申请单位为 char的空间乘infoLen个数
            char * infoLog = malloc(sizeof(char) * infoLen);
            glGetShaderInfoLog (shaderHandle, infoLen, NULL, infoLog);
            NSLog(@"Error compiling shader:\n%s\n", infoLog );
            free(infoLog);
        }
        glDeleteShader(shaderHandle);
        return 0;
    }
    return shaderHandle;
}

- (void)setupProgram{
    NSString *vertexShaderPath = [[NSBundle mainBundle]pathForResource:@"VertexShader" ofType:@"glsl"];//定点着色器路径
    NSString *fragmentShaderPath = [[NSBundle mainBundle] pathForResource:@"FragmentShader" ofType:@"glsl"];//片段着色器
    GLuint vertexShader = [self complieShaderWithPath:vertexShaderPath andGLenum:GL_VERTEX_SHADER];
    GLuint fragmentShader = [self complieShaderWithPath:fragmentShaderPath andGLenum:GL_FRAGMENT_SHADER];
    
    // 将vertex 和 fragment shader 链接成一个完整的程序
    GLuint programHandle = glCreateProgram();
    glAttachShader(programHandle, vertexShader);
    glAttachShader(programHandle, fragmentShader);
    // Link the program
    glLinkProgram(programHandle);
    //检查是否链接成功
    GLint linkSuccess;
    glGetProgramiv(programHandle, GL_LINK_STATUS, &linkSuccess);
    
    GLint linked;
    glGetProgramiv(programHandle, GL_LINK_STATUS, &linked);
    
    if (!linked) {
        GLint infoLen = 0;
        glGetProgramiv(programHandle, GL_INFO_LOG_LENGTH, &infoLen);
        
        if (infoLen > 1){
            char * infoLog = malloc(sizeof(char) * infoLen);
            glGetProgramInfoLog(programHandle, infoLen, NULL, infoLog);
            
            NSLog(@"Error linking program:\n%s\n", infoLog);
            
            free(infoLog);
        }
        glDeleteProgram(programHandle );
        return;
    }
    self.programHandle = programHandle;
    glUseProgram(programHandle);
    _positionSlot = glGetAttribLocation(_programHandle, "vPosition");
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupLayer];
        [self setupContext];
        [self setupProgram];
    }
    return self;
}

- (void)layoutSubviews{
    [self destoryRenderAndFrameBuffer];
    [self setupRenderBuffer];
    [self setupFrameBuffer];
    [self render];
}
@end


/*
 关键词
 定点着色器
 片元着色器
 */



















