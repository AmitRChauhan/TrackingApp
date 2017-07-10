//
//  SlideVC.m
//  SmartMedic
//
//  Created by Vmoksha on 07/04/16.
//  Copyright © 2016 amit. All rights reserved.
//

#import "SlideVC.h"
#import "SlideTableCell.h"
#import "SWRevealViewController.h"
#import "ViewController.h"


@interface SlideVC () <UITableViewDelegate,UITableViewDataSource,SWRevealViewControllerDelegate>

{
  
    NSMutableArray *dataArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SlideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    
    [self aDataArray];
}

-(void)viewWillAppear:(BOOL)animated{
    
    if (self.dataMobject == nil)
    {
        self.dataMobject = [dataArray firstObject];
        
    }
    
    [super viewWillAppear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 1;
}


-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SlideTableCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
     DataModel *modelObj = [dataArray objectAtIndex:indexPath.row];
    
    UILabel *theLabel1=(UILabel *)[cell viewWithTag:100];
    theLabel1.text=modelObj.slideLabel;
    
    UIImageView *imageIcon = (UIImageView *)[cell viewWithTag:101];
    imageIcon.image = [UIImage imageNamed:modelObj.slideImage];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==0) {
        
        [self performSegueWithIdentifier:@"homeSegue" sender:nil];
        
    }
    
    else if (indexPath.row==1)
    {
         [self performSegueWithIdentifier:@"profileSegue" sender:nil];
       
        
    }
    else if (indexPath.row==2)
    {
        [self performSegueWithIdentifier:@"fleetSegue" sender:nil];
    }
    else if (indexPath.row==3)
    {
        [self performSegueWithIdentifier:@"aboutusSegue" sender:nil];
    }
    else{
        
       // [self performSegueWithIdentifier:@"contactsegue" sender:nil];
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)  return 64.0f;
    else return 64.0f;
    return 0;
}


-(NSArray *)aDataArray
{
    
    
    dataArray=[[NSMutableArray alloc]init];
    DataModel *dataModelObj=[DataModel new];
    
    dataModelObj.slideLabel=@"Home";
    dataModelObj.slideImage=@"home";
    [dataArray addObject:dataModelObj];
    
    
    dataModelObj=[DataModel new];
    dataModelObj.slideLabel=@"Profile";
    dataModelObj.slideImage=@"profile";
    [dataArray addObject:dataModelObj];
 
    
    dataModelObj=[DataModel new];
    dataModelObj.slideLabel=@"Fleet";
    dataModelObj.slideImage=@"fleet";
    [dataArray addObject:dataModelObj];
    
    dataModelObj=[DataModel new];
    dataModelObj.slideLabel=@"About Us";
    dataModelObj.slideImage=@"aboutus";
    [dataArray addObject:dataModelObj];
    
    dataModelObj=[DataModel new];
    dataModelObj.slideLabel=@"Logout";
    dataModelObj.slideImage=@"logout";
    [dataArray addObject:dataModelObj];
    

    
    return dataArray;
}



- (IBAction)logOutBtnClicked:(id)sender {
    
    
    
    for (UIViewController *viewC in self.revealViewController.navigationController.viewControllers)
    {
        if ([viewC isKindOfClass:[ViewController class]])
        {
            [self.revealViewController.navigationController popToRootViewControllerAnimated:YES];
            return;
        }
    }
    
    ViewController *loginVC =[self.storyboard instantiateViewControllerWithIdentifier:@"ViewControllerID"];
    [self.revealViewController.navigationController setViewControllers:@[loginVC] animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
