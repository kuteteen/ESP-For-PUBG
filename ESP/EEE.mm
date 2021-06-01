
#import "EEE.h"
#import <UIKit/UIKit.h>
#import <stdio.h>
#import <mach-o/dyld.h>
#import <mach/vm_region.h>
#import <malloc/malloc.h>
#import <objc/runtime.h>
#import <mach/mach.h>
#include "Gobal.h"
#import "utf.h"
//追踪
//#import "dobby.h"
//#import "Hook.h"

#define kLogOpen 0
float screenx = 1024;
float screeny = 768;
float juzhenshuju[16];

typedef struct Vector{
    float X;
    float Y;
    float Z;
}Vector;

@interface DDDD()
@property (nonatomic,  assign) CGFloat  scale;
@property (nonatomic,  assign) CGFloat  theWidth;
@property (nonatomic,  assign) CGFloat  theHeight;
@end

@implementation DDDD

+ (instancetype)data
{
    static DDDD *fact;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fact = [[DDDD alloc] init];
    });
    return fact;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIScreen *screen = [UIScreen mainScreen];
        CGFloat width  = screen.bounds.size.width;
        CGFloat height = screen.bounds.size.height;
        
        _scale = screen.scale;
        _theWidth = width * [UIScreen mainScreen].scale;
        _theHeight = height * [UIScreen mainScreen].scale;
    }
    return self;
}

#pragma mark - private

// 定义vm获取方式
- (BOOL)vmreadData:(void *)buf address:(long)address length:(long)length
{
    vm_size_t size = 0;
    kern_return_t error = vm_read_overwrite(mach_task_self(), (vm_address_t)address, length, (vm_address_t)buf, &size);
    if(error != KERN_SUCCESS || size != length){
        return NO;
    }
    return YES;
}

// WorldToScreen2
- (Vector)word:(Vector)vector matrix:(float *)matrix
{
    struct Vector outVec = {0,0};
    
    // 矩阵,世界坐标转换屏幕坐标
    float view = matrix[3] * vector.X + matrix[7] * vector.Y + matrix[11] * vector.Z + matrix[15];
    float x,y,z;
    
    if (view < 0.01) {
        z = matrix[8] * vector.X + matrix[9] * vector.Y + matrix[10] * vector.Z + matrix[11];
        x = _theWidth + (matrix[0] * vector.X + matrix[4] * vector.Y + matrix[8] * vector.Z + matrix[12]) / 2 * _theWidth;
        y = _theHeight - (matrix[1] * vector.X + matrix[5] * vector.Y + matrix[9] * vector.Z + matrix[13]) / 2 * _theHeight;
    }else{
        z = matrix[3] * vector.X + matrix[7] * vector.Y + matrix[11] * vector.Z + matrix[15];
        x = _theWidth + (matrix[0] * vector.X + matrix[4] * vector.Y + matrix[8] * vector.Z + matrix[12]) / z * _theWidth;
        y = _theHeight - (matrix[1] * vector.X + matrix[5] * vector.Y + matrix[9] * vector.Z + matrix[13]) / z * _theHeight;
    }
    
    outVec.X = x/2;
    outVec.Y = y/2;
    
    return outVec;
}


#pragma mark - public

