//
//  MenuViewController.m
//  TrackingApp
//
//  Created by sumo on 05/07/17.
//  Copyright © 2017 Snowtint Snowtint. All rights reserved.
//

//
//  MenuViewController.m
//  Vow Passenger
//
//  Created by Vinay  on 27/03/17.
//  Copyright © 2017 Innate. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuTableViewCell.h"
#import "ProfileVC.h"
#import "PCUser.h"
#import "MapScreenViewController.h"
#import "ProfileVC.h"



@interface MenuViewController ()
@property (weak, nonatomic) IBOutlet UITableView *menuTbl;
@property (nonatomic, strong) NSArray *menuArr;
@property (nonatomic, strong) NSArray *menuImgs;


@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
       _menuArr =[NSArray arrayWithObjects:@"Home",@"Profile",@"Fleet",@"About Us",@"Logout", nil];
    _menuImgs = [NSArray arrayWithObjects:@"home",@"profile",@"fleet",@"aboutus",@"logout",nil];
    
    self.menuTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
  
    [self setHeaerDetial];
    
   
}


-(void)tapDetected{
    
    [[IDViewControllersManager sharedObject] displayScreen:eProfileView animated:YES];
    
    
    /*  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
     ProfileViewController*Sign = [storyboard instantiateViewControllerWithIdentifier:@"Profile"];
     [self.navigationController pushViewController:Sign animated:YES];
     // [self.revealViewController pushFrontViewController:Sign animated:YES];
     */
}

- (void)resetProfileData
{
    [self setHeaerDetial];
    [self.tableView reloadData];
    
}

-(void)setHeaerDetial
{
//    [_proImg setImage:[UIImage imageNamed:@"profile-box.png"]];
//    
//    NSDictionary *custoemr = [NSDictionary dictionaryWithDictionary:[[PCUserDefaults sharedUserDefaults]UserDetails]];
//    if (custoemr) {
//        PCUser *user = [[PCUser alloc] initWithDictionary:custoemr];
//        
//        if(user !=nil)
//        {
//            self.proLbl.text =   [NSString stringWithFormat:@"%@ %@",user.firstNAme,user.lastNAme];
//            self.Phoneno.text =   user.phoneNumber;
//            
//            if(user.profilePicUrl.length)
//            {
//                [self.proImg sd_setImageWithURL:[NSURL URLWithString:user.profilePicUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                    
//                    
//                }];
//                
//            }
//            
//        }
//    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_menuArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuTableViewCell"];
    cell.menuLbl.text = _menuArr[indexPath.row];
    cell.menuImg.image = [UIImage imageNamed:[_menuImgs objectAtIndex:indexPath.row]];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.tag = indexPath.row;
    if(preSelectedCell != nil && preSelectedCell.tag == [indexPath row])
    {
        [self setCellColor:[UIColor colorWithWhite:0.961 alpha:1.000] ForCell:cell];
        
    }
    else{
        [self setCellColor:[UIColor whiteColor] ForCell:cell];
        
    }
    
//    switch (indexPath.row) {
//        case 3:
//        case 6:
//        case 8:
//        case 10:
//        case 11:
//        {
//            UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0 , CGRectGetWidth(cell.frame),1)] ;
//            [lineImageView setImage:[UIImage imageNamed:@"linedivider.png"]];
//            //            [lineImageView setBackgroundColor:[UIColor redColor]];
//            
//            [lineImageView setContentMode:UIViewContentModeBottom];
//            [lineImageView clipsToBounds];
//            [cell.contentView addSubview:lineImageView];
//            
//        }
//            break;
//            
//        default:{}
//            break;
//    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    // Add your Colour.
    MenuTableViewCell *cell = (MenuTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [self setCellColor:[UIColor colorWithWhite:0.961 alpha:1.000] ForCell:cell];
    //  preSelectedCell = cell;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    // Reset Colour.
    //  MenuTableViewCell *cell = (MenuTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    //  [self setCellColor:[UIColor whiteColor] ForCell:cell];
    
}


- (void)setCellColor:(UIColor *)color ForCell:(UITableViewCell *)cell {
    cell.contentView.backgroundColor = color;
    cell.backgroundColor = color;
}
//- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
//{
//
//    if(indexPath.row  == 0)
//        cell.backgroundColor = [UIColor lightGrayColor];
//
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MenuTableViewCell *cell = (MenuTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    preSelectedCell = cell;
    
    switch (indexPath.row) {
        case 0:
        {
            MapScreenViewController *new = [self.storyboard instantiateViewControllerWithIdentifier:@"MapSign"];
            [self.navigationController pushViewController:new animated:YES];
        }
            break;
        case 1:
        {
            ProfileVC *new = [self.storyboard instantiateViewControllerWithIdentifier:@"profileID"];
            [self.navigationController pushViewController:new animated:YES];

        
        }
            
            break;
        case 2: // fare chart
            [[IDViewControllersManager sharedObject] displayScreen:eFleetView animated:YES];
            break;
        case 3: [[IDViewControllersManager sharedObject] displayScreen:eAboutUsView animated:YES];
            break;
            
        case 4:{
            [[IDViewControllersManager sharedObject] displayScreen:eLogOutView animated:YES];
            
        }
            break;
        default:{
            
        }
            break;
    }
    
    
       
    [tableView reloadData];
    
}
-(void)addGestureRecogniser:(UIView *)proView{
    
    UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Change)];
    [proView addGestureRecognizer:singleTap];
}
-(void)Change{
    
//    [[IDViewControllersManager sharedObject] displayScreen:ePCProfileView animated:YES];
    
}
-(void)callLogoutAction
{
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Logout" message:@"Are You Sure?" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action) {
//        
//        [[PCWebServiceManager sharedInstance] loginOutOnSuccess:^(id json) {
//            NSInteger responseCode = [[json objectForKey:kResponceCode] integerValue];
//            
//            [[PCUserDefaults sharedUserDefaults]setUserLogedinState:NO];
//            
//            [[PCUserDefaults sharedUserDefaults] removeLoginDetails];
//            [[PCLocationManger sharedLocationManager] stopUpdatingLocation];
//            
//            // PCViewController *mainLogin = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewControllerIdentifier"];
//            //  [self.revealViewController pushFrontViewController:mainLogin animated:YES];
//            
//            [self.navigationController popToRootViewControllerAnimated:YES];
//            
//        } error:^(NSError *error) {
//            [[PCErrorHandler sharedErrorHandler] showDetailsOfError:error withDelegate:nil];
//            
//        }];
//        
//    }];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action) {
//        
//    }];
//    [alertController addAction:logoutAction];
//    [alertController addAction:cancelAction];
//    
//    
//    [self.navigationController presentViewController:alertController animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */




- (IBAction)didTapOnHideSlideBar:(id)sender
{
    [[IDViewControllersManager sharedObject] showSideMenu:NO];
    
}


- (IBAction)EditBtn:(id)sender {
    
//    [[IDViewControllersManager sharedObject] displayScreen:ePCProfileView animated:YES];
    
}
@end
