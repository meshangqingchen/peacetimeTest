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
@property(nonatomic,assign) GLuint modelViewSlot;
@property(nonatomic,assign) GLuint projectionSlot ;

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

- (void)drawTriCone{

    GLfloat vertices[] = {
        
        0.7f, 0.7f, 0.0f,  // 0
        0.7f, -0.7f, 0.0f, // 1
        -0.7f, -0.7f, 0.0f,// 2
        -0.7f, 0.7f, 0.0f, // 3
        0.0f, 0.0f, -1.0f, // 4
    };
    
    GLubyte indices[] = {
        0, 1, 1,
        2, 2, 3,
        3, 0, 4,
        0, 4, 1,
        4, 2, 4, 3
        
//        0,1,2,
//        0,2,3,
//        0,3,4,
//        0,4,1,
//        4,3,2,1
    };
    
    glLineWidth(10); // 设置线的宽度
    
    //得到线的宽度
//    GLfloat lineWidthRange[2];
//    glGetFloatv(GL_ALIASED_LINE_WIDTH_RANGE, lineWidthRange);
//    for (int i = 0; i<2; i++) {
//        printf("= = = %f",lineWidthRange[i]);
//    }
    glVertexAttribPointer(_positionSlot, 3, GL_FLOAT, GL_FALSE, 0, vertices );
    glEnableVertexAttribArray(_positionSlot);
    
    // Draw lines
    /*
     GL_POINTS                                        0x0000 点
    
     GL_LINES                                         0x0001 线
     GL_LINE_LOOP                                     0x0002
     GL_LINE_STRIP                                    0x0003
    
     GL_TRIANGLES                                     0x0004三角形
     GL_TRIANGLE_STRIP                                0x0005
     GL_TRIANGLE_FAN                                  0x0006
     */
    //(GLenum mode, GLsizei count, GLenum type, const GLvoid* indices)
    NSLog(@"%ld",sizeof(indices));
    NSLog(@"%ld",sizeof(GLubyte));
    
    glDrawElements(GL_LINES, sizeof(indices)/sizeof(GLubyte), GL_UNSIGNED_BYTE, indices);
}

- (void)drawTriangle{
    GLfloat vertices[] =
    {
        0.5f, 0.5f, 0.0f,
        0.5f, -0.5f, 0.0f,
        -0.5f, -0.5f, 0.0f,
        -0.5f, 0.5f, 0.0f
    };
    /*
     然后我们创建一个三角形顶点数组，通过 glVertexAttribPointer 将三角形顶点数据装载到 OpenGL ES 中并与 vPositon 关联起来，最后通过  glDrawArrays 将三角形图元渲染出来。
     
     (GLuint indx, GLint size, GLenum type, GLboolean normalized, GLsizei stride, const GLvoid* ptr)
     */
    glVertexAttribPointer(_positionSlot, 3, GL_FLOAT, GL_FALSE, 0, vertices );
    glEnableVertexAttribArray(_positionSlot);
    //(GLenum mode, GLint first, GLsizei count)
    glDrawArrays(GL_LINE_LOOP, 0, 4);//3 就是几个点
}

//开始渲染
- (void)render{
    glClearColor(1, 1, 0, 1);
    glClear(GL_COLOR_BUFFER_BIT);
    glViewport(0, 0, self.frame.size.width, self.frame.size.height);
    
    
//    [self drawTriangle];
    [self drawTriCone];
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
    // Get the attribute position slot from program
    _positionSlot = glGetAttribLocation(_programHandle, "vPosition");
    
    // Get the uniform model-view matrix slot from program
    //
    _modelViewSlot = glGetUniformLocation(_programHandle, "modelView");
    
    // Get the uniform projection matrix slot from program
    //
    _projectionSlot = glGetUniformLocation(_programHandle, "projection");
    
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

/*
 [self setupLayer];
 [self setupContext];
 [self setupProgram];
 [self destoryRenderAndFrameBuffer];
 [self setupRenderBuffer];
 [self setupFrameBuffer];
 [self render];
 
 
 
 创建layer
 创建上下文
  
 创建定点着色器
 创建片段着色器
 根据 定点着色器和片段着色器创建完整程序programHandle
 链接link programHandle
 判断是否链接成功
 生成 Attrib Location 貌似是槽点
 
 清除
 创建颜色缓存区
 创建帧缓存区
 开始渲染
 */


