- (void)fetchData:(ESPDDDDFetchDataBlock)block
{
    //追踪
    //    [Hook shareInstance].x =0;
    //    [Hook shareInstance].y =0;
    //    [Hook shareInstance].z =0;
    // 获取基址
    long mh_addr = (long)_dyld_get_image_header(0);
    
    //
    long GWorld = *(long*)(mh_addr + 0x08B25430);
    if (kLogOpen) {
        NSLog(@"*** GWorld: %ld",GWorld);
    }
    if(!GWorld) {
        return;
    }
    
    
    //
    long PLevel = *(long*)(GWorld + 0x30);
    if (kLogOpen) {
        NSLog(@"*** PLevel: %ld",PLevel);
    }
    if(!PLevel) {
        return;
    }
    
    //
    int max = *(int*)(PLevel + 0xAC);
    int count = *(int*)(PLevel + 0xA8);
    long Actors = *(long*)(PLevel + 0xA0);
    
    if (kLogOpen) {
        NSLog(@"*** max: %d",max);
        NSLog(@"*** count: %d",count);
        NSLog(@"*** Actors: %ld",Actors);
    }
    
    if(!(Actors && count > 0 && count < max)) {
        return;
    }
    
    
    
    //
    long juzhen = *(long*)(mh_addr + 0x88DAF70+0x98);
    if (kLogOpen) {
        NSLog(@"*** juzhen: %ld",juzhen);
    }
    if(!juzhen) {
        return;
    }
    
    //
    long juzhen2 = *(long*)(juzhen+0x98);
    if (kLogOpen) {
        NSLog(@"*** juzhen2: %ld",juzhen2);
    }
    if(!juzhen2) {
        return;
    }
    
    float* yxjz = (float*)(juzhen2+0x750);
    [self vmreadData:juzhenshuju address:(long)yxjz length:16*4];
    
    NSMutableArray *data = @[].mutableCopy;
    NSMutableArray *hpData = @[].mutableCopy;
    NSMutableArray *disData = @[].mutableCopy;
    NSMutableArray *nameData = @[].mutableCopy;
    NSMutableArray *aiData = @[].mutableCopy;
    
    
    NSMutableArray *data1 = @[].mutableCopy;
    NSMutableArray *data2 = @[].mutableCopy;
    NSMutableArray *data3 = @[].mutableCopy;
    NSMutableArray *data4 = @[].mutableCopy;
    NSMutableArray *data5 = @[].mutableCopy;
    NSMutableArray *data6 = @[].mutableCopy;
    NSMutableArray *data7 = @[].mutableCopy;
    NSMutableArray *data8 = @[].mutableCopy;
    
    for (int i = 0; i < count; i++) {
        //
        long ziji = *(long*)(PLevel + 0xB0);
        if(!ziji) {    continue;    }
        
        
        ziji = *(long*)(ziji + 0x48 );
        if(!ziji) {    continue; }
        
        
        
        long man = ((long*)Actors)[i];
        
        //不绘制自己和绘制在车辆上的
        if(!man || man == ziji ) {            continue;   }
        long A_addr = ziji+0x890;
        if( !A_addr){ continue;   }
        
        long B_addr = man +0x890;
        if( !B_addr){ continue;   }
        UInt8 A=0, B=0;
        [self vmreadData:&A address:A_addr length:1];
        [self vmreadData:&B address:B_addr length:1];
        
        if (A==B) {NSLog(@"*** dui you");
            continue;
        }
        
        Vector zb = {0};
        [self vmreadData:&zb address:(man + 0x1F20) length:12];
        Vector myzb = {0};
        [self vmreadData:&myzb address:ziji + 0x1F20 length:12];
        
        float xue = 0;
        [self vmreadData:&xue address:(man + 0xB78) length:4];
        float xue2 = 0;
        [self vmreadData:&xue2 address:(man + 0xB7c) length:4];
        float xue3 = 0;
        [self vmreadData:&xue3 address:(ziji + 0xBC4) length:4];
        /// 距离公式
        CGFloat distX = (zb.X - myzb.X) / 100;
        CGFloat distY = (zb.Y - myzb.Y) / 100;
        CGFloat distance = (distX * distX) + (distY * distY);
        CGFloat distZ = (zb.Z - myzb.Z)/100;
        
        distance = sqrt((distZ * distZ) + distance);
        if( distance>0 &&distance<=400 &&xue>=0&&  xue <= 100 && xue2==100) {
            //if(xue2== 100){
            
            int isAI = *(int *)(man + 0x8AC);
            
            Vector zb1 = zb;
            zb1.Z += 80;
            
            Vector zb2 = zb;
            zb2.Z -= 80;
            
            Vector fkzb1 = [self word:zb1 matrix:yxjz];
            Vector fkzb2 = [self word:zb2 matrix:yxjz];
            
            float height = fkzb2.Y - fkzb1.Y;
            float width  = height / 2;
            
            float originX = fkzb1.X - width / 2;
            float originY = fkzb1.Y;
            CGRect rect = CGRectMake(originX/_scale, originY/_scale, width/_scale, height/_scale);
            
            long name = *(long*)(man + 0x830);
            if(!name) {  continue;  }
            UTF8 PlayerName[32] = "";
            UTF16 buf16[16] = {0};
            if(name){
                [self vmreadData:&buf16 address:name length:28];
                Utf16_To_Utf8(buf16, PlayerName, 28, strictConversion);
            }
            NSString *Name = [NSString stringWithUTF8String:(const char *)PlayerName];
            
            
            //骨骼公式
            
            //获取指针
            long mesh = *(long*)(man + 0x450);
            if (!mesh) {   continue;  };
            
            //主躯干
            Vector pos = GetBoneWithRotation(mesh, Bones::Head);
            Vector head = [self word:pos matrix:yxjz];//头部
            //追踪
            //             [Hook shareInstance].x =zb.X;
            //             [Hook shareInstance].y =zb.Y+1;
            //             [Hook shareInstance].z =zb.Z;
            pos = GetBoneWithRotation(mesh, Bones::Spine);
            Vector spine = [self word:pos matrix:yxjz];//胸部
            pos = GetBoneWithRotation(mesh, Bones::Pelvis);
            Vector pelvis = [self word:pos matrix:yxjz];//盆骨
            //左上半身
            pos = GetBoneWithRotation(mesh, Bones::Left_Shoulder);
            Vector leftShoulder = [self word:pos matrix:yxjz];//左肩膀
            Vector leftElbow = [self word:GetBoneWithRotation(mesh, Bones::Left_Elbow) matrix:yxjz];//左手肘
            Vector leftHand = [self word:GetBoneWithRotation(mesh, Bones::Left_Hand) matrix:yxjz];//左手
            //右上半身
            pos = GetBoneWithRotation(mesh, Bones::Right_Shoulder);
            Vector rightShoulder = [self word:pos matrix:yxjz];//右肩膀
            Vector rightElbow = [self word:GetBoneWithRotation(mesh, Bones::Right_Elbow) matrix:yxjz];//右手肘
            Vector rightHand = [self word:GetBoneWithRotation(mesh, Bones::Right_Hand) matrix:yxjz];//右手
            //左下半身
            Vector leftPelvis = [self word:GetBoneWithRotation(mesh, Bones::Left_Pelvis) matrix:yxjz];//左屁股
            Vector leftKnee =[self word:GetBoneWithRotation(mesh, Bones::Left_Knee) matrix:yxjz];//左膝
            Vector leftFoot = [self word:GetBoneWithRotation(mesh, Bones::Left_Foot) matrix:yxjz];//左脚
            //右下半身
            Vector rightPelvis = [self word:GetBoneWithRotation(mesh, Bones::Right_Pelvis) matrix:yxjz];//右屁股
            Vector rightKnee = [self word:GetBoneWithRotation(mesh, Bones::Right_Knee) matrix:yxjz];//右膝
            Vector rightFoot = [self word:GetBoneWithRotation(mesh, Bones::Right_Foot) matrix:yxjz];//右脚
            
            //坐标保存到结构体
            CGRect rect1 = CGRectMake(head.X, head.Y, spine.X, spine.Y);
            CGRect rect2 = CGRectMake(pelvis.X, pelvis.Y, leftShoulder.X, leftShoulder.Y);
            CGRect rect3 = CGRectMake(leftElbow.X, leftElbow.Y, leftHand.X, leftHand.Y);
            CGRect rect4 = CGRectMake(rightShoulder.X, rightShoulder.Y, rightElbow.X, rightElbow.Y);
            CGRect rect5 = CGRectMake(rightHand.X, rightHand.Y, leftPelvis.X, leftPelvis.Y);
            CGRect rect6 = CGRectMake(leftKnee.X, leftKnee.Y, leftFoot.X, leftFoot.Y);
            CGRect rect7 = CGRectMake(rightPelvis.X, rightPelvis.Y, rightKnee.X, rightKnee.Y);
            CGRect rect8 = CGRectMake(rightFoot.X, rightFoot.Y, 0, 0);
            
            
            [data addObject:[NSValue valueWithCGRect:rect]];
            [hpData addObject:@(xue)];
            [nameData addObject:[NSString stringWithString:Name]];
            [disData addObject:@(distance)];
            [aiData addObject:@(isAI)];
            
            [data1 addObject:[NSValue valueWithCGRect:rect1 ]];
            [data2 addObject:[NSValue valueWithCGRect:rect2 ]];
            [data3 addObject:[NSValue valueWithCGRect:rect3 ]];
            [data4 addObject:[NSValue valueWithCGRect:rect4 ]];
            [data5 addObject:[NSValue valueWithCGRect:rect5 ]];
            [data6 addObject:[NSValue valueWithCGRect:rect6 ]];
            [data7 addObject:[NSValue valueWithCGRect:rect7 ]];
            [data8 addObject:[NSValue valueWithCGRect:rect8 ]];
            
        }
    }
    
    if (block) {
        block(data, hpData, disData,nameData,aiData,data1,data2,data3,data4,data5,data6,data7,data8);
    }
}


