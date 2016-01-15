//
//  LPHFiveViewController.m
//  LPHTuanChe
//
//  Created by 千锋 on 15/12/31.
//  Copyright (c) 2015年 李鹏辉. All rights reserved.
//

#import "LPHFiveViewController.h"
#import "LPHKmagn.h"
#import "LPHFiveTableViewCell.h"
#import "ImageMethodTool.h"
#import "LPHFiveGroupModel.h"
#import "LPHFiveModel.h"

@interface LPHFiveViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong,nonatomic)UIButton *touxiang;

@property (strong,nonatomic)NSMutableArray *groups;

@end

@implementation LPHFiveViewController

-(NSMutableArray *)groups
{
    if(_groups == nil)
    {
        _groups = [NSMutableArray array];
    }
    return _groups;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    [self headTableView];
    
    [self setGroups];
}
-(void)setGroups
{
    [self setGroup1];
    [self setGroup2];
    [self setGroup3];
}
-(void)setGroup1
{
    LPHFiveGroupModel *group = [LPHFiveGroupModel group];
    [self.groups addObject:group];
    
    LPHFiveModel *maiche = [LPHFiveModel itemWithTitle:@"买车订单" andLogo:@"icon_wode_mai"];
    LPHFiveModel *yangche = [LPHFiveModel itemWithTitle:@"养车订单" andLogo:@"icon_wode_yangche"];
    LPHFiveModel *maichedingdan = [LPHFiveModel itemWithTitle:@"卖车订单" andLogo:@"icon_wode_maiche"];
    group.groupArray = @[maiche,yangche,maichedingdan];
}
-(void)setGroup2
{
    LPHFiveGroupModel *group = [LPHFiveGroupModel group];
    [self.groups addObject:group];
    
    LPHFiveModel *jiayou = [LPHFiveModel itemWithTitle:@"加油记录" andLogo:@"jiayou"];
    LPHFiveModel *baoxian = [LPHFiveModel itemWithTitle:@"保险订单" andLogo:@"baoxian"];
    group.groupArray = @[jiayou,baoxian];
}
-(void)setGroup3
{
    LPHFiveGroupModel *group = [LPHFiveGroupModel group];
    [self.groups addObject:group];
    
    LPHFiveModel *hongbao = [LPHFiveModel itemWithTitle:@"我的红包" andLogo:@"icon_wode_hongbao"];
    LPHFiveModel *youhuijuan = [LPHFiveModel itemWithTitle:@"我的优惠劵" andLogo:@"icon_diyongquan"];
    group.groupArray = @[hongbao,youhuijuan];
}
-(void)headTableView
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT/4)];
    headView.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1];
    _tableView.tableHeaderView = headView;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, (headView.bounds.size.height-6)/3)];
    label.backgroundColor = [UIColor whiteColor];
    label.text = @"我的";
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:label];
    UIButton *shezhiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shezhiBtn.frame = CGRectMake(WIDTH-40, (label.frame.size.height-24)/2, 24, 24);
    [shezhiBtn setBackgroundImage:[UIImage imageNamed:@"icon_shezhi"] forState:UIControlStateNormal];
    [shezhiBtn addTarget:self action:@selector(shezhiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:shezhiBtn];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (headView.bounds.size.height - 6)/3, WIDTH, (headView.bounds.size.height-6)/3*2)];
    imageView.image = [UIImage imageNamed:@"user_bg_head"];
    [headView addSubview:imageView];
    _touxiang = [UIButton buttonWithType:UIButtonTypeCustom];
    _touxiang.frame = CGRectMake(10, (imageView.frame.size.height-50)/2, 50, 50);
    [_touxiang setBackgroundImage:[UIImage imageNamed:@"user_bg_head_pic"] forState:UIControlStateNormal];
    [_touxiang addTarget:self action:@selector(touxiangClick) forControlEvents:UIControlEventTouchUpInside];
    _touxiang.layer.cornerRadius = 25;
    _touxiang.layer.masksToBounds = YES;
    [imageView addSubview:_touxiang];
    
    UILabel *xinxi = [[UILabel alloc]initWithFrame:CGRectMake(70, (imageView.frame.size.height - 30)/2, 180, 30)];
    xinxi.text = @"李少";
    xinxi.font = [UIFont systemFontOfSize:20];
    [imageView addSubview:xinxi];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH - 40, (imageView.frame.size.height - 30)/2, 20, 30)];
    image.image = [UIImage imageNamed:@"icon_arraw_right"];
    [imageView addSubview:image];
    
    UIButton *bigBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bigBtn.frame = CGRectMake(65, 0, WIDTH-65, imageView.frame.size.height);
    [bigBtn addTarget:self action:@selector(bigBtnClick) forControlEvents:UIControlEventTouchUpInside];
    imageView.userInteractionEnabled = YES;
    [imageView addSubview:bigBtn];
}
-(void)shezhiBtnClick{
    NSLog(@"123");
}
-(void)touxiangClick{
    UIActionSheet *actionSheep = [[UIActionSheet alloc]initWithTitle:@"选取图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册选取",@"拍照", nil];
    [actionSheep showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            //相册选取
            //实例化图片选择器
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            //判断系统是否支持打开相册
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                picker.delegate = self;
                [self presentViewController:picker animated:YES completion:nil];
            }
            break;
        }
        case 1:
        {
            //相机选取
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                UIImagePickerController *camara = [[UIImagePickerController alloc]init];
                camara.sourceType = UIImagePickerControllerSourceTypeCamera;
                //允许编辑系统相册
                camara.allowsEditing = YES;
                camara.delegate = self;
                [self presentViewController:camara animated:YES completion:nil];
                
            }else
            {
                //不支持拍照
                NSLog(@"不支持拍照");
            }
            break;
        }
        case 2:
        {
            //取消
            break;
        }
        default:
            break;
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if(picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary)
    {
        
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        
        [_touxiang setBackgroundImage:image forState:UIControlStateNormal];
        
        [_touxiang setTitle:@"" forState:UIControlStateNormal];
        
        [picker dismissViewControllerAnimated:YES completion:nil];
    }else if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
                //存到自己的沙盒
                NSDateFormatter *format = [[NSDateFormatter alloc]init];
                format.dateFormat = @"yyyyMMddhhmmss";
                NSString *imageName = [NSString stringWithFormat:@"%@.jpg",[format stringFromDate:[NSDate date]]];
                 NSString *basePath = [NSString stringWithFormat:@"%@/Documents/ImageCaches%@",NSHomeDirectory(),imageName];
                NSFileManager *manager = [NSFileManager defaultManager];
                BOOL hasFilePath = [manager fileExistsAtPath:basePath];
                if (hasFilePath == NO) {
                    [manager createFileAtPath:basePath contents:nil attributes:nil];
                }
        
                NSData *data = UIImageJPEGRepresentation(image, 1);
                [data writeToFile:basePath atomically:YES];
        
//        将图片保存到相册
//        1.要保存的图片
//        2.完成后执行的对象
//        3.完成后调用的方法
//        4.预留接口
                UIImageWriteToSavedPhotosAlbum(image,self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
    
}

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    if (error) {
        //没存进去，有错
        //错误描述
        NSLog(@"%@",error.localizedDescription);
    }
}

-(void)bigBtnClick{
    NSLog(@"3");
}
-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, HEIGHT-69) style:UITableViewStyleGrouped];
    
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.bounces = NO;
    _tableView.sectionHeaderHeight = 3;
    _tableView.sectionFooterHeight = 3;
    _tableView.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1];
    [_tableView registerClass:[LPHFiveTableViewCell class] forCellReuseIdentifier:@"LPHFiveTableViewCell"];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    LPHFiveGroupModel *group = self.groups[section];
    return group.groupArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LPHFiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LPHFiveTableViewCell"];
    if(cell == nil)
    {
        cell = [[LPHFiveTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LPHFiveTableViewCell"];
    }
    LPHFiveGroupModel *group = self.groups[indexPath.section];
    cell.model = group.groupArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
    if(indexPath.section == 0)
    {
        
    }else if(indexPath.section == 1)
    {
        
    }else
    {
        
    }
}
@end
