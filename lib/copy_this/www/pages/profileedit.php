<?php
require_once(WWW_DIR."/lib/category.php");
require_once(WWW_DIR."/lib/sabnzbd.php");
require_once(WWW_DIR."/lib/nzbget.php");
require_once(WWW_DIR."/lib/util.php");

$category = new Category;
$sab = new SABnzbd($page);
$nzbGet = new NZBGet($page);

if (!$users->isLoggedIn())
	$page->show403();

$action = isset($_REQUEST['action']) ? $_REQUEST['action'] : 'view';

$userid = $users->currentUserId();
$data = $users->getById($userid);
if (!$data)
	$page->show404();
	
$errorStr = '';

switch($action) 
{
	case 'newapikey':
		$users->updateRssKey($userid);
		header("Location: profileedit" );
		break;
	case 'clearcookies':
		$sab->unsetCookie();
		header("Location: profileedit" );
		break;
	case 'submit':
		
		$data["email"] = $_POST['email'];
		if (isset($_POST['saburl']) && strlen(trim($_POST['saburl'])) > 0 && !endsWith($_POST['saburl'], "/"))
			$_POST['saburl'] = $_POST['saburl']."/";
		
		if ($_POST['password']!= "" && $_POST['password'] != $_POST['confirmpassword'])
		{
			$errorStr = "Password Mismatch";
		}
		else
		{
			if ($_POST['password']!= "" && !$users->isValidPassword($_POST['password']))
			{
				$errorStr = "Your password must be longer than five characters.";
			}
			else
			{
				if (!$users->isValidEmail($_POST['email']))
					$errorStr = "Your email is not a valid format.";
				else
				{
					$res = $users->getByEmail($_POST['email']);
					if ($res && $res["ID"] != $userid)
						$errorStr = "Sorry, the email is already in use.";
					else
					{
						if (isset($_POST['sabsetting']) && $_POST['sabsetting'] == 2)
						{
							$sab->setCookie($_POST['saburl'], $_POST['sabapikey'], $_POST['sabpriority'], $_POST['sabapikeytype']);
							$_POST['saburl'] = $_POST['sabapikey'] = $_POST['sabpriority'] = $_POST['sabapikeytype'] = false;
						}
						
						$users->update($userid, $data["username"], $_POST['email'], $data["grabs"], $data["role"], $data["notes"], $data["invites"], (isset($_POST['movieview']) ? "1" : "0"), (isset($_POST['musicview']) ? "1" : "0"), (isset($_POST['consoleview']) ? "1" : "0"), (isset($_POST['bookview']) ? "1" : "0"), (isset($_POST['saburl']) ? $_POST['saburl'] : false), (isset($_POST['sabapikey']) ? $_POST['sabapikey'] : false), (isset($_POST['sabpriority']) ? $_POST['sabpriority'] : false), (isset($_POST['sabapikeytype']) ? $_POST['sabapikeytype'] : false), (isset($_POST['nzbvortex_server_url']) ? $_POST['nzbvortex_server_url'] : false), (isset($_POST['nzbvortex_api_key']) ? $_POST['nzbvortex_api_key'] : false), (isset($_POST['nzbgeturl']) ? $_POST['nzbgeturl'] : ''), (isset($_POST['nzbgetusername']) ? $_POST['nzbgetusername'] : ''), (isset($_POST['nzbgetpassword']) ? $_POST['nzbgetpassword'] : ''));
						
						$_POST['exccat'] = (!isset($_POST['exccat']) || !is_array($_POST['exccat'])) ? array() : $_POST['exccat'];
						$users->addCategoryExclusions($userid, $_POST['exccat']);

						if ($_POST['password'] != "")
							$users->updatePassword($userid, $_POST['password']);
						
						header("Location:".WWW_TOP."/profile");
						die();
					}
				}
			}
		}
		break;
		
	break;
	case 'view':
	default:				
	break;   
}

$page->smarty->assign('error', $errorStr);
$page->smarty->assign('user', $data);
$page->smarty->assign('userexccat', $users->getCategoryExclusion($userid));

$page->smarty->assign('saburl_selected', $sab->url);
$page->smarty->assign('sabapikey_selected', $sab->apikey);

$page->smarty->assign('sabapikeytype_ids', array(SABnzbd::API_TYPE_NZB,SABnzbd::API_TYPE_FULL));
$page->smarty->assign('sabapikeytype_names', array( 'Nzb Api Key', 'Full Api Key'));
$page->smarty->assign('sabapikeytype_selected', ($sab->apikeytype == '')?SABnzbd::API_TYPE_NZB:$sab->apikeytype);

$page->smarty->assign('sabpriority_ids', array(SABnzbd::PRIORITY_FORCE, SABnzbd::PRIORITY_HIGH, SABnzbd::PRIORITY_NORMAL, SABnzbd::PRIORITY_LOW, SABnzbd::PRIORITY_PAUSED));
$page->smarty->assign('sabpriority_names', array( 'Force', 'High', 'Normal', 'Low', 'Paused'));
$page->smarty->assign('sabpriority_selected', ($sab->priority == '')?SABnzbd::PRIORITY_NORMAL:$sab->priority);

$page->smarty->assign('sabsetting_ids', array(1,2));
$page->smarty->assign('sabsetting_names', array( 'Site', 'Cookie'));
$page->smarty->assign('sabsetting_selected', ($sab->checkCookie()===true?2:1));

$page->meta_title = "Edit User Profile";
$page->meta_keywords = "edit,profile,user,details";
$page->meta_description = "Edit User Profile for ".$data["username"] ;


$page->smarty->assign('catlist',$category->getForSelect(false));

$page->content = $page->smarty->fetch('profileedit.tpl');
$page->render();