LTMatrix MatrixMultiplication(LTMatrix pM1, LTMatrix pM2);
LTMatrix MatrixMultiplication(LTMatrix pM1, LTMatrix pM2)
{
    LTMatrix pOut;
    pOut.a1 = pM1.a1 * pM2.a1 + pM1.a2 * pM2.b1 + pM1.a3 * pM2.c1 + pM1.a4 * pM2.d1;
    pOut.a2 = pM1.a1 * pM2.a2 + pM1.a2 * pM2.b2 + pM1.a3 * pM2.c2 + pM1.a4 * pM2.d2;
    pOut.a3 = pM1.a1 * pM2.a3 + pM1.a2 * pM2.b3 + pM1.a3 * pM2.c3 + pM1.a4 * pM2.d3;
    pOut.a4 = pM1.a1 * pM2.a4 + pM1.a2 * pM2.b4 + pM1.a3 * pM2.c4 + pM1.a4 * pM2.d4;
    pOut.b1 = pM1.b1 * pM2.a1 + pM1.b2 * pM2.b1 + pM1.b3 * pM2.c1 + pM1.b4 * pM2.d1;
    pOut.b2 = pM1.b1 * pM2.a2 + pM1.b2 * pM2.b2 + pM1.b3 * pM2.c2 + pM1.b4 * pM2.d2;
    pOut.b3 = pM1.b1 * pM2.a3 + pM1.b2 * pM2.b3 + pM1.b3 * pM2.c3 + pM1.b4 * pM2.d3;
    pOut.b4 = pM1.b1 * pM2.a4 + pM1.b2 * pM2.b4 + pM1.b3 * pM2.c4 + pM1.b4 * pM2.d4;
    pOut.c1 = pM1.c1 * pM2.a1 + pM1.c2 * pM2.b1 + pM1.c3 * pM2.c1 + pM1.c4 * pM2.d1;
    pOut.c2 = pM1.c1 * pM2.a2 + pM1.c2 * pM2.b2 + pM1.c3 * pM2.c2 + pM1.c4 * pM2.d2;
    pOut.c3 = pM1.c1 * pM2.a3 + pM1.c2 * pM2.b3 + pM1.c3 * pM2.c3 + pM1.c4 * pM2.d3;
    pOut.c4 = pM1.c1 * pM2.a4 + pM1.c2 * pM2.b4 + pM1.c3 * pM2.c4 + pM1.c4 * pM2.d4;
    pOut.d1 = pM1.d1 * pM2.a1 + pM1.d2 * pM2.b1 + pM1.d3 * pM2.c1 + pM1.d4 * pM2.d1;
    pOut.d2 = pM1.d1 * pM2.a2 + pM1.d2 * pM2.b2 + pM1.d3 * pM2.c2 + pM1.d4 * pM2.d2;
    pOut.d3 = pM1.d1 * pM2.a3 + pM1.d2 * pM2.b3 + pM1.d3 * pM2.c3 + pM1.d4 * pM2.d3;
    pOut.d4 = pM1.d1 * pM2.a4 + pM1.d2 * pM2.b4 + pM1.d3 * pM2.c4 + pM1.d4 * pM2.d4;
    
    return pOut;
}

