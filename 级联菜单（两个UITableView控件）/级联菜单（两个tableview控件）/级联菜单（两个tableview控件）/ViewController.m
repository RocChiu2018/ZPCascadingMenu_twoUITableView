//
//  ViewController.m
//  级联菜单（两个tableview控件）
//
//  Created by apple on 2016/12/13.
//  Copyright © 2016年 apple. All rights reserved.
//

/**
 级联菜单有多种做法，这个Demo主要是在底层的视图控制器上面加上左右两个UITableView控件，这两个UITableView控件共用一个视图控制器作为数据源和代理；
 如果UIScrollView控件或者它的子类靠近导航栏的话系统会给它自动增加一个64 point的内边距以避免导航栏遮挡它里面的内容，如果UIScrollView控件或者它的子类不靠近导航栏的话则系统不会给它自动增加内边距；
 系统自动给控件增加内边距是系统的一个功能，不能通过在storyboard文件中设置Adjust Scroll View Insets复选框或者在代码中设置automaticallyAdjustsScrollViewInsets属性为NO而改变。
 */
#import "ViewController.h"
#import "ZPCategory.h"

static NSString *ID = @"categoryTableViewCell";
static NSString *ID1 = @"subCategoryTableViewCell";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *categoriesArray;
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *subCategoryTableView;

@end

@implementation ViewController

#pragma mark ————— 懒加载 —————
- (NSArray *)categoriesArray
{
    if (_categoriesArray == nil)
    {
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"categories" ofType:@"plist"]];
        
        NSMutableArray *tempMulArray = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray)
        {
            ZPCategory *category = [ZPCategory categoryWithDict:dict];
            [tempMulArray addObject:category];
        }
        
        _categoriesArray = tempMulArray;
    }
    
    return _categoriesArray;
}

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.categoryTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    [self.subCategoryTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID1];
    
    //程序开始运行时默认选中第0行
    [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark ————— UITableViewDataSource —————
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView)  //左边表格
    {
        return self.categoriesArray.count;
    }else  //右边表格
    {
        //indexPathForSelectedRow属性表示表格选中的是哪一行
        ZPCategory *category = [self.categoriesArray objectAtIndex:self.categoryTableView.indexPathForSelectedRow.row];
        
        return category.subcategories.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        ZPCategory *category = [self.categoriesArray objectAtIndex:indexPath.row];
        cell.imageView.image = [UIImage imageNamed:category.icon];
        cell.imageView.highlightedImage = [UIImage imageNamed:category.highlighted_icon];
        cell.textLabel.text = category.name;
        cell.textLabel.highlightedTextColor = [UIColor greenColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID1];
        
        ZPCategory *category = [self.categoriesArray objectAtIndex:self.categoryTableView.indexPathForSelectedRow.row];
        cell.textLabel.text = [category.subcategories objectAtIndex:indexPath.row];
        
        return cell;
    }
}

#pragma mark ————— UITableViewDelegate —————
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView)
    {
        /**
         调用reloadData方法时就会调用"tableView: numberOfRowsInSection: "方法，在这个方法里面利用indexPathForSelectedRow属性获取最新的被选中的category对象。
         */
        [self.subCategoryTableView reloadData];
    }
}

@end