FTransform GetBoneIndex(const long mesh, int index);
FTransform GetBoneIndex(const long mesh, int index) {
    long v30 = *(long *)(mesh + 1736);
    long boneBase = (v30 + 48LL * index);
    
    FTransform result;
    if(boneBase>0x100000000){
        
        result.rot.x = *(float*)(boneBase + 0x0);
        result.rot.y = *(float*)(boneBase + 0x4);
        result.rot.z = *(float*)(boneBase + 0x8);
        result.rot.w = *(float*)(boneBase + 0xC);
        CVector3 pos;
        
        pos.x = *(float*)(boneBase + 0x10);
        pos.y = *(float*)(boneBase + 0x14);
        pos.z = *(float*)(boneBase + 0x18);
        
        
        if (index == 6)
        {
            if (pos.x <= -25.0f)
            {
                result.translation.x = pos.x + (pos.x / 2);
            }
            else if (pos.x >= 25.0f)
            {
                result.translation.x = pos.x + (pos.x / 3.5);
            }
            else
            {
                result.translation.x = pos.x + (pos.x / 2);
            }
            
            result.translation.y = pos.y + 12.0f;
            result.translation.z = pos.z + 10.0f;
        }
        else if (index == 4)
        {
            result.translation.x = pos.x;
            result.translation.y = pos.y;
            result.translation.z = pos.z + 10.0f;;
        }
        else
        {
            result.translation.x = pos.x;
            result.translation.y = pos.y;
            result.translation.z = pos.z;
        }
        
        if (index == 4)
        {
            result.translation.z += 10;
        }
        
        result.scale.x = *(float*)(boneBase + 0x20);
        result.scale.y = *(float*)(boneBase + 0x24);
        result.scale.z = *(float*)(boneBase + 0x2C);
    }
    
    
    return result;
}

Vector GetBoneWithRotation(const long mesh, int id)
//GetBoneWithRotation
{
    Vector result;
    
    FTransform bone = GetBoneIndex(mesh, id);
    
    FTransform ComponentToWorld;
    ComponentToWorld.rot.x = *(float*)(mesh + 0x1b0);
    ComponentToWorld.rot.y = *(float*)(mesh + 0x1b4);
    ComponentToWorld.rot.z = *(float*)(mesh + 0x1b8);
    ComponentToWorld.rot.w = *(float*)(mesh + 0x1bc);
    
    ComponentToWorld.translation.x = *(float*)(mesh + 0x1c0);
    ComponentToWorld.translation.y = *(float*)(mesh + 0x1c4);
    ComponentToWorld.translation.z = *(float*)(mesh + 0x1c8);
    
    ComponentToWorld.scale.x = *(float*)(mesh + 0x1d0);
    ComponentToWorld.scale.y = *(float*)(mesh + 0x1d4);
    ComponentToWorld.scale.z = *(float*)(mesh + 0x1d8);
    
    LTMatrix Matrix;
    Matrix = MatrixMultiplication(bone.ToMatrixWithScale(), ComponentToWorld.ToMatrixWithScale());
    
    result.X = Matrix.d1;
    result.Y = Matrix.d2;
    result.Z = Matrix.d3;
    
    return result;
}





@end
